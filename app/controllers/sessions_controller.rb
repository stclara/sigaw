# coding: utf-8
class SessionsController < ApplicationController
  
  skip_before_filter :authorize

  def new
  end

  def create
    user = User.authenticate(params[:email], params[:password])
    if user
      session[:user_id] = user.id
      redirect_to root_url, :notice => "Acesso permitido. Bom trabalho!!"
    else
      flash.now.alert = "Email ou Password inválidos."
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end
  
end
