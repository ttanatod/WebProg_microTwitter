class LikeController < ApplicationController
  include MainConcern

  before_action :set_current_user, only: %i[ like unlike ]
  before_action :set_post, only: %i[ like unlike ]

  def like
    Like.create(post_id: @post.id, user_id: @current_user.id)
    redirect_back(fallback_location: feed_path)
  end

  def unlike
    Like.find_by(post_id: @post.id, user_id: @current_user.id).destroy
    redirect_back(fallback_location: feed_path)
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:post_id].to_i)
    end

    # Only allow a list of trusted parameters through.
    def like_params
      params.require(:post).permit(:post_id)
    end

end
