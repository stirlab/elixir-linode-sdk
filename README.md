# Linode API wrapper

Start of a wrapper for the various APIs available at [Linode](https://www.linode.com)

This uses version 4 of their [API](https://developers.linode.com/v4/introduction).

**NOTE:** Almost nothing in here right now, only very basic functions have been
implemented for their DNS Manager functionality. Pull requests welcome to add
other stuff :)

## Installation (for now)


```elixir
def deps do
  [
    {:linode_sdk, git: "https://github.com/thehunmonkgroup/elixir-linode-sdk.git"},
  ]
end
```

```sh
cp config/config.sample.exs config/config.exs
```

Edit to taste.

