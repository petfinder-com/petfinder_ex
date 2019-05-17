defmodule Petfinder.Animals do
  alias Petfinder.{Auth, Helpers}

  def get_animals(params \\ %{}) do
    token = Auth.get_token(Petfinder.Auth)
    url = "https://api.petfinder.com/v2/animals"

    Helpers.generate_request(:get, url, params, token)
    |> HTTPoison.request()
    |> Helpers.handle_http_response()

  end
end


# request(:get, adsa,adfa)
