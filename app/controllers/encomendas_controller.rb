class EncomendasController < ApplicationController
  load_and_authorize_resource
  before_action :set_encomenda, only: [:show, :update, :destroy]

  # GET /encomendas
  def index
    @encomendas = Encomenda.page(params[:page]).per(15)
  end

  # GET /encomendas/:id
  def show
    render json: @encomenda, include: :produtos
  end

  # POST /encomendas
  def create
    @encomenda = Encomenda.new(encomenda_params)
    produtos_params = params[:produtos_encomendados]

    if @encomenda.save
      produtos_params&.each do |produto_param|
        ProdutoEncomendado.create!(
          encomenda: @encomenda,
          produto_id: produto_param[:produto_id],
          quantidade: produto_param[:quantidade]
        )
      end
      render json: @encomenda, status: :created
    else
      render json: @encomenda.errors, status: :unprocessable_entity
    end
  end

  # PUT /encomendas/:id
  def update
    if @encomenda.update(encomenda_params)
      render json: @encomenda
    else
      render json: @encomenda.errors, status: :unprocessable_entity
    end
  end

  # DELETE /encomendas/:id
  def destroy
    @encomenda.destroy
    head :no_content
  end

  private

  def set_encomenda
    @encomenda = Encomenda.find(params[:id])
  end

  def encomenda_params
    params.require(:encomenda).permit(:nome_do_cliente, :data_de_entrega, :numero_de_contato, :valor_do_pedido, :tipo_de_pagamento, :status)
  end
end
