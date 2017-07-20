use Mix.Config

with file <- "#{Mix.env}.exs" do
  if File.exists?(Path.join(__DIR__, file)) do
    import_config(file)
  end
end
