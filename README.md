# Petfinder

**Petfinder.com API client for Elixir**

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `petfinder` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:petfinder, "~> 0.1.0"}
  ]
end
```

Add application to application list
```elixir
extra_applications: [:logger, :runtime_tools, :petfinder]
```

## Usage
Return a list of animals with no parameters
```elixir
Petfinder.Animals.get_animals()
```

Provide search parameters (documented here: https://www.petfinder.com/developers/v2/docs/#get-animals)
```elixir
query = %{
  "type" => "Dog",
  "gender" => "male",
  "location" => 37849
}
Petfinder.Animals.get_animals(query)
```

