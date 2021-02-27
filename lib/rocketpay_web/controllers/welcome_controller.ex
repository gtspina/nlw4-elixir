defmodule RocketpayWeb.WelcomeController do
  use RocketpayWeb, :controller

  alias Rocketpay.Numbers

  def index(conn, %{"filename" => filename}) do
    filename
    |> Numbers.sum_from_file()
    |> handle_response(conn)
  end

  def handle_response({:ok, %{result: result}}, conn) do
    conn
    |> IO.inspect()
    |> put_status(:ok)
    |> json(%{message: "Welcome to Rocketpay API. Here is your phone number #{result}"})
  end

  def handle_response({:error, reason}, conn) do
    conn
    |> put_status(:bad_request)
    |> json(reason)
  end
end
