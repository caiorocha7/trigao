# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.2].define(version: 2024_10_31_120410) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "encomendas", force: :cascade do |t|
    t.string "nome_do_cliente"
    t.datetime "data_de_entrega"
    t.string "numero_de_contato"
    t.decimal "valor_do_pedido"
    t.string "tipo_de_pagamento"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status"
  end

  create_table "produto_encomendados", force: :cascade do |t|
    t.bigint "encomenda_id", null: false
    t.bigint "produto_id", null: false
    t.integer "quantidade"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["encomenda_id"], name: "index_produto_encomendados_on_encomenda_id"
    t.index ["produto_id"], name: "index_produto_encomendados_on_produto_id"
  end

  create_table "produtos", force: :cascade do |t|
    t.string "codigo", null: false
    t.string "nome", null: false
    t.string "secao"
    t.decimal "preco", precision: 8, scale: 2, default: "0.0"
    t.string "unidade"
    t.integer "quantidade", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["codigo"], name: "index_produtos_on_codigo", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "tipo_de_usuario", default: 0
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "produto_encomendados", "encomendas"
  add_foreign_key "produto_encomendados", "produtos"
end
