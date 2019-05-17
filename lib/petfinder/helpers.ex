defmodule Petfinder.Helpers do
  alias Petfinder.Auth

  def handle_http_response({:ok, %{status_code: 200, body: body}}), do: {:ok, Poison.decode!(body)}
  def handle_http_response({:ok, %{status_code: 404}}), do: {:error, "Not found :("}
  def handle_http_response({:ok, %{reason: reason}}), do: {:error, IO.inspect reason}

  def generate_request(url, :post, body) do
    %HTTPoison.Request{
      method: :post,
      url: url,
      options: [ssl: [{:versions, [:"tlsv1.2"]}]],
      headers: [{"content-type", "application/x-www-form-urlencoded"}],
      body: body
    }
  end

  def generate_request(url, :get, params) do
    token = Auth.get_token(Petfinder.Auth)
    %HTTPoison.Request{
      method: :get,
      url: url,
      options: [ssl: [{:versions, [:"tlsv1.2"]}]],
      headers: [{"Authorization", "Bearer #{token}"}],
      params: params
    }
  end

  def process_get(url, params \\ %{}) do
    url
    |> generate_request(:get, params)
    |> HTTPoison.request()
    |> handle_http_response()
  end
end


