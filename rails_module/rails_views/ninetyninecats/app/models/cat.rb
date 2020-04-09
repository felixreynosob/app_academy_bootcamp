class Cat < ApplicationRecord
  @@COLOR_TYPES = %w{grey black white brown ginger}

  validates :birth_date, :name, :description, presence: true
  validates :color, inclusion: { in: @@COLOR_TYPES, message: "Color must be in the following list: ['grey', 'black', 'white', 'brown', 'ginger']." }
  validates :sex, inclusion: { in: ['M', 'F', 'm', 'f'], message: "The gender of the cat must be either male or female." }

  def age
    age = birth_date.to_time - Time.now
    [60, 60, 24, 365].each { |t| age /= t }
    age.abs.to_i #returns age in years
  end

  def self.colors
    @@COLOR_TYPES
  end
end
