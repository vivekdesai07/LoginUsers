class SessionsController < ApplicationController

  before_filter :authenticate_user, only: [:home, :profile, :setting]
  before_filter :save_login_state, only: [:login, :login_attempt]

  def login
    @page_title = "LoginUser | Entrar"
  end

  def login_attempt
    authorized_user = User.authenticate(params[:email_as_login], params[:login_password])
    if authorized_user
      session[:user_id] = authorized_user.id
      flash[:notice] = "Benvindo de volta #{authorized_user.username}"
      redirect_to sessions_home_path
    else
      flash.now[:error] = "Email ou palavra passe inválida!"
      render 'sessions/login'
    end
  end

  def home
  end

  def profile
  end

  def setting
  end

  def logout
    session[:user_id] = nil
    redirect_to sessions_login_path
  end

end
