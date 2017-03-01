defmodule MariaexIssue.Product do
  use Ecto.Schema

  schema "products" do
    field :name, :string, null: false
    field :inventory, :integer, null: false
  end
end