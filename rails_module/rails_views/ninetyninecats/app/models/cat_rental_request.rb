class CatRentalRequest < ApplicationRecord
  @@STATUS_CODES = ['PENDING', 'DENIED', 'APPROVED']
  validates :cat_id, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :status, inclusion: { in: @@STATUS_CODES }

  belongs_to :cat, primary_key: :id, foreign_key: :cat_id, class_name: 'Cat'

  def overlapping_requests
    CatRentalRequest
      .where.not(id: self.id)
      .where(cat_id: self.cat_id)
      .where.not(':start_date > end_date OR :end_date < start_date',
         start_date: self.start_date, end_date: self.end_date,)
  end

  def overlapping_approved_requests
    overlapping_requests.where(' status = \'APPROVED\'')
  end

  def overlapping_pending_requests
    overlapping_requests.where(' status = \'PENDING\'')
  end

  def does_not_overlap_approved_request
    return if self.denied?
    unless overlapping_approved_requests.empty?
      errors[:base] <<  'Request conflicts with existing approved request'
    end
  end

  def does_not_overlap_approved_request
    overlapping_approved_requests.empty?
  end

  def approve!
    transaction do
      self.status = 'APPROVED'
      self.save
      overlapping_pending_requests.update_all(status: 'DENIED')
    end
  end

  def deny!
    self.update_attributes(status: 'DENIED')
  end

  def denied?
    self.status == 'DENIED'
  end

  def pending?
    self.status == 'PENDING'
  end

  def cat
    Cat.find(self.cat_id)
  end
end
