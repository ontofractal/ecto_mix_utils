defmodule Mix.Tasks.EctoUtils.DropWithActiveConnections do
  use Mix.Task
  import Mix.Ecto
  import Mix.EctoSQL

  @impl Mix.Task
  def run(args) do
    repos = parse_repo(args)

    Enum.each(repos, fn repo ->
      ensure_repo(repo, [])
      {:ok, _pid, _apps} = ensure_started(repo, [])
      drop_with_active_connections(repo)
    end)
  end

  def drop_with_active_connections(repo) do
    app = Mix.Project.config()[:app]
    config = Application.get_env(app, repo)
    database = config[:database]

    repo.query("UPDATE pg_database SET datallowconn = 'false' WHERE datname = $1; ", [database])
    repo.query("ALTER DATABASE #{database} CONNECTION LIMIT 0; ")

    repo.query("SELECT pg_terminate_backend(pid) FROM pg_stat_activity WHERE datname = $1;", [
      database
    ])

    case repo.__adapter__.storage_down(repo.config) do
      :ok -> Mix.shell().info("Database #{database} dropped successfully")
      _ -> Mix.shell().info("Something went wrong...")
    end
  end
end
