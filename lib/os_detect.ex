defmodule OsDetect do
  @moduledoc """
  A fast and User Agent parser which only returns the operating system.
  """

  alias OsDetect.Patterns

  @doc """
  Parse the operating system from a user-agent string

  ## Examples

      iex> OsDetect.parse("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.116 Safari/537.36")
      "macos"
      iex> OsDetect.parse("Mozilla/5.0 (Linux; Android 10; Pixel 3 XL Build/QQ3A.200605.001; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/83.0.4103.106 Mobile Safari/537.36 GSA/11.18.11.21.arm64")
      "android"
      iex> OsDetect.parse("Mozilla/5.0 (iPhone; CPU iPhone OS 10_3_2 like Mac OS X) AppleWebKit/603.2.4 (KHTML}, like Gecko) FxiOS/7.5b3349 Mobile/14F89 Safari/603.2.4")
      "ios"
  """
  @spec parse(user_agent :: binary() | nil) :: operating_system :: binary() | nil
  def parse(nil), do: nil

  def parse(user_agent) do
    sanitized = sanitize(user_agent)

    case extract(sanitized) do
      extracted when is_binary(extracted) -> extracted
      nil -> parse_os(sanitized, Patterns.list())
    end
  end

  defp parse_os(user_agent, patterns) do
    patterns
    |> search(user_agent)
    |> downcase()
    |> normalize()
  end

  defp sanitize(user_agent), do: user_agent |> String.trim()

  defp search([], _string), do: nil

  defp search([%{regex: regex} | groups], string) do
    case Regex.run(regex, string) do
      [_, match | _] -> match
      [match] -> match
      nil -> search(groups, string)
    end
  end

  defp normalize(nil), do: nil
  defp normalize("mac os x"), do: "macos"
  defp normalize("cros"), do: "chrome os"
  defp normalize("ubuntu"), do: "linux"
  defp normalize("fedora"), do: "linux"
  defp normalize("debian"), do: "linux"
  defp normalize(other), do: other

  defp downcase(str) when is_binary(str), do: String.downcase(str)
  defp downcase(other), do: other

  defp extract(<<"Android", _rest::binary()>>), do: "android"
  defp extract(<<"iPhone", _rest::binary()>>), do: "ios"
  defp extract(<<"iPad", _rest::binary()>>), do: "ios"
  defp extract(<<"iPod", _rest::binary()>>), do: "ios"
  defp extract(<<"Macintosh", _rest::binary()>>), do: "macos"
  defp extract(<<"Windows Phone", _rest::binary()>>), do: "windows phone"
  defp extract(<<"Windows Mobile", _rest::binary()>>), do: "windows phone"
  defp extract(<<"Windows NT", _rest::binary()>>), do: "windows"
  defp extract(<<_::binary-size(1), rest::binary()>>), do: extract(rest)
  defp extract(""), do: nil
end
