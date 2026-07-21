class UserSharesController < ApplicationController
    allow_browser versions: {}
    skip_before_action :authenticate_user!

    def show
        user = User.find_by(id: params[:id])
        set_meta_tags og: { image: ogp_image_url(id: user.id) }, twitter: { card: 'summary_large_image', image: ogp_image_url(id: user.id) }
    end
end