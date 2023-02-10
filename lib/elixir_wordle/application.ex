defmodule ElixirWordle.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      ElixirWordleWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: ElixirWordle.PubSub},
      # Start Finch
      {Finch, name: ElixirWordle.Finch},
      # Start the Endpoint (http/https)
      ElixirWordleWeb.Endpoint
      # Start a worker by calling: ElixirWordle.Worker.start_link(arg)
      # {ElixirWordle.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ElixirWordle.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ElixirWordleWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
