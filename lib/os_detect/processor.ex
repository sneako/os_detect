defmodule OsDetect.Processor do
  @moduledoc false

  # Prepares a raw YAML document for consumption by the parser by
  # converting charlists into strings and compiling our patterns.

  def process(document) do
    document
    |> extract()
    |> convert()
    |> compile()
  end

  defp extract([document | _]) do
    [_, {'os_parsers', os}, _] = document

    os
  end

  defp convert(list) do
    Enum.map(list, fn [{'regex', v} | _] -> {:regex, to_string(v)} end)
  end

  defp compile(groups) do
    Enum.map(groups, &compile_group/1)
  end

  defp compile_group({:regex, pattern}) do
    regex = Regex.compile!(pattern)

    %{regex: regex}
  end
end
