class UsersController < ApplicationController
  def new
    @user = User.new
    @page_title = "LoginUser | Novo"
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "A sua conta foi criada com sucesso!"
      flash[:color] = "valid"
    else
      flash[:notice] = "Existem erros no formulário!"
      flash[:color] = "invalid"
      render 'new'
    end
  end

end
