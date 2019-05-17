defmodule Petfinder.Organizations do
  alias Petfinder.Helpers

  @base_url Application.fetch_env!(:petfinder, :base_url)

  def get_organizations(params \\ %{}) do
    "#{@base_url}/v2/organizations"
    |> Helpers.process_get(params)
  end

  def get_organization_by_id(org_id) do
    "#{@base_url}/v2/organizations/#{org_id}"
    |> Helpers.process_get()
  end
end
