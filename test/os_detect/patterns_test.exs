defmodule OsDetect.PatternsTest do
  use ExUnit.Case

  test "lists storage contents" do
    assert [%{regex: regex} | _] = OsDetect.Patterns.list()
    assert Regex.regex?(regex)
  end
end
