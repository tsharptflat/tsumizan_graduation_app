class UserWallet < ApplicationRecord
    belongs_to :user

    def self.find_or_create_wallet(user)
        find_or_create_by!(user_id: user.id)
    end
end
