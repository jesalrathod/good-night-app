class Api::V1::FollowsController < Api::V1::BaseApiController
  def create
    follower = User.find_or_create_by(name: params[:follower_name])
    followee = User.find_or_create_by(name: params[:followee_name])

    if follower == followee
      render json: { error: 'Cannot follow yourself' }, status: :unprocessable_entity
      return
    end

    if follower.follow(followee)
      render json: [follower, followee].to_json, status: :created
    else
      render json_errors: follower.errors, status: :unprocessable_entity
    end
  end

  def destroy
    follower = User.find_by(name: params[:follower_name])
    followee = User.find_by(name: params[:followee_name])
    if follower.unfollow(followee)
      render json: {}, status: :no_content
    else
      render json_errors: follower.errors, status: :unprocessable_entity
    end
  end
end
