defmodule Petfinder.MixProject do
  use Mix.Project

  def project do
    [
      app: :petfinder,
      version: "0.1.1",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: package()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Petfinder.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:httpoison, "~> 1.5"},
      {:poison, "4.0.0"},
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false}
    ]
  end

  defp package do
    [
      name: :petfinder,
      description: "API client for the petfinder.com 2.0 REST API",
      licenses: ["BSD 3-Clause"],
      links: %{
        "GitHub" => "https://github.com/petfinder-com/petfinder_ex"
      }
    ]
  end
end
