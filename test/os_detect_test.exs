defmodule OsDetectTest do
  use ExUnit.Case
  doctest OsDetect

  test "android" do
    [
      "Mozilla/5.0 (Linux; U; Android 4.4.2; en-us; SCH-I535 Build/KOT49H) AppleWebKit/534.30 (KHTML}, like Gecko) Version/4.0 Mobile Safari/534.30",
      "Mozilla/5.0 (Linux; Android 7.0; SM-G930V Build/NRD90M) AppleWebKit/537.36 (KHTML}, like Gecko) Chrome/59.0.3071.125 Mobile Safari/537.36",
      "Mozilla/5.0 (Linux; Android 7.0; SM-A310F Build/NRD90M) AppleWebKit/537.36 (KHTML}, like Gecko) Chrome/55.0.2883.91 Mobile Safari/537.36 OPR/42.7.2246.114996",
      "Opera/9.80 (Android 4.1.2; Linux; Opera Mobi/ADR-1305251841) Presto/2.11.355 Version/12.10",
      "Mozilla/5.0 (Android 7.0; Mobile; rv:54.0) Gecko/54.0 Firefox/54.0",
      "Mozilla/5.0 (Linux; U; Android 7.0; en-US; SM-G935F Build/NRD90M) AppleWebKit/534.30 (KHTML}, like Gecko) Version/4.0 UCBrowser/11.3.8.976 U3/0.8.0 Mobile Safari/534.30",
      "Mozilla/5.0 (Linux; Android 7.0; SAMSUNG SM-G955U Build/NRD90M) AppleWebKit/537.36 (KHTML}, like Gecko) SamsungBrowser/5.4 Chrome/51.0.2704.106 Mobile Safari/537.36",
      "Mozilla/5.0 (Linux; Android 6.0; Lenovo K50a40 Build/MRA58K) AppleWebKit/537.36 (KHTML}, like Gecko) Chrome/57.0.2987.137 YaBrowser/17.4.1.352.00 Mobile Safari/537.36",
      "Mozilla/5.0 (Linux; Android 7.0; SM-G930V Build/NRD90M) AppleWebKit/537.36 (KHTML}, like Gecko) Chrome/59.0.3071.125 Mobile Safari/537.36",
      "Mozilla/5.0 (Linux; Android 10; Pixel 3 XL Build/QQ3A.200605.001; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/83.0.4103.106 Mobile Safari/537.36 GSA/11.18.11.21.arm64"
    ]
    |> Enum.each(fn ua ->
      assert "android" == OsDetect.parse(ua)
    end)
  end

  test "ios" do
    [
      "Mozilla/5.0 (iPhone; CPU iPhone OS 7_1_2 like Mac OS X) AppleWebKit/537.51.2 (KHTML}, like Gecko) OPiOS/10.2.0.93022 Mobile/11D257 Safari/9537.53",
      "Mozilla/5.0 (iPhone; CPU iPhone OS 10_3_2 like Mac OS X) AppleWebKit/603.2.4 (KHTML}, like Gecko) FxiOS/7.5b3349 Mobile/14F89 Safari/603.2.4",
      "Mozilla/5.0 (iPad; CPU OS 7_0 like Mac OS X) AppleWebKit/537.51.1 (KHTML}, like Gecko) Version/7.0 Mobile/11A465 Safari/9537.53",
      "Mozilla/5.0 (iPhone; CPU iPhone OS 6_1_4 like Mac OS X) AppleWebKit/536.26 (KHTML}, like Gecko) Version/6.0 Mobile/10B350 Safari/8536.25"
    ]
    |> Enum.each(fn ua ->
      assert "ios" == OsDetect.parse(ua)
    end)
  end

  test "macos" do
    [
      "Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_5_7; en-us) AppleWebKit/530.17 (KHTML, like Gecko) Version/4.0 Safari/530.17 Skyfire/2.0",
      "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_1) AppleWebKit/600.2.5 (KHTML, like Gecko) Version/8.0.2 Safari/600.2.5 (Applebot/0.1; +http://www.apple.com/go/applebot)",
      "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.116 Safari/537.36",
      "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Safari/605.1.15"
    ]
    |> Enum.each(fn ua ->
      assert "macos" == OsDetect.parse(ua)
    end)
  end

  test "windows" do
    [
      "Mozilla/5.0 CK={} (Windows NT 6.1; WOW64; Trident/7.0; rv:11.0) like Gecko",
      "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.169 Safari/537.36",
      "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1)",
      "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.140 Safari/537.36 Edge/18.17763"
    ]
    |> Enum.each(fn ua ->
      assert "windows" == OsDetect.parse(ua)
    end)
  end

  test "windows phone" do
    [
      "Mozilla/5.0 (Windows Phone 10.0; Android 6.0.1; Microsoft; Lumia 950) AppleWebKit/537.36 (KHTML}, like Gecko) Chrome/52.0.2743.116 Mobile Safari/537.36 Edge/15.14977",
      "Mozilla/5.0 (Windows Mobile 10; Android 8.0.0; Microsoft; Lumia 950XL) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.92 Mobile Safari/537.36 Edge/40.15254.369",
      "Opera/9.80 (Windows Mobile; Opera Mini/5.1.21594/29.3594; U; en) Presto/2.8.119 Version/11.10",
      "Mozilla/5.0 (Mobile; Windows Phone 8.1; Android 4.0; ARM; Trident/7.0; Touch; rv:11.0; IEMobile/11.0; NOKIA; Lumia 630 Dual SIM) like iPhone OS 7_0_3 Mac OS X AppleWebKit/537 (KHTML, like Gecko) Mobile Safari/537",
      "Mozilla/5.0 (Mobile; Windows Phone 8.1; Android 4.0; ARM; Trident/7.0; Touch; rv:11.0; IEMobile/11.0; Microsoft; Lumia 535 Dual SIM) like iPhone OS 7_0_3 Mac OS X AppleWebKit/537 (KHTML, like Gecko) Mobile Safari/537",
      "Mozilla/5.0 (Windows Phone 10.0; Android 6.0.1; ALCATELONETOUCH; FierceXL) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/52.0.2743.116 Mobile Safari/537.36 Edge/15.15254"
    ]
    |> Enum.each(fn ua ->
      assert "windows phone" == OsDetect.parse(ua)
    end)
  end

  test "linux" do
    [
      "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/74.0.3729.157 Safari/537.36",
      "BrightSign/8.0.69 (XT1143)Mozilla/5.0 (X11; Linux armv7l) AppleWebKit/537.36 (KHTML, like Gecko) QtWebEngine/5.11.2 Chrome/65.0.3325.230 Safari/537.36",
      "Apache/2.4.34 (Ubuntu) OpenSSL/1.1.1 (internal dummy connection)",
      "Mozilla/5.0 (X11; Fedora;Linux x86; rv:60.0) Gecko/20100101 Firefox/60.0",
      "Mozilla/5.0 (X11; U; Linux amd64; rv:5.0) Gecko/20100101 Firefox/5.0 (Debian)"
    ]
    |> Enum.each(fn ua ->
      assert "linux" == OsDetect.parse(ua)
    end)
  end

  test "chrome os" do
    [
      "Mozilla/5.0 (X11; CrOS x86_64 12239.92.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/76.0.3809.136 Safari/537.36"
    ]
    |> Enum.each(fn ua ->
      assert "chrome os" == OsDetect.parse(ua)
    end)
  end

  test "unknown" do
    [
      "Opera/9.80 (J2ME/MIDP; Opera Mini/5.1.21214/28.2725; U; ru) Presto/2.8.119 Version/11.10",
      nil
    ]
    |> Enum.each(fn ua ->
      assert ua |> OsDetect.parse() |> is_nil()
    end)
  end

  test "bots" do
    [
      "Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)",
      "Mozilla/5.0 (compatible; Bingbot/2.0; +http://www.bing.com/bingbot.htm)",
      "Mozilla/5.0 (compatible; Yahoo! Slurp; http://help.yahoo.com/help/us/ysearch/slurp)",
      "DuckDuckBot/1.0; (+http://duckduckgo.com/duckduckbot.html)",
      "Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)",
      "Mozilla/5.0 (compatible; YandexBot/3.0; +http://yandex.com/bots)",
      "Sogou web spider/4.0(+http://www.sogou.com/docs/help/webmasters.htm#07)"
    ]
    |> Enum.each(fn ua ->
      assert "bot" == OsDetect.parse(ua)
    end)
  end

  test "misc" do
    [{"mac_powerpc", "Mozilla/4.0 (compatible; MSIE 4.5; Mac_PowerPC)"}]
    |> Enum.each(fn {expected, ua} ->
      assert expected == OsDetect.parse(ua)
    end)
  end
end
