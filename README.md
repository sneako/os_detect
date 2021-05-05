# OsDetect

A simple, fast user-agent parsing library.

It is much faster than other user agent parsing libraries because it users
binary pattern matching for many common cases, and it *only* returns the
operating system name, browser name, and a type atom.

It can also detect most types of bots/scrapers that are not actively trying to
hide their identities.

See [OsDetect.Result](/lib/os_detect/result.ex) for all possible types.

Most other libraries tend to be purely regex based and return more information,
much more slowly.

## Installation

Add `os_detect` to your `mix.exs` dependencies:

```elixir
def deps do
  [
    {:os_detect, "~> 0.2.0"}
  ]
end
```

## Usage

```elixir
OsDetect.parse("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.116 Safari/537.36")
%OsDetect.Result{browser: "chrome", os: "mac os", type: :desktop}
```
