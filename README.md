# OsDetect

A simple, fast user-agent parsing library based on BrowserScope's UA database.

This started as a fork of beam-community/ua_parser, stripped down to only return the operating system family. 

It is much faster than other user agent parsing libraries because it users binary pattern matching for many common cases, and it *only* returns the operating system name where as other libraries tend to be purely regex based and return much more information.

## Installation

Add `ua_parser` to your `mix.exs` dependencies:

```elixir
def deps do
  [
    {:os_detect, "~> 0.1.0"}
  ]
end
```

## Usage

```elixir
iex> ua = OsDetect.parse("Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_5_7; en-us) AppleWebKit/530.17 (KHTML, like Gecko) Version/4.0 Safari/530.17 Skyfire/2.0")
"macos"
```
