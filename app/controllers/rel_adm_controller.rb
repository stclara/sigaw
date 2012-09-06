# coding: utf-8
class RelAdmController < ApplicationController
  
  before_filter :authorize_adm
  
   RGhost::Config::GS[:path] = '/usr/local/bin/gs'
   RGhost::Config::GS[:external_encoding]= 'ascii-8bit'
  
  def rel_user_show
  end

  def rel_user
    n_rel = 'Usuarios'
    d_rel = DateTime.now.utc
    param_rel = d_rel.strftime("%d%m%y%H%M%S")
    arq_rel = n_rel << param_rel << current_user.mail
    path_rel = "#{Rails.root}/public/Relatorios/"
     
    @users = User.all(:order => params[:pesquisa] )
    
    doc = RGhost::Document.new :paper => :A4, :margin => [3.5, 1, 2.5, 1] #=>[top,right,bottom,left] #:rows_per_page => 50
    
    doc.before_page_create do |d|
      d.image "#{Rails.root}/app/assets/images/siga.eps"
      d.text_in :text => "RELATÓRIO DE USUÁRIOS", :x => 8, :y => 26.8, :with => :bold
      d.text_in :text => "Página %current_page%", :x => 10, :y => 0.80, :with => :normal
      d.text_in :text =>"Emitido por SIG@W - Sistema de Gestão @dministrativa Web em " <<  DateTime.now.strftime("%d/%m/%Y - %H:%M:%S") << ' - ' << current_user.mail, :x => 3.5, :y => 1.2, :with => :normal
    end

   doc.grid :data => @users do |g|
     g.column :name, :title => "USUÁRIO", :align => :left, :width => 6
     g.column :mail, :title => "EMAIL", :align => :left, :width => 6
     g.column :adm, :title => "ADM", :align => :center, :width => 1
     g.column :ger, :title => "GER", :align => :center, :width => 1 
     g.column :opr, :title => "OPR", :align => :center, :width => 1  
     g.column :est, :title => "EST", :align => :center, :width => 1
     g.column :cxa, :title => "CXA", :align => :center, :width => 1
     g.column :pag, :title => "PAG", :align => :center, :width => 1
     g.column :rec, :title => "REC", :align => :center, :width => 1    
  end
  
  doc.render :pdf, :filename => "#{Rails.root}/public/Relatorios/#{arq_rel}.pdf"
  conn = ActiveRecord::Base.connection
  conn.execute "INSERT INTO reports (relatorio, arquivo, caminho, created_at, updated_at, email) VALUES ('Usuários', '#{arq_rel}.pdf', '#{path_rel}#{n_rel}.pdf', '#{d_rel}', '#{d_rel}', '#{current_user.mail}')"
  redirect_to reports_url
  end
  
end
