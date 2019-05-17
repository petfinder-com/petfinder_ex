defmodule Petfinder.Auth do

  use GenServer

  alias Petfinder.Auth

  defstruct(
    token_type: nil,
    expires_in: nil,
    access_token: nil
  )

  @base_url Application.fetch_env!(:petfinder, :base_url)
  @client_id  Application.fetch_env!(:petfinder, :oauth_client)
  @client_secret Application.fetch_env!(:petfinder, :oauth_secret)

  ### API functions ###

  def start_link(opts) do
    GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def get_token(server) do
    GenServer.call(server, {:get_token})
  end

  ### Callback functions ###

  def init(:ok) do
    schedule_login(1000)
    {:ok, %{}}
  end

  def handle_call({:get_token}, _from, state) do
    {:reply, Map.get(state, "access_token"), state}
  end

  def handle_info(:login, state) do
    state = login()
    expires_in = Map.get(state, "expires_in")
    # Schedule refresh for halfway through the expiration (divide seconds by 2 and multiply by 1000 because Process.send_after expect ms)
    schedule_login(div(expires_in, 2) * 1000)
    {:noreply, state}
  end

  ### Helpers

  def schedule_login(interval) do
    Process.send_after(self(), :login, interval)
  end

  def login() do
    url = "#{@base_url}/v2/oauth2/token"

    body = %{
      "grant_type" => "client_credentials",
      "client_id" => @client_id,
      "client_secret" => @client_secret,
    }
    request_body = URI.encode_query(body)

    request = %HTTPoison.Request{
      method: :post,
      url: url,
      options: [hackney: [:insecure]],
      body: request_body,
      headers: [{"content-type", "application/x-www-form-urlencoded"}]
    }

    case HTTPoison.request(request) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}}  ->

        %{"token_type" => token_type, "expires_in" => expires_in, "access_token" => access_token} = Poison.decode!(body)
        #access_token

      {:ok, %HTTPoison.Response{status_code: 404}} ->
        IO.puts "Not found :("

      {:error, %HTTPoison.Error{reason: reason}} ->
        IO.inspect reason
    end
  end


end
