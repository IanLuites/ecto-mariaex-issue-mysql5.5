defmodule MariaexIssue.Mixfile do
  use Mix.Project

  def project do
    [app: :mariaex_issue,
     version: "0.1.0",
     elixir: "~> 1.4",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  def application do
    [
      mod: {MariaexIssue, []},
      extra_applications: [:logger, :ecto, :mariaex]
    ]
  end

  defp deps do
    [
      {:ecto, "~> 2.1.3"},
      {:mariaex, ">= 0.0.0"},
    ]
  end
end
