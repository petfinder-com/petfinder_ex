defmodule PetfinderTest do
  use ExUnit.Case
  doctest Petfinder

  test "greets the world" do
    assert Petfinder.hello() == :world
  end
end
