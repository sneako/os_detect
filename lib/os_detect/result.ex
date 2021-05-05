defmodule OsDetect.Result do
  @type t :: %__MODULE__{
          os: binary() | nil,
          browser: binary() | nil,
          type: :mobile | :desktop | :smart_tv | :bot | :tablet | :other | :unknown
        }
  defstruct [:os, browser: "unknown", type: :unknown]
end
