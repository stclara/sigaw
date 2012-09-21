# coding: utf-8
class RelCxaController < ApplicationController
  include ActionView::Helpers::NumberHelper
  
  before_filter :authorize_cxa
  
   RGhost::Config::GS[:path] = '/usr/local/bin/gs'
   RGhost::Config::GS[:external_encoding]= 'ascii-8bit'
  
  def rel_historical_cash_show
  end

  def rel_historical_cash
    n_rel = 'histcaixa'
    d_rel = DateTime.now.utc
    param_rel = d_rel.strftime("%d%m%y%H%M%S")
    arq_rel = n_rel << param_rel << current_user.mail
    path_rel = "#{Rails.root}/public/Relatorios/"
     
    @historical_cashes = HistoricalCash.all(:order => params[:pesquisa] )
    
    doc = RGhost::Document.new :paper => :A4, :margin => [3.5, 1, 2.5, 1] #=>[top,right,bottom,left] #:rows_per_page => 50
    
    doc.before_page_create do |d|
      d.image "#{Rails.root}/app/assets/images/siga.eps"
      d.text_in :text => "RELATÓRIO DE HISTÓRICOS DO CAIXA", :x => 8, :y => 26.8, :with => :bold
      d.text_in :text => "Página %current_page%", :x => 10, :y => 0.80, :with => :normal
      d.text_in :text =>"Emitido por SIG@W - Sistema de Gestão @dministrativa Web em " <<  DateTime.now.strftime("%d/%m/%Y - %H:%M:%S") << ' - ' << current_user.mail, :x => 3.5, :y => 1.2, :with => :normal
    end

   doc.grid :data => @historical_cashes do |g|
     g.column :id, :title => "CÓDIGO", :align => :center, :width => 2
     g.column :description, :title => "DESCRIÇÃO", :align => :left, :width => 15
     g.column :type_cash, :title => "TIPO", :align => :center, :width => 2    
  end
  
  doc.render :pdf, :filename => "#{Rails.root}/public/Relatorios/#{arq_rel}.pdf"
  conn = ActiveRecord::Base.connection
  conn.execute "INSERT INTO reports (relatorio, arquivo, caminho, created_at, updated_at, email) VALUES ('Históricos do Caixa', '#{arq_rel}.pdf', '#{path_rel}#{n_rel}.pdf', '#{d_rel}', '#{d_rel}', '#{current_user.mail}')"
  redirect_to reports_url
  end
  
  def rel_mov_cash
    n_rel = 'relcaixa'
    d_rel = DateTime.now.utc
    param_rel = d_rel.strftime("%d%m%y%H%M%S")
    arq_rel = n_rel << param_rel << current_user.mail
    path_rel = "#{Rails.root}/public/Relatorios/"
    
    @date_cash = DateCash.last
    @data = @date_cash.date_cash
    @cashes = Cash.joins(:historical_cash).where(:date_cash => @data)
    @saldos = SaldoCaixa.find_by_sql(['Select * from saldocaixa(?, ?)', @data, @data])
    
    doc = RGhost::Document.new :paper => :A4, :margin => [3.5, 1, 2.5, 1] #=>[top,right,bottom,left] #:rows_per_page => 50
    
    doc.before_page_create do |d|
      d.image "#{Rails.root}/app/assets/images/siga.eps"
      d.text_in :text => "RELATÓRIO DE MOVIMENTO DO CAIXA - " << @data.strftime("%d/%m/%Y"), :x => 6, :y => 27, :with => :bold
      d.text_in :text => "Página %current_page%", :x => 10, :y => 0.80, :with => :normal
      d.text_in :text =>"Emitido por SIG@W - Sistema de Gestão @dministrativa Web em " <<  DateTime.now.strftime("%d/%m/%Y - %H:%M:%S") << ' - ' << current_user.mail, :x => 3.5, :y => 1.2, :with => :normal
    end
    
    @saldos.each do |s|
      doc.text_in :text =>"Saldo Anterior: " << number_to_currency(s.saldo_anterior), :x => 2, :y => 26.4, :with => :bold 
      doc.text_in :text =>"Débitos: " << number_to_currency(s.debito.to_s), :x => 7, :y => 26.4, :with => :bold
      doc.text_in :text =>"Créditos: " << number_to_currency(s.credito.to_s), :x => 12, :y => 26.4, :with => :bold
      doc.text_in :text =>"Saldo Atual: " << number_to_currency(s.saldo.to_s), :x => 16, :y => 26.4, :with => :bold      
    end 
    
   

   doc.grid :data => @cashes do |c|
     c.column :description, :title => "DESCRIÇÃO", :align => :left, :width => 8
     c.column 'historical_cash.description', :title => "HISTORICO", :align => :left, :width => 8
     c.column :value_cash, :title => "VALOR", :align => :right, :width => 2, :format => lambda{|d| number_to_currency(d)  }
     c.column :type_cash, :title => "TIPO", :align => :center, :width => 1    
  end
  
  doc.render :pdf, :filename => "#{Rails.root}/public/Relatorios/#{arq_rel}.pdf"
  conn = ActiveRecord::Base.connection
  conn.execute "INSERT INTO reports (relatorio, arquivo, caminho, created_at, updated_at, email) VALUES ('Movimento do Caixa', '#{arq_rel}.pdf', '#{path_rel}#{n_rel}.pdf', '#{d_rel}', '#{d_rel}', '#{current_user.mail}')"
  redirect_to reports_url
  end
  
end
