# coding: utf-8
class ApplicationController < ActionController::Base
  
  protect_from_forgery

  before_filter :authorize

  protect_from_forgery

  helper_method :current_user
  
  private
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  protected
  def authorize
    unless User.find_by_id(session[:user_id])
      redirect_to login_url, :alert => "Informe suas credenciais para acesso ao sistema!"
    end
  end  

  def authorize_adm
    unless current_user && current_user.adm == 'SIM'
      redirect_to root_url, :alert => "Desculpe, você não possui permissão para acessar o módulo ADM!"
      return false
    end
    return true
  end

  def authorize_ger
    unless current_user && current_user.ger == 'SIM'
      redirect_to root_url, :alert => "Desculpe, você não possui permissão para acessar o módulo GER!"
    return false
    end
    return true
  end

  def authorize_opr
    unless current_user && current_user.opr == 'SIM'
      redirect_to root_url, :alert => "Desculpe, você não possui permissão para acessar o módulo OPR!"
    return false
    end
    return true
  end

  def authorize_est
    unless current_user && current_user.est == 'SIM'
      redirect_to root_url, :alert => "Desculpe, você não possui permissão para acessar o módulo EST!"
    return false
    end
    return true
  end

  def authorize_cxa
    unless current_user && current_user.cxa == 'SIM'
      redirect_to root_url, :alert => "Desculpe, você não possui permissão para acessar o módulo CXA!"
    return false
    end
    return true
  end

  def authorize_pag
    unless current_user && current_user.pag == 'SIM'
      redirect_to root_url, :alert => "Desculpe, você não possui permissão para acessar o módulo PAG!"
    return false
    end
    return true
  end

 def authorize_rec
    unless current_user && current_user.rec == 'SIM'
      redirect_to root_url, :alert => "Desculpe, você não possui permissão para acessar o módulo REC!"
    return false
    end
    return true
  end
  
end
