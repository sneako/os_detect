defmodule OsDetect.Mixfile do
  use Mix.Project

  @name "OsDetect"
  @version "0.1.2"
  @repo_url "https://github.com/sneako/os_detect"

  def project do
    [
      app: :os_detect,
      elixir: "~> 1.4",
      description: """
        Quickly determine the operating system from user-agent strings with
        binary pattern matching, falling back to BrowserScope patterns for
        completeness.
      """,
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
      {:yamerl, "~> 0.7"},
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
