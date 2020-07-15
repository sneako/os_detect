defmodule OsDetect.ProcessorTest do
  use ExUnit.Case

  alias OsDetect.Processor

  test "converts yaml document into data structure" do
    result = Processor.process(test_data())

    assert is_list(result)
    assert [%{regex: pattern} | _] = result
    assert Regex.regex?(pattern)
  end

  def test_data do
    :os_detect
    |> :code.priv_dir()
    |> Path.join("patterns.yml")
    |> :yamerl_constr.file()
  end
end
