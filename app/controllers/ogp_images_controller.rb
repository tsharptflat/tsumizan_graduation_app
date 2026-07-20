class OgpImagesController < ApplicationController
    skip_before_action :authenticate_user!

    def show
        user = User.find_by(id: params[:id])
        total_price = UserGameLibrary.total_price(user)
        image = Rails.cache.fetch("ogp_image/#{user.id}/#{total_price}") do
            OgpImageService.new(user).generate
        end
        send_data image, type: 'image/png', disposition: 'inline'
    end
end
