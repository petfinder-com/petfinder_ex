defmodule Petfinder.Helpers do
  def handle_http_response({:ok, %{status_code: 200, body: body}}), do: {:ok, Poison.decode!(body)}
  def handle_http_response({:ok, %{status_code: 404}}), do: {:error, "Not found :("}
  def handle_http_response({:ok, %{reason: reason}}), do: {:error, IO.inspect reason}

  def generate_request(:post, url, body) do
    request = %HTTPoison.Request{
      method: :post,
      url: url,
      options: [hackney: [:insecure]],
      headers: [{"content-type", "application/x-www-form-urlencoded"}],
      body: body
    }
  end

  def generate_request(:get, url, params, token) do
    request = %HTTPoison.Request{
      method: :get,
      url: url,
      options: [hackney: [:insecure]],
      headers: [{"Authorization", "Bearer #{token}"}],
      params: params
    }
  end
end


