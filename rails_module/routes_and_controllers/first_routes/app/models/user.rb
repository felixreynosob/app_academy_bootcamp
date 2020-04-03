class User < ApplicationRecord
    validates :name, presence: true
    validates :email, presence: true
    validate  :check_user_name

    def check_user_name
        self.name.each_char do |c| 
            if "0123456789".include?(c) 
                errors[:name] << "can't contain numbers"
                nil
            end
        end
    end
end