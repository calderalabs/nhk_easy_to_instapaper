# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :nhk_easy_to_instapaper, NhkEasyToInstapaper.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Fei4Y2R0wx2Kbg7pN8qnq6gm8frlgYChjWhJbmq2SCIffHa1WcJSDIe+RSKuhj2V",
  render_errors: [view: NhkEasyToInstapaper.ErrorView, accepts: ~w(html json)],
  pubsub: [name: NhkEasyToInstapaper.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :quantum, cron: [
  "2 17 * * *": &NhkEasyToInstapaper.Pusher.push_to_instapaper/0,
],
timezone: "Europe/London"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
