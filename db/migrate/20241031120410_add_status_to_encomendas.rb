class AddStatusToEncomendas < ActiveRecord::Migration[7.2]
  def change
    add_column :encomendas, :status, :string, default: "pendente"
  end
end
