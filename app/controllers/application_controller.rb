class ApplicationController < ActionController::Base

    before_action :configure_permitted_parameters, if: :devise_controller?
    protect_from_forgery with: :exception

    protected
    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
        devise_parameter_sanitizer.permit(:account_update, keys: [:name])
    end

    def after_sign_in_path_for(resource)
        post = Post.find_by(user_id: current_user.id)
        if(post.present?)
            user_path(current_user.id)
        else
            first_post_path
        end
    end

    def after_sign_out_path_for(resource)
        user_session_path
    end

end
