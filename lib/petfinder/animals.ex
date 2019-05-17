defmodule Petfinder.Animals do
  alias Petfinder.Helpers

  @base_url Application.fetch_env!(:petfinder, :base_url)

  def get_animals(params \\ %{}) do
    "#{@base_url}/v2/animals"
    |> Helpers.process_get(params)
  end

  def get_animal_by_id(id) do
    "#{@base_url}/v2/animals/#{id}"
    |> Helpers.process_get()
  end

  def get_animal_types() do
    "#{@base_url}/v2/types"
    |> Helpers.process_get()
  end

  def get_animal_type_by_name(type_name) do
    "#{@base_url}/v2/types/#{type_name}"
    |> Helpers.process_get()
  end


  def get_animal_breeds_for_type(type_name) do
    "#{@base_url}/v2/types/#{type_name}/breeds"
    |> Helpers.process_get()
  end
end

