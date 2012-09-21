# coding: utf-8
class DateCashesController < ApplicationController
  # GET /date_cashes
  # GET /date_cashes.json
  def index
    @date_cash = DateCash.last
  end

  # GET /date_cashes/new
  # GET /date_cashes/new.json
  def new
    @date_cash = DateCash.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @date_cash }
    end
  end

  # POST /date_cashes
  # POST /date_cashes.json
  def create
    @date_cash = DateCash.new(params[:date_cash])

    respond_to do |format|
      if @date_cash.save
        format.html { redirect_to date_cashes_url, notice: 'Data criada com sucesso.' }
        format.json { render json: @date_cash, status: :created, location: @date_cash }
      else
        format.html { render action: "new" }
        format.json { render json: @date_cash.errors, status: :unprocessable_entity }
      end
    end
  end
  
end
