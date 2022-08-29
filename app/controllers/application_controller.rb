class ApplicationController < ActionController::Base
    def after_singn_in_path_for(resource)
        root_path # ログイン後に遷移するpathを設定
    end
    def after_sign_out_path_for(resource)
        root_path # ログアウト後に遷移するpathを設定
    end
    def set_current_user
        @current_user = User.find_by(id: session[:user_id])
    end
end
