class PostsController < ActionController::Base
    before_action :authenticate_user!, only: [:show, :create, :new, :edit, :update, :destroy]

    def index
        @posts = Post.all
    end

    def new
        @post = Post.new #空のインスタンス
    end

    def create
        @post = Post.new(post_params)   
        @post.user_id = current_user.id
        @post.save
        redirect_to action: :show, id: @post.id # 投稿完了に遷移
    end

    def show
        @post = Post.find(params[:id])
        @user = current_user.email
    end

    def edit
        @post = Post.find(params[:id])
        if @post.user_id != current_user.id
            redirect_to root_path, flash: {alert: "Not yours"}
        end
    end

    def update
        @post = Post.find(params[:id])
        if @post.update(post_params)
            redirect_to action: :show, id: @post.id
        else
            render :new
        end
    end

    def destroy
        post = Post.find(params[:id])
        if post.user_id == current_user.id
            post.destroy
        else
            redirect_to root_path, flash: {alert: "Not yours"}
        end
    end

    private
    def post_params #ストロングパラメータ
        params.require(:post).permit(:user_id, :title, :body)#パラメーターのキー
    end
    
end