defmodule Nygma.Repo do
  use Ecto.Repo,
    otp_app: :nygma,
    adapter: Ecto.Adapters.Postgres
end
