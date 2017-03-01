use Mix.Config

config :mariaex_issue, MariaexIssue.Repo,
  adapter: Ecto.Adapters.MySQL,
  url: "mysql://root@localhost/mariex_issue",
  pool_size: 5
