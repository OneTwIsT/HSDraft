use Mix.Config

# In this file, we keep production configuration that
# you likely want to automate and keep it away from
# your version control system.
config :hs_draft, HsDraft.Endpoint,
  secret_key_base: "+akwp//IdKTDT2iSQj12DgGHg0I3xJCezTallkPd3UmoPkY8G4me1ZR69+ekninP"

# Configure your database
config :hs_draft, HsDraft.Repo,
  adapter: Mongo.Ecto,
  database: "hs_draft_prod",
  pool_size: 20
