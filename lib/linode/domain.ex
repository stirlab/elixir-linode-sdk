defmodule Linode.Domain do

  @moduledoc """
  Documentation for Linode.Domain.
  """

  import Linode

  # Domains.
  def get_domains() do
    get("/domains")
  end

  def get_domain(domain) do
    domain_id = get_domain_id(domain)
    if domain_id do
      get("/domains/#{to_string domain_id}")
    end
  end

  def create_domain(domain, soa_email) do
    data = %{
      :domain => domain,
      :type => "master",
      :soa_email => soa_email,
    }
    post("/domains", data)
  end

  def delete_domain(domain) do
    domain_id = get_domain_id(domain)
    if domain_id do
      delete("/domains/#{to_string domain_id}")
    end
  end

  defp get_domain_id(domain) do
    ret = get("/domains")
    domains = ret.body["data"]
    domain_id = Enum.reduce domains, nil, fn(data, id) ->
      if data["domain"] === domain do
        data["id"]
      else
        id
      end
    end
    domain_id
  end

  # Records.
  def get_records(domain) do
    domain_id = get_domain_id(domain)
    if domain_id do
      get("/domains/#{to_string domain_id}/records")
    end
  end

  def get_record(fqdn, type \\ "A") do
    case get_domain_id_record_id(fqdn, type) do
      {domain_id, record_id} ->
        get("/domains/#{to_string domain_id}/records/#{to_string record_id}")
      nil ->
        {:error, "#{fqdn} type #{type} does not exist"}
    end
  end

  def create_record(fqdn, target, type \\ "A") do
    {sub, domain} = split_fqdn(fqdn)
    if sub do
      domain_id = get_domain_id(domain)
      if domain_id do
        data = %{
          :name => sub,
          :target => target,
          :type => type,
        }
        post("/domains/#{to_string domain_id}/records", data)
      end
    end
  end

  def delete_record(fqdn, type \\ "A") do
    case get_domain_id_record_id(fqdn, type) do
      {domain_id, record_id} ->
        delete("/domains/#{to_string domain_id}/records/#{to_string record_id}")
      nil ->
        {:error, "#{fqdn} type #{type} cannot be deleted"}
    end
  end

  defp get_domain_id_record_id(fqdn, type) do
    {sub, domain} = split_fqdn(fqdn)
    if sub do
      domain_id = get_domain_id(domain)
      if domain_id do
        ret = get_records(domain)
        records = ret.body["data"]
        record_id = Enum.reduce records, nil, fn(data, id) ->
          if data["name"] === sub and data["type"] === type do
            data["id"]
          else
            id
          end
        end
        if record_id do
          {domain_id, record_id}
        end
      end
    end
  end

  defp split_fqdn(fqdn) do
    parts = String.split(fqdn, ".")
    domain = Enum.slice(parts, -2..-1)
             |> Enum.join(".")
    sub = Enum.slice(parts, 0..-3)
             |> Enum.join(".")
    if sub === "" do
      {nil, domain}
    else
      {sub, domain}
    end
  end

end
