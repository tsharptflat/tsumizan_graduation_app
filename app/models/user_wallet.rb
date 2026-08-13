class UserWallet < ApplicationRecord
    belongs_to :user

    validates :point, numericality: { greater_than_or_equal_to: 0 }

    def self.find_or_create_wallet(user)
        find_or_create_by!(user_id: user.id)
    end
end
