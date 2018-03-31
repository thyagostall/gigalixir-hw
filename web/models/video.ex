defmodule GigalixirHelloworld.Video do
  use GigalixirHelloworld.Web, :model

  schema "videos" do
    field :url, :string
    field :title, :string
    field :description, :string
    belongs_to :user, GigalixirHelloworld.User, foreign_key: :user_id
    belongs_to :category, GigalixirHelloworld.Category, foreign_key: :category_id

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:url, :title, :description, :category_id])
    |> validate_required([:url, :title, :description])
    |> foreign_key_constraint(:category_id)
  end
end
