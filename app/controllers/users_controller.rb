class UsersController < ApplicationController

  before_filter :save_login_state, only: [:new, :create]

  def new
    @user = User.new
    @page_title = "LoginUser | Novo"
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "Bem vindo #{@user.username}, sua conta foi criada com sucesso!"
      redirect_to sessions_home_path
    else
      @user.errors.full_messages.each do |e|
        if e == "Email has already been taken"
          flash.now[:error] = "Email já está registado!"
        else
          flash.now[:error] = "Corrija os campos do formulário!"
        end
      end
    render 'new'
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end

end
