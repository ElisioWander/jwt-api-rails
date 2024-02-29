class UsersController < ApplicationController
  def create
    @user =  User.create(user_params)
    if @user.valid?
      success_return(@user)
    else
     unsuccess_return
    end
  end

  def login
    #find user in database by username
    @user = User.find_by(username: user_params[:username])

    #check if user exist and if is the correct password
    if @user && @user.authenticate(user_params[:password])
      success_return(@user)
    else
      unsuccess_return
    end

  end

  private

  def success_return(user)
    token = encode_token({ user_id: user.id })
    render json: { user: user, token: token }, status: :ok
  end

  def unsuccess_return
    render json: { error: 'Usuário ou senha inválidos' },
    status: :unprocessable_entity
  end

  def user_params
    params.permit(:username, :password)
  end
end
