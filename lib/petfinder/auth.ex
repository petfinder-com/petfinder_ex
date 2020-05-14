defmodule Petfinder.Auth do
  use GenServer

  alias Petfinder.Helpers

  defstruct(
    token_type: nil,
    expires_in: nil,
    access_token: nil
  )

  ### API functions ###

  def start_link(_opts) do
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

  def handle_info(:login, _state) do
    new_state = login()
    expires_in = Map.get(new_state, "expires_in")

    # Schedule refresh for halfway through the expiration (divide seconds by 2 and multiply by 1000 because Process.send_after expect ms)
    schedule_login(div(expires_in, 2) * 1000)
    {:noreply, new_state}
  end

  ### Helpers
  def schedule_login(interval) do
    Process.send_after(self(), :login, interval)
  end

  def login() do
    body = %{
      "grant_type" => "client_credentials",
      "client_id" => client_id(),
      "client_secret" => client_secret()
    }

    request_body = URI.encode_query(body)

    "#{Helpers.base_url()}/v2/oauth2/token"
    |> Helpers.generate_request(:post, request_body)
    |> HTTPoison.request()
    |> Helpers.handle_http_response()
    |> Petfinder.Auth.get_map()
  end

  def get_map({:ok, auth_response}), do: auth_response

  defp client_id(), do: Application.fetch_env!(:petfinder, :oauth_client)
  defp client_secret(), do: Application.fetch_env!(:petfinder, :oauth_secret)
end
