use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :todo, Todo.Endpoint,
  http: [port: 4001],
  server: false

config :todo,
  salt: "1bd95522-1bed-4ef1-abac-1de3f389d682"

config :guardian, Guardian,
  issuer: "Todo",
  ttl: { 30, :days  },
  secret_key: "kdjfkjdsakjfkasj",
  serializer: Todo.GuardianSerializer

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :todo, Todo.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "todo_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
