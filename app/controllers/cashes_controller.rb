# coding: utf-8
class CashesController < ApplicationController
  
  before_filter :authorize_cxa
  
  # GET /cashes
  # GET /cashes.json
  def index
    @date_cash = DateCash.last
    @data = @date_cash.date_cash
    @cashes = Cash.joins(:historical_cash).where(:date_cash => @data)
    @saldos = SaldoCaixa.find_by_sql(['Select * from saldocaixa(?, ?)', @data, @data])
  end

  # GET /cashes/new
  # GET /cashes/new.json
  def new
    @cash = Cash.new
    @date_cash = DateCash.last
    @data = @date_cash.date_cash

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @cash }
    end
  end

  # GET /cashes/1/edit
  def edit
    @cash = Cash.find(params[:id])
    @date_cash = DateCash.last
    @data = @date_cash.date_cash
    
  end

  # POST /cashes
  # POST /cashes.json
  def create
    @cash = Cash.new(params[:cash])

    respond_to do |format|
      if @cash.save
        format.html { redirect_to cashes_url, notice: 'Lançamento criado com sucesso.' }
        format.json { render json: @cash, status: :created, location: @cash }
      else
        format.html { render action: "new" }
        format.json { render json: @cash.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /cashes/1
  # PUT /cashes/1.json
  def update
    @cash = Cash.find(params[:id])

    respond_to do |format|
      if @cash.update_attributes(params[:cash])
        format.html { redirect_to cashes_url, notice: 'Lançamento alterado com sucesso.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @cash.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cashes/1
  # DELETE /cashes/1.json
  def destroy
    @cash = Cash.find(params[:id])
    @cash.destroy

    respond_to do |format|
      format.html { redirect_to cashes_url, notice: 'Lançamento excluído com sucesso.' }
      format.json { head :no_content }
    end
  end
end
