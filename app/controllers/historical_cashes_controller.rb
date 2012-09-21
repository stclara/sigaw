# coding: utf-8
class HistoricalCashesController < ApplicationController
  
  before_filter :authorize_cxa
  
  # GET /historical_cashes
  # GET /historical_cashes.json
  def index
    if !params[:campo].nil?
      @historical_cashes = HistoricalCash.search(params[:campo], params[:chave], params[:page])
    end
  end

  # GET /historical_cashes/new
  # GET /historical_cashes/new.json
  def new
    @historical_cash = HistoricalCash.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @historical_cash }
    end
  end

  # GET /historical_cashes/1/edit
  def edit
    @historical_cash = HistoricalCash.find(params[:id])
  end

  # POST /historical_cashes
  # POST /historical_cashes.json
  def create
    @historical_cash = HistoricalCash.new(params[:historical_cash])

    respond_to do |format|
      if @historical_cash.save
        format.html { redirect_to historical_cashes, notice: 'Histórico do Caixa criado com sucesso.' }
        format.json { render json: @historical_cash, status: :created, location: @historical_cash }
      else
        format.html { render action: "new" }
        format.json { render json: @historical_cash.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /historical_cashes/1
  # PUT /historical_cashes/1.json
  def update
    @historical_cash = HistoricalCash.find(params[:id])

    respond_to do |format|
      if @historical_cash.update_attributes(params[:historical_cash])
        format.html { redirect_to historical_cashes, notice: 'Histórico do Caixa alterado com sucesso.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @historical_cash.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /historical_cashes/1
  # DELETE /historical_cashes/1.json
  def destroy
    @historical_cash = HistoricalCash.find(params[:id])
    @historical_cash.destroy

    respond_to do |format|
      format.html { redirect_to historical_cashes_url, notice: 'Histórico do Caixa excluído com sucesso.' }
      format.json { head :no_content }
    end
  end
end
