defmodule LinodeTest do
  use ExUnit.Case
  doctest Linode

  test "greets the world" do
    assert Linode.hello() == :world
  end
end
