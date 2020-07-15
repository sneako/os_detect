defmodule OsDetect.Patterns do
  @moduledoc false
  #
  # Load pattern data at compile time. Recompiling the application is necessary after updating the pattern file.

  alias OsDetect.Processor

  Application.start(:yamerl)

  data =
    :os_detect
    |> :code.priv_dir()
    |> Path.join("patterns.yml")
    |> :yamerl_constr.file([])
    |> Processor.process()

  @data data

  def list, do: @data
end
