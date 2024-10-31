class Encomenda < ApplicationRecord
  has_many :produtos_encomendados, class_name: 'ProdutoEncomendado', dependent: :destroy
  has_many :produtos, through: :produtos_encomendados

  # Enum para status
  enum status: { pending: 0, completed: 1, canceled: 2 }

  # Validações
  validates :nome_do_cliente, presence: true
  validates :numero_de_contato, presence: true, format: { with: /\A\d{10,11}\z/, message: "deve ter 10 ou 11 dígitos" }
  validates :valor_do_pedido, numericality: { greater_than_or_equal_to: 0 }
  validates :data_de_entrega, presence: true
  validates :status, inclusion: { in: statuses.keys }

end
