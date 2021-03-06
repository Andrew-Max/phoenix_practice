defmodule Splurty.QuoteController do
  use Phoenix.Controller

  alias Splurty.Router
  import Splurty.Router.Helpers

  plug :action

  def homepage(conn, _params) do
    conn
    |>assign(:x, "xxxxxxxx")
    |>assign(:y, "yyyyyyy")
    |>render("homepage.html")
  end

  def index(conn, _params) do
    conn
    |> assign(:quotes, Repo.all(Splurty.Quote))
    |> render("index.html")
  end

  def new(conn, _params) do
    render conn, "new.html"
  end

  def create(conn, %{"quote" => %{"saying" => saying, "author" => author}}) do
    q = %Splurty.Quote{saying: saying,  author: author}
    Repo.insert(q)

    redirect conn, to: quote_path(conn, :index)
  end

  def show(conn, %{"id" => id}) do
    {id, _} = Integer.parse(id)
    conn
    |> assign(:quote, Repo.get(Splurty.Quote, id))
    |> render("show.html")
  end
end
