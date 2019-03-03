defmodule EctoMixUtilsTest do
  use ExUnit.Case
  doctest EctoMixUtils

  test "greets the world" do
    assert EctoMixUtils.hello() == :world
  end
end
