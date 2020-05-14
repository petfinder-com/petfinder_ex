defmodule Petfinder.Organizations do
  alias Petfinder.Helpers

  def get_organizations(params \\ %{}) do
    "#{Helpers.base_url()}/v2/organizations"
    |> Helpers.process_get(params)
  end

  def get_organization_by_id(org_id) do
    "#{Helpers.base_url()}/v2/organizations/#{org_id}"
    |> Helpers.process_get()
  end
end
