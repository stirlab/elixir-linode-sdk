defmodule LinodeDomainTest do
  use ExUnit.Case
  doctest Linode.Domain

  test "properly splits valid one level subdomain" do
    {sub, domain} = Linode.Domain.split_fqdn("foo.example.com")
    assert sub === "foo"
    assert domain === "example.com"
  end

  test "properly splits valid two level subdomain" do
    {sub, domain} = Linode.Domain.split_fqdn("foo.bar.example.com")
    assert sub === "foo.bar"
    assert domain === "example.com"
  end

  test "properly returns nil for subdomain if not provided" do
    {sub, _domain} = Linode.Domain.split_fqdn("example.com")
    assert sub === nil
  end

end
