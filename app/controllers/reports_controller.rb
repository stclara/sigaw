# coding: utf-8
class ReportsController < ApplicationController
  
  before_filter :destroy
  
  # GET /reports
  # GET /reports.json
  def index
    @reports = Report.all(:conditions => ["email = ?", current_user[:mail]], :order => 'id desc')

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @reports }
    end
  end
  
  # GET /reports/1
  # GET /reports/1.json
  def show
    @mostra_rel = Report.find(params[:id])
    send_file @mostra_rel.caminho, :type => 'application/pdf', :disposition => 'inline'
    #@path_rel= @mostra_rel.arquivo
  end

  # DELETE /reports/1
  # DELETE /reports/1.json
  def destroy
    @tot_reg = Report.count(:conditions => ["email = ?", current_user[:mail]])
    if @tot_reg > 10
      @filepath = Report.find(:first, :conditions => ["email = ?", current_user[:mail]])
      File.delete(@filepath.caminho)
      Report.first(:conditions => ["email = ?", current_user[:mail]]).destroy
    end
  end
end
