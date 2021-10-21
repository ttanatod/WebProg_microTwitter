class MainController < ApplicationController
  include MainConcern

  before_action :is_logged_in, only: %i[ feed profile my_profile new_post] 
  before_action :set_current_user, only: %i[ feed profile my_profile follow unfollow new_post create_post]
  before_action :set_user_by_name, only: %i[ follow unfollow ]

  def login
    if session[:user_id]
      redirect_to feed_path
    end
    @disable_nav = true
  end

  def check_login
    email = params[:login][:email]
    pass = params[:login][:password]
    @user = User.find_by(email: email).authenticate(pass) rescue nil
    # puts "------email #{email.class}---------"
    # puts "------pass #{pass.class}----------"
    if @user
      puts '-----------found------------' 
      session[:user_id] = @user.id
      redirect_to feed_path, flash:{success: "Log in successfully"}
    else
      puts '-----------not found-----------'
      redirect_to main_path, flash:{alert: "Wrong email or password!"}
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to main_path
  end

  def register
    @user = User.new
  end

  def create_user
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to main_path, flash: {success: "User was successfully created." }}
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :register, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def feed
    # @posts = []
    # following_user = @current_user.followees
    # following_user.each { |u| 
    #   @posts += Post.where(user_id: u.id)
    # }
    # @posts = @posts.sort { |a, b| b[:created_at] <=> a[:created_at]}
    @posts = @current_user.get_feed_post
  end

  def profile
    @user = User.find_by(name: params[:name])
    # puts "-------#{Post.first.msg}-------#{Post.first.user_id}--------"
    # puts "-------#{Post.second.msg}-------#{Post.second.user_id}--------"
    if @user == nil
      redirect_to feed_path, flash:{ warn: "User not found"}
      return
    elsif @user.id == session[:user_id]
      redirect_to my_profile_path
      return
    end
    @posts = Post.where(user_id: @user.id).reverse()
    puts "---------#{@posts.count}---------"
  end

  def my_profile
    @posts = Post.where(user_id: session[:user_id]).reverse()
    @user = @current_user
  end

  def follow 
    #@current_user.followees << @user
    # redirect_back(fallback_location: feed_path(@user[:name]))
    Follow.create(follower_id: @current_user.id, followee_id: @user.id)
    redirect_to feed_path, flash:{success: "follow successfully"}
  end

  def unfollow
    #@current_user.followed_users.find_by(followee_id: @user.id).destroy
    # redirect_back(fallback_location: feed_path(@user[:name]))
    Follow.find_by(follower_id: @current_user.id, followee_id: @user.id).destroy
    redirect_to feed_path, flash:{warn: "unfollow successfully"}
  end

  def new_post
    @post = Post.new
  end

  def create_post
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to feed_path, flash: {success: "Post was successfully created." }}
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new_post, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def search_profile
    # redirect_to feed_path(params[:name])
    # redirect_to my_profile_path
    # puts "--------------#{params[:name]}--------------------"
    if params[:name] == ""
      redirect_to feed_path
    else
      redirect_to action: "profile", name: params[:name]
    end
  end

  private

    def user_params
       params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def post_params
      params.require(:post).permit(:msg, :user_id)
    end

end