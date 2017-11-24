defmodule Linode do

  @moduledoc """
  Documentation for Linode.
  """

  use Tesla

  plug Tesla.Middleware.BaseUrl, Application.get_env(:linode_sdk, :api_endpoint)
  plug Tesla.Middleware.Headers, %{"Authorization" => "token " <> Application.get_env(:linode_sdk, :access_token)}
  plug Tesla.Middleware.JSON
  if Application.get_env(:linode_sdk, :debug_http) do
    plug Tesla.Middleware.DebugLogger
  end

end
