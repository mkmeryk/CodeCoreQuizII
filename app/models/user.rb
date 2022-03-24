class User < ApplicationRecord

    has_secure_password

    has_many :ideas, dependent: :destroy
    has_many :reviews, dependent: :destroy


    def full_name
        self.first_name + " " + self.last_name
    end

end
