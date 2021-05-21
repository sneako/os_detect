defmodule OsDetect do
  @moduledoc """
  A fast and User Agent parser which only returns the operating system.
  """

  alias OsDetect.Result

  @doc """
  Parse the operating system, browser and platform type from a user-agent string.

  ## Examples

      iex> OsDetect.parse("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.116 Safari/537.36")
      %OsDetect.Result{browser: "chrome", os: "mac os", type: :desktop}
      iex> OsDetect.parse("Mozilla/5.0 (Linux; Android 10; Pixel 3 XL Build/QQ3A.200605.001; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/83.0.4103.106 Mobile Safari/537.36 GSA/11.18.11.21.arm64")
      %OsDetect.Result{browser: "webview", os: "android", type: :mobile}
      iex> OsDetect.parse("Mozilla/5.0 (iPhone; CPU iPhone OS 10_3_2 like Mac OS X) AppleWebKit/603.2.4 (KHTML}, like Gecko) FxiOS/7.5b3349 Mobile/14F89 Safari/603.2.4")
      %OsDetect.Result{browser: "firefox", os: "ios", type: :mobile}
  """
  @spec parse(user_agent :: binary()) :: Result.t()
  def parse(<<"Python/", _::binary()>>), do: %Result{type: :bot}
  def parse(<<"curl/", _::binary()>>), do: %Result{type: :bot}
  def parse(<<"akka-http/", _::binary()>>), do: %Result{type: :bot}
  def parse(<<"okhttp/", _::binary()>>), do: %Result{type: :bot}
  def parse(<<"Apache", _::binary()>>), do: %Result{type: :bot}
  def parse("site24x7"), do: %Result{type: :bot}

  def parse(user_agent) when is_binary(user_agent) and byte_size(user_agent) >= 10 do
    with {:ok, acc, rest} <- extract_os(user_agent),
         {:ok, acc, rest} <- extract_browser(acc, rest),
         {:ok, acc} <- complete(acc, rest) do
      acc
    else
      {:done, result} -> result
      {:error, :bot} -> %Result{type: :bot}
      _ -> %Result{type: :unknown}
    end
  end

  def parse(_), do: %Result{type: :unknown}

  defp extract_os(<<"Mozilla/5.0 (Mobile; Windows Phone", rest::binary()>>),
    do: {:ok, %Result{type: :mobile, os: "windows phone"}, rest}

  defp extract_os(<<"Mozilla/5.0 (Mobile;", rest::binary()>>),
    do: {:ok, %Result{type: :mobile, os: "firefox os"}, rest}

  defp extract_os(<<"Mozilla/5.0 (Tablet;", rest::binary()>>),
    do: {:ok, %Result{type: :tablet, os: "firefox os"}, rest}

  # skip ahead
  defp extract_os(<<"Mozilla/4.0 ", rest::binary()>>), do: extract_os(rest)
  defp extract_os(<<"Mozilla/5.0 ", rest::binary()>>), do: extract_os(rest)

  defp extract_os(<<"Android", rest::binary()>>),
    do: {:ok, %Result{type: :mobile, os: "android", browser: "webview"}, rest}

  defp extract_os(<<"android", rest::binary()>>),
    do: {:ok, %Result{type: :mobile, os: "android", browser: "webview"}, rest}

  defp extract_os(<<"diordnA", rest::binary()>>),
    do: {:ok, %Result{type: :mobile, os: "android", browser: "webview"}, rest}

  defp extract_os(<<"Dalvik", rest::binary()>>),
    do: {:ok, %Result{type: :mobile, os: "android", browser: "webview"}, rest}

  defp extract_os(<<"iPhone", rest::binary()>>),
    do: {:ok, %Result{type: :mobile, os: "ios", browser: "webview"}, rest}

  defp extract_os(<<"iPad", rest::binary()>>),
    do: {:ok, %Result{type: :tablet, os: "ios", browser: "webview"}, rest}

  defp extract_os(<<"iPod", rest::binary()>>),
    do: {:ok, %Result{type: :mobile, os: "ios", browser: "webview"}, rest}

  defp extract_os(<<"Macintosh", rest::binary()>>),
    do: {:ok, %Result{type: :desktop, os: "mac os"}, rest}

  defp extract_os(<<"Windows Phone", rest::binary()>>),
    do: {:ok, %Result{type: :mobile, os: "windows phone"}, rest}

  defp extract_os(<<"Windows Mobile", rest::binary()>>),
    do: {:ok, %Result{type: :mobile, os: "windows phone"}, rest}

  defp extract_os(<<"Windows NT", rest::binary()>>),
    do: {:ok, %Result{type: :desktop, os: "windows"}, rest}

  defp extract_os(<<"WinNT", rest::binary()>>),
    do: {:ok, %Result{type: :desktop, os: "windows"}, rest}

  defp extract_os(<<"Windows 10", rest::binary()>>),
    do: {:ok, %Result{type: :desktop, os: "windows"}, rest}

  defp extract_os(<<"Windows; U; Win95;", rest::binary()>>),
    do: {:ok, %Result{type: :desktop, os: "windows"}, rest}

  defp extract_os(<<"Windows; U; Win98;", rest::binary()>>),
    do: {:ok, %Result{type: :desktop, os: "windows"}, rest}

  defp extract_os(<<"Windows; U; Win 9", rest::binary()>>),
    do: {:ok, %Result{type: :desktop, os: "windows"}, rest}

  defp extract_os(<<"Windows 9", rest::binary()>>),
    do: {:ok, %Result{type: :desktop, os: "windows"}, rest}

  defp extract_os(<<"IEMobile", rest::binary()>>),
    do: {:ok, %Result{type: :mobile, os: "windows phone", browser: "ie"}, rest}

  defp extract_os(<<" moto ", rest::binary()>>),
    do: {:ok, %Result{type: :mobile, os: "android"}, rest}

  defp extract_os(<<" Pixel ", rest::binary()>>),
    do: {:ok, %Result{type: :mobile, os: "android"}, rest}

  defp extract_os(<<"CrKey", _::binary()>>), do: smart_tv("chromecast")
  defp extract_os(<<"Apple TV", _::binary()>>), do: smart_tv("apple tv")
  defp extract_os(<<"AppleTV", _::binary()>>), do: smart_tv("apple tv")
  defp extract_os(<<"appletv", _::binary()>>), do: smart_tv("apple tv")
  defp extract_os(<<"tvOS", _::binary()>>), do: smart_tv("apple tv")
  defp extract_os(<<"Roku", _::binary()>>), do: smart_tv("roku")
  defp extract_os(<<"roku", _::binary()>>), do: smart_tv("roku")
  defp extract_os(<<"PlayStation", _::binary()>>), do: smart_tv("playstation")
  defp extract_os(<<"PLAYSTATION", _::binary()>>), do: smart_tv("playstation")
  defp extract_os(<<"PS3Application", _::binary()>>), do: smart_tv("playstation")
  defp extract_os(<<"SMART-TV", _::binary()>>), do: smart_tv("tizen")
  defp extract_os(<<"TSBNetTV", _::binary()>>), do: smart_tv("toshiba")
  defp extract_os(<<"GoogleTV", _::binary()>>), do: smart_tv("android tv")
  defp extract_os(<<"BenQ", _::binary()>>), do: smart_tv("benq")
  defp extract_os(<<" LG SimpleSmart.TV", _::binary()>>), do: smart_tv("lg")
  defp extract_os(<<"Philips", _::binary()>>), do: smart_tv("philips")
  defp extract_os(<<"TPM1", _::binary()>>), do: smart_tv("philips")
  defp extract_os(<<"QM16", _::binary()>>), do: smart_tv("philips")
  defp extract_os(<<"NetCast", _::binary()>>), do: smart_tv("netcast")
  defp extract_os(<<"Verizon_STB", _::binary()>>), do: smart_tv("verizon stb")
  defp extract_os(<<"TiVo", _::binary()>>), do: smart_tv("tivo")
  defp extract_os(<<"Funai", _::binary()>>), do: smart_tv("funai")
  defp extract_os(<<"Vestel", _::binary()>>), do: smart_tv("vestel")
  defp extract_os(<<"SonyCEBrowser", _::binary()>>), do: smart_tv("sony bravia")
  defp extract_os(<<"Plex", _::binary()>>), do: smart_tv("plex")
  defp extract_os(<<"Zeasn", _::binary()>>), do: smart_tv("zeasn")
  defp extract_os(<<"SHIVAKI", _::binary()>>), do: smart_tv("shivaki")
  defp extract_os(<<"HbbTV", _::binary()>>), do: smart_tv("hbbtv")
  defp extract_os(<<"Web0S", _::binary()>>), do: smart_tv("web os")
  defp extract_os(<<"webOS", _::binary()>>), do: smart_tv("web os")

  defp extract_os(<<"Tizen", _::binary-size(6), "SmartHub", _::binary()>>),
    do: smart_tv("tizen")

  defp extract_os(<<"Tizen", _::binary-size(6), "SAMSUNG", rest::binary()>>),
    do: {:ok, %Result{type: :mobile, os: "tizen"}, rest}

  defp extract_os(<<"Tizen", rest::binary()>>),
    do: {:ok, %Result{type: :mobile, os: "tizen"}, rest}

  defp extract_os(<<"(X11; CrOS", rest::binary()>>),
    do: {:ok, %Result{type: :desktop, os: "chrome os"}, rest}

  defp extract_os(<<"(Wayland;", rest::binary()>>),
    do: {:ok, %Result{type: :desktop, os: "linux"}, rest}

  defp extract_os(<<"(Darwin; FreeBSD", rest::binary()>>),
    do: {:ok, %Result{type: :desktop, os: "freebsd"}, rest}

  defp extract_os(<<"(X11; FreeBSD", rest::binary()>>),
    do: {:ok, %Result{type: :desktop, os: "freebsd"}, rest}

  defp extract_os(<<"(X11;", rest::binary()>>),
    do: {:ok, %Result{type: :desktop, os: "linux"}, rest}

  defp extract_os(<<"(Linux; U; X11;", rest::binary()>>),
    do: {:ok, %Result{type: :desktop, os: "linux"}, rest}

  defp extract_os(<<"OS/2; Warp", rest::binary()>>),
    do: {:ok, %Result{type: :desktop, os: "os/2"}, rest}

  defp extract_os(<<"Linux; Ubuntu", rest::binary()>>),
    do: {:ok, %Result{type: :desktop, os: "linux"}, rest}

  defp extract_os(<<"Linux x86_64", rest::binary()>>),
    do: {:ok, %Result{type: :desktop, os: "linux"}, rest}

  defp extract_os(<<"Linux; x86_64", rest::binary()>>),
    do: {:ok, %Result{type: :desktop, os: "linux"}, rest}

  defp extract_os(<<"Linux aarch64", rest::binary()>>),
    do: {:ok, %Result{type: :desktop, os: "linux"}, rest}

  defp extract_os(<<"(Unknown; Linux)", rest::binary()>>),
    do: {:ok, %Result{type: :desktop, os: "linux"}, rest}

  defp extract_os(<<"[FBAN/FBIOS", _::binary()>>),
    do: {:done, %Result{type: :mobile, os: "ios", browser: "webview"}}

  defp extract_os(<<"[FBAN/", _::binary()>>),
    do: {:done, %Result{type: :mobile, os: "android", browser: "webview"}}

  defp extract_os(<<"Commscope", _::binary()>>), do: smart_tv("commscope")
  defp extract_os(<<"Hisense", _::binary()>>), do: smart_tv("hisense")
  defp extract_os(<<"BRAVIA", _::binary()>>), do: smart_tv("sony bravia")
  defp extract_os(<<"VIZIO", _::binary()>>), do: smart_tv("vizio")
  defp extract_os(<<"Vizio", _::binary()>>), do: smart_tv("vizio")
  defp extract_os(<<"Viera", _::binary()>>), do: smart_tv("panasonic")
  defp extract_os(<<"Air TV", _::binary()>>), do: smart_tv("air tv")
  defp extract_os(<<"AOC_TV", _::binary()>>), do: smart_tv("aoc tv")
  defp extract_os(<<"BrightSign", _::binary()>>), do: smart_tv("brightsign")

  defp extract_os(<<"BlackBerry", rest::binary()>>),
    do: {:ok, %Result{type: :mobile, os: "blackberry"}, rest}

  defp extract_os(<<"(BB10; ", rest::binary()>>),
    do: {:ok, %Result{type: :mobile, os: "blackberry"}, rest}

  defp extract_os(<<"Xbox", _::binary()>>), do: smart_tv("xbox")

  defp extract_os(<<"Sailfish", rest::binary()>>),
    do: {:ok, %Result{type: :mobile, os: "sailfish"}, rest}

  defp extract_os(<<"(Linux;)", rest::binary()>>),
    do: {:ok, %Result{type: :desktop, os: "linux"}, rest}

  defp extract_os(<<"(Linux)", rest::binary()>>),
    do: {:ok, %Result{type: :desktop, os: "linux"}, rest}

  defp extract_os(<<"pearOS", rest::binary()>>),
    do: {:ok, %Result{type: :desktop, os: "linux"}, rest}

  defp extract_os(<<"CFNetwork", _::binary()>>),
    do: {:done, %Result{type: :mobile, os: "ios", browser: "webview"}}

  defp extract_os(<<"Konqueror", _::binary()>>),
    do: {:done, %Result{browser: "konqueror", type: :desktop, os: "unknown"}}

  defp extract_os(<<"Lynx", _::binary()>>),
    do: {:done, %Result{browser: "lynx", type: :desktop, os: "unknown"}}

  defp extract_os(<<"jp.co.yahoo.android.ybrowser", rest::binary()>>),
    do: {:ok, %Result{os: "android", browser: "yahoo", type: :mobile}, rest}

  defp extract_os(<<"Kindle", rest::binary()>>),
    do: {:ok, %Result{os: "kindle fire", type: :tablet}, rest}

  defp extract_os(<<"; KFT", rest::binary()>>),
    do: {:ok, %Result{os: "kindle fire", type: :tablet}, rest}

  defp extract_os(<<"; KFOT", rest::binary()>>),
    do: {:ok, %Result{os: "kindle fire", type: :tablet}, rest}

  defp extract_os(<<"; KFJWI", rest::binary()>>),
    do: {:ok, %Result{os: "kindle fire", type: :tablet}, rest}

  defp extract_os(<<"Nintendo Switch", _::binary()>>),
    do: {:done, %Result{os: "nintendo switch", browser: "nintendo", type: :other}}

  defp extract_os(<<"Nokia", _::binary()>>),
    do: {:done, %Result{os: "nokia", browser: "nokia", type: :mobile}}

  defp extract_os(<<"TV Fire", _::binary()>>), do: smart_tv("fire tv")

  # bots
  defp extract_os(<<"Googlebot", _::binary()>>), do: {:error, :bot}
  defp extract_os(<<"Applebot", _::binary()>>), do: {:error, :bot}
  defp extract_os(<<"AdsBot", _::binary()>>), do: {:error, :bot}
  defp extract_os(<<"Bingbot", _::binary()>>), do: {:error, :bot}
  defp extract_os(<<"bingbot", _::binary()>>), do: {:error, :bot}
  defp extract_os(<<"Slurp", _::binary()>>), do: {:error, :bot}
  defp extract_os(<<"DuckDuckBot", _::binary()>>), do: {:error, :bot}
  defp extract_os(<<"Baiduspider", _::binary()>>), do: {:error, :bot}
  defp extract_os(<<"YandexBot", _::binary()>>), do: {:error, :bot}
  defp extract_os(<<"YandexAccessibilityBot", _::binary()>>), do: {:error, :bot}
  defp extract_os(<<"Crawler", _::binary()>>), do: {:error, :bot}
  defp extract_os(<<"Sogou", _::binary()>>), do: {:error, :bot}
  defp extract_os(<<"Yahoo Ad monitoring", _::binary()>>), do: {:error, :bot}
  defp extract_os(<<"AhrefsBot", _::binary()>>), do: {:error, :bot}
  defp extract_os(<<"APIs-Google", _::binary()>>), do: {:error, :bot}
  defp extract_os(<<"Mediapartners-Google", _::binary()>>), do: {:error, :bot}
  defp extract_os(<<"FeedFetcher-Google", _::binary()>>), do: {:error, :bot}
  defp extract_os(<<"google-speakr", _::binary()>>), do: {:error, :bot}
  defp extract_os(<<"Google Favicon", _::binary()>>), do: {:error, :bot}
  defp extract_os(<<"Storebot-Google", _::binary()>>), do: {:error, :bot}
  defp extract_os(<<"Google Wireless Transcoder", _::binary()>>), do: {:error, :bot}
  defp extract_os(<<"MicroAdBot", _::binary()>>), do: {:error, :bot}
  defp extract_os(<<"PetalBot", _::binary()>>), do: {:error, :bot}
  defp extract_os(<<"PhantomJS", _::binary()>>), do: {:error, :bot}
  defp extract_os(<<"AddSearchBot", _::binary()>>), do: {:error, :bot}
  defp extract_os(<<"TweetmemeBot", _::binary()>>), do: {:error, :bot}
  defp extract_os(<<"AccompanyBot", _::binary()>>), do: {:error, :bot}
  defp extract_os(<<"NinjBot", _::binary()>>), do: {:error, :bot}
  defp extract_os(<<"Botify", _::binary()>>), do: {:error, :bot}
  defp extract_os(<<"Squidbot", _::binary()>>), do: {:error, :bot}
  defp extract_os(<<"MAZBot", _::binary()>>), do: {:error, :bot}
  defp extract_os(<<"iSec_Bot", _::binary()>>), do: {:error, :bot}
  defp extract_os(<<"GoogleAdwordsExpress", _::binary()>>), do: {:error, :bot}
  defp extract_os(<<"facebookexternalhit", _::binary()>>), do: {:error, :bot}
  defp extract_os(<<"Pinterestbot", _::binary()>>), do: {:error, :bot}
  defp extract_os(<<"screaming frog", _::binary()>>), do: {:error, :bot}
  defp extract_os(<<"; Yeti/", _::binary()>>), do: {:error, :bot}
  defp extract_os(<<"Cincraw", _::binary()>>), do: {:error, :bot}
  defp extract_os(<<"W3C_CSS_Validator", _::binary()>>), do: {:error, :bot}
  defp extract_os(<<"KantarSifoMediaAuditBot", _::binary()>>), do: {:error, :bot}
  defp extract_os(<<" Spider/", _::binary()>>), do: {:error, :bot}

  defp extract_os(<<_::binary-size(1), rest::binary()>>), do: extract_os(rest)
  defp extract_os(""), do: {:error, :unknown}

  defp extract_browser(acc, <<"; wv)", rest::binary()>>),
    do: {:ok, %{acc | browser: "webview"}, rest}

  defp extract_browser(acc, <<"WKWebView", rest::binary()>>),
    do: {:ok, %{acc | browser: "webview"}, rest}

  defp extract_browser(acc, <<"FxiOS", rest::binary()>>),
    do: {:ok, %{acc | browser: "firefox"}, rest}

  defp extract_browser(acc, <<"SamsungBrowser", rest::binary()>>),
    do: {:ok, %{acc | browser: "samsung browser"}, rest}

  defp extract_browser(_, <<"Android TV", _::binary()>>), do: smart_tv("android tv")
  defp extract_browser(_, <<"ZIDOO", _::binary()>>), do: smart_tv("android tv")
  defp extract_browser(_, <<"NEXBOX", _::binary()>>), do: smart_tv("android tv")
  defp extract_browser(_, <<"XBOX", _::binary()>>), do: smart_tv("xbox")
  defp extract_browser(_, <<"; AFT", _::binary()>>), do: smart_tv("fire tv")
  defp extract_browser(_, <<"BRAVIA", _::binary()>>), do: smart_tv("sony bravia")

  defp extract_browser(acc, <<"UCBrowser", rest::binary()>>),
    do: {:ok, %{acc | browser: "uc browser"}, rest}

  defp extract_browser(_, <<"Chromebook", rest::binary()>>),
    do: extract_browser(%Result{os: "chrome os", browser: "chrome", type: :desktop}, rest)

  defp extract_browser(acc, <<"Chrome", rest::binary()>>),
    do: {:ok, %{acc | browser: "chrome"}, rest}

  defp extract_browser(%{os: "ios"} = acc, <<"Safari", rest::binary()>>),
    do: {:ok, %{acc | browser: "safari"}, rest}

  defp extract_browser(%{os: "mac os"} = acc, <<"Safari", rest::binary()>>),
    do: {:ok, %{acc | browser: "safari"}, rest}

  defp extract_browser(acc, <<"CriOS", rest::binary()>>),
    do: {:ok, %{acc | browser: "chrome"}, rest}

  defp extract_browser(acc, <<"Gecko", rest::binary()>>),
    do: {:ok, %{acc | browser: "firefox"}, rest}

  defp extract_browser(acc, <<"Focus", rest::binary()>>),
    do: {:ok, %{acc | browser: "firefox"}, rest}

  defp extract_browser(acc, <<"; SM-T", rest::binary()>>),
    do: extract_browser(%{acc | type: :tablet}, rest)

  defp extract_browser(acc, <<"SAMSUNG-SM-T", rest::binary()>>),
    do: extract_browser(%{acc | type: :tablet}, rest)

  defp extract_browser(acc, <<"SAMSUNG SM-T", rest::binary()>>),
    do: extract_browser(%{acc | type: :tablet}, rest)

  defp extract_browser(acc, <<"; SM-P", rest::binary()>>),
    do: extract_browser(%{acc | type: :tablet}, rest)

  defp extract_browser(acc, <<"Trident", rest::binary()>>),
    do: {:ok, %{acc | browser: "ie"}, rest}

  defp extract_browser(acc, <<"Opera", rest::binary()>>),
    do: {:ok, %{acc | browser: "opera"}, rest}

  defp extract_browser(acc, <<"Presto", rest::binary()>>),
    do: {:ok, %{acc | browser: "opera"}, rest}

  defp extract_browser(acc, <<"OPT/", rest::binary()>>),
    do: {:ok, %{acc | browser: "opera"}, rest}

  defp extract_browser(acc, <<"OPiOS", rest::binary()>>),
    do: {:ok, %{acc | browser: "opera"}, rest}

  defp extract_browser(acc, <<"DuckDuckGo/", rest::binary()>>),
    do: {:ok, %{acc | browser: "duckduckgo"}, rest}

  defp extract_browser(acc, <<"TizenBrowser", rest::binary()>>),
    do: {:ok, %{acc | browser: "tizen browser"}, rest}

  defp extract_browser(_, <<"FamilyHub", _::binary()>>),
    do: {:done, %Result{type: :other, browser: "samsung family hub", os: "tizen"}}

  defp extract_browser(acc, <<"coc_coc_browser", rest::binary()>>),
    do: {:ok, %{acc | browser: "coc coc"}, rest}

  defp extract_browser(acc, <<"like Android", rest::binary()>>),
    do: {:ok, %{acc | browser: "android browser"}, rest}

  defp extract_browser(%{os: "linux"}, <<" WPE", _::binary()>>),
    do: smart_tv("generic set top box")

  defp extract_browser(%{os: "android"}, <<"CTV STB", _::binary()>>), do: smart_tv("android tv")

  defp extract_browser(acc, <<"BlackBerry", rest::binary()>>),
    do: {:ok, %{acc | browser: "blackberry"}, rest}

  defp extract_browser(_, <<"BBB", _::binary()>>),
    do: {:done, %Result{os: "blackberry", browser: "blackberry", type: :mobile}}

  defp extract_browser(acc, <<"Flipboard", rest::binary()>>),
    do: {:ok, %{acc | browser: "flipboard"}, rest}

  defp extract_browser(acc, <<"freeridegamesPlayer", rest::binary()>>),
    do: {:ok, %{acc | browser: "freeridegamesplayer"}, rest}

  defp extract_browser(acc, <<"QwantiOS", rest::binary()>>),
    do: {:ok, %{acc | browser: "qwant"}, rest}

  defp extract_browser(acc, <<"; Tablet; rv", rest::binary()>>),
    do: extract_browser(%{acc | type: :tablet}, rest)

  defp extract_browser(_, <<"Kindle Fire", rest::binary()>>),
    do: extract_browser(%Result{os: "kindle fire", browser: "webview", type: :tablet}, rest)

  defp extract_browser(%{os: "kindle fire"} = acc, <<"Silk", rest::binary()>>),
    do: {:ok, %{acc | browser: "silk"}, rest}

  defp extract_browser(acc, <<"; KFM", rest::binary()>>),
    do: extract_browser(%{acc | os: "kindle fire", type: :tablet}, rest)

  defp extract_browser(%{os: "tizen"}, <<" TV ", _::binary()>>), do: smart_tv("tizen")

  defp extract_browser(_, <<"Xbox", _::binary()>>), do: smart_tv("xbox")
  defp extract_browser(_, <<"HeadlessChrome", _::binary()>>), do: {:error, :bot}
  defp extract_browser(_, <<"PhantomJS", _::binary()>>), do: {:error, :bot}
  defp extract_browser(_, <<"Googlebot", _::binary()>>), do: {:error, :bot}
  defp extract_browser(_, <<"Mediapartners-Google", _::binary()>>), do: {:error, :bot}
  defp extract_browser(_, <<"DuplexWeb-Google", _::binary()>>), do: {:error, :bot}
  defp extract_browser(_, <<"googleweblight", _::binary()>>), do: {:error, :bot}
  defp extract_browser(_, <<"Storebot-Google", _::binary()>>), do: {:error, :bot}
  defp extract_browser(_, <<"Google-Read-Aloud", _::binary()>>), do: {:error, :bot}
  defp extract_browser(_, <<"MicroAdBot", _::binary()>>), do: {:error, :bot}
  defp extract_browser(_, <<" Bot ", _::binary()>>), do: {:error, :bot}
  defp extract_browser(_, <<" jigsawpuzzle/", _::binary()>>), do: {:error, :bot}

  # skip ahead
  defp extract_browser(os, <<"like Gecko", rest::binary()>>), do: extract_browser(os, rest)

  defp extract_browser(os, <<_::binary-size(1), rest::binary()>>), do: extract_browser(os, rest)

  defp extract_browser(%{os: "blackberry"} = acc, ""),
    do: {:ok, %{acc | browser: "blackberry"}, ""}

  defp extract_browser(acc, ""), do: {:ok, acc, ""}

  defp complete(_, <<"Googlebot", _::binary()>>), do: {:error, :bot}
  defp complete(_, <<"AdsBot", _::binary()>>), do: {:error, :bot}
  defp complete(_, <<"Google-Read-Aloud", _::binary()>>), do: {:error, :bot}
  defp complete(_, <<"Google Favicon", _::binary()>>), do: {:error, :bot}
  defp complete(_, <<"Applebot", _::binary()>>), do: {:error, :bot}
  defp complete(_, <<"MicroAdBot", _::binary()>>), do: {:error, :bot}
  defp complete(_, <<"YandexMobileBot", _::binary()>>), do: {:error, :bot}
  defp complete(_, <<"TiggeritoBot", _::binary()>>), do: {:error, :bot}
  defp complete(_, <<"moatbot", _::binary()>>), do: {:error, :bot}
  defp complete(_, <<"jigsawpuzzle", _::binary()>>), do: {:error, :bot}

  defp complete(acc, <<"Edge/", rest::binary()>>), do: complete(%{acc | browser: "edge"}, rest)
  defp complete(acc, <<"Edg/", rest::binary()>>), do: complete(%{acc | browser: "edge"}, rest)
  defp complete(acc, <<"EdgiOS", rest::binary()>>), do: complete(%{acc | browser: "edge"}, rest)
  defp complete(acc, <<"EdgA", rest::binary()>>), do: complete(%{acc | browser: "edge"}, rest)

  defp complete(acc, <<"KAIOS", rest::binary()>>), do: complete(%{acc | os: "kai os"}, rest)
  defp complete(acc, <<"Kai/", rest::binary()>>), do: complete(%{acc | os: "kai os"}, rest)

  defp complete(%{os: "linux"}, <<"Philips", _::binary()>>), do: smart_tv("philips")

  defp complete(_, <<"GoogleTV/", rest::binary()>>),
    do: complete(%Result{os: "googletv", browser: "googletv", type: :smart_tv}, rest)

  defp complete(acc, <<"Skyfire/", rest::binary()>>),
    do: complete(%{acc | browser: "skyfire"}, rest)

  defp complete(acc, <<"Pafari", rest::binary()>>),
    do: complete(%{acc | browser: "pafari"}, rest)

  defp complete(acc, <<"Microsoft Outlook", rest::binary()>>),
    do: complete(%{acc | browser: "outlook"}, rest)

  defp complete(acc, <<"YaBrowser", rest::binary()>>),
    do: complete(%{acc | browser: "yandex browser"}, rest)

  defp complete(acc, <<"QwantMobile", rest::binary()>>),
    do: complete(%{acc | browser: "qwant"}, rest)

  defp complete(acc, <<"QwantBrowser", rest::binary()>>),
    do: complete(%{acc | browser: "qwant"}, rest)

  defp complete(acc, <<" OPR/", rest::binary()>>), do: complete(%{acc | browser: "opera"}, rest)
  defp complete(acc, <<" Tablet ", rest::binary()>>), do: complete(%{acc | type: :tablet}, rest)
  defp complete(_, <<" CrKey", _::binary()>>), do: smart_tv("chromecast")

  defp complete(acc, <<_::binary-size(1), rest::binary()>>), do: complete(acc, rest)
  defp complete(acc, ""), do: {:ok, acc}

  defp smart_tv(os) do
    {:done, %Result{type: :smart_tv, os: os, browser: os}}
  end
end
