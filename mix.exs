defmodule OsDetect.Mixfile do
  use Mix.Project

  @name "OsDetect"
  @version "1.0.2"
  @repo_url "https://github.com/sneako/os_detect"

  def project do
    [
      app: :os_detect,
      elixir: "~> 1.4",
      description: "Fast user-agent parsing with binary pattern matching.",
      version: @version,
      package: package(),
      docs: docs(),
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      name: @name,
      source_url: @repo_url,
      deps: deps()
    ]
  end

  defp deps do
    [
      {:ex_doc, ">= 0.0.0", only: :dev}
    ]
  end

  def package do
    [
      licenses: ["MIT"],
      links: %{"GitHub" => @repo_url}
    ]
  end

  def docs do
    [
      source_ref: "v#{@version}",
      source_url: @repo_url,
      main: @name
    ]
  end
end
