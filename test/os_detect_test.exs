defmodule OsDetectTest do
  use ExUnit.Case, async: true
  doctest OsDetect
  alias OsDetect.Result

  test "android" do
    [
      # android native browser...
      # {_,
      #  "Mozilla/5.0 (Linux; U; Android 4.4.2; en-us; SCH-I535 Build/KOT49H) AppleWebKit/534.30 (KHTML}, like Gecko) Version/4.0 Mobile Safari/534.30"},
      {"chrome",
       "Mozilla/5.0 (Linux; Android 7.0; SM-G930V Build/NRD90M) AppleWebKit/537.36 (KHTML}, like Gecko) Chrome/59.0.3071.125 Mobile Safari/537.36"},
      {"opera",
       "Mozilla/5.0 (Linux; Android 7.0; SM-A310F Build/NRD90M) AppleWebKit/537.36 (KHTML}, like Gecko) Chrome/55.0.2883.91 Mobile Safari/537.36 OPR/42.7.2246.114996"},
      {"opera",
       "Opera/9.80 (Android 4.1.2; Linux; Opera Mobi/ADR-1305251841) Presto/2.11.355 Version/12.10"},
      {"firefox", "Mozilla/5.0 (Android 7.0; Mobile; rv:54.0) Gecko/54.0 Firefox/54.0"},
      {"uc browser",
       "Mozilla/5.0 (Linux; U; Android 7.0; en-US; SM-G935F Build/NRD90M) AppleWebKit/534.30 (KHTML}, like Gecko) Version/4.0 UCBrowser/11.3.8.976 U3/0.8.0 Mobile Safari/534.30"},
      {"samsung browser",
       "Mozilla/5.0 (Linux; Android 7.0; SAMSUNG SM-G955U Build/NRD90M) AppleWebKit/537.36 (KHTML}, like Gecko) SamsungBrowser/5.4 Chrome/51.0.2704.106 Mobile Safari/537.36"},
      {"yandex browser",
       "Mozilla/5.0 (Linux; Android 6.0; Lenovo K50a40 Build/MRA58K) AppleWebKit/537.36 (KHTML}, like Gecko) Chrome/57.0.2987.137 YaBrowser/17.4.1.352.00 Mobile Safari/537.36"},
      {"chrome",
       "Mozilla/5.0 (Linux; Android 7.0; SM-G930V Build/NRD90M) AppleWebKit/537.36 (KHTML}, like Gecko) Chrome/59.0.3071.125 Mobile Safari/537.36"},
      {"webview",
       "Mozilla/5.0 (Linux; Android 10; Pixel 3 XL Build/QQ3A.200605.001; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/83.0.4103.106 Mobile Safari/537.36 GSA/11.18.11.21.arm64"},
      # Firefox Focus
      {"firefox",
       "Mozilla/5.0 (Linux; Android 7.1.2) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Focus/3.0 Chrome/59.0.3017.125 Safari/537.36"},
      {"webview", "Dalvik/2.1.0 (Linux; U; Android 9; SM-N950U Build/PPR1.180610.011)"},
      # Tizen Phone, but still android....
      {"chrome",
       "Mozilla/5.0 (Linux; Android 4.4.4; Tizen Phone with ACL) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.112 Mobile Safari/537.36"},
      {"edge",
       "Mozilla/5.0 (Linux; Android 8.0; Pixel XL Build/OPP3.170518.006) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.0 Mobile Safari/537.36 EdgA/41.1.35.1"},
      {"chrome",
       "Mozilla/5.0 (Linux; Android 8.1.0; XBot_Senior) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.82 Mobile Safari/537.36"},
      {"webview",
       "Mozilla/5.0 (Linux;  9; moto e6s Build/POE29.288-60-6; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/90.0.4430.82  Safari/537.36"},
      # weird since it is missing "Android"
      {"chrome",
       "Mozilla/5.0 (Linux; ; en_US; Pixel 3 Build/RQ2A.210405.005) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.116 Mobile Safari/537.36"},
      {"webview",
       "[FBAN/FB4A;FBAV/315.0.0.47.113;FBBV/285966858;FBDM/{density=2.0,width=720,height=1344};FBLC/en_US;FBRV/287264090;FBCR/;FBMF/motorola;FBBD/motorola;FBPN/com.facebook.katana;FBDV/moto e5 plus;FBSV/8.0.0;FBOP/1;FBCA/armeabi-v7a:armeabi;]"},
      {"webview", "ClientApp/4.0.3.34521 (android 10; SM-G960U1; sdm845)  You.i/5.19.0-att.cr7"},
      {"webview", "AfricaWeb: GhanaWeb/3.1.1 (android 8.0.0)"},
      {"qwant",
       "QwantMobile/3.0 (Android 8.1.0; Mobile; rv:66.0) Gecko/66.0 Firefox/65.0 QwantBrowser/66.0.3"},
      {"qwant",
       "Mozilla/5.0 (Linux; Android 7.0; SM-A510F Build/NRD90M) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/53.0.2785.143 Crosswalk/23.53.589.2 Mobile Safari/537.36 QwantMobile/1.1"},
      {"webview",
       "Mozilla/5.0 (Linux; Android 11; ONEPLUS A5010 Build/RQ2A.210305.006; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/89.0.4389.105 Mobile Safari/537.36"},
      {"webview",
       "Mozilla/5.0 (Linux; Android 8.0.0; SO-01J Build/41.3.B.2.2; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/90.0.4430.82 Mobile Safari/537.36 YJApp-ANDROID jp.co.yahoo.android.ybrowser/3.11.1.1"}
    ]
    |> Enum.each(fn {browser, ua} ->
      assert %Result{browser: ^browser, os: "android", type: :mobile} = OsDetect.parse(ua)
    end)
  end

  test "android tablet" do
    [
      {"webview",
       "ClientApp/4.0.3.34521 (android 7.1.1; SM-T377V; universal3475)  You.i/5.19.0-att.cr7"},
      {"qwant",
       "QwantJuniorMobile/1.0 (Android 8.1.0; Tablet; rv:59.0) Gecko/59.0 Firefox/59.0 QwantBrowser/59.0.3"},
      {"firefox", "Mozilla/5.0 (Android 4.4; Tablet; rv:41.0) Gecko/41.0 Firefox/41.0"},
      {"webview",
       "Mozilla/5.0 (Linux; Android 5.1.1; SAMSUNG-SM-T337A Build/LMY47X; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/79.0.3945.93 Safari/537.36 [FB_IAB/FB4A;FBAV/258.0.0.34.119;]"},
      {"samsung browser",
       "Mozilla/5.0 (Linux; Android 10; SAMSUNG SM-T505) AppleWebKit/537.36 (KHTML, like Gecko) SamsungBrowser/14.0 Chrome/87.0.4280.141 Mobile Safari/537.36"},
      {"webview",
       "Mozilla/5.0 (Linux; Android 10; SM-T720 Build/QP1A.190711.020; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/90.0.4430.82 Safari/537.36 YJApp-ANDROID jp.co.yahoo.android.ybrowser/3.11.0.2"}
    ]
    |> Enum.each(fn {browser, ua} ->
      assert %Result{browser: ^browser, os: "android", type: :tablet} = OsDetect.parse(ua)
    end)
  end

  test "ios mobile" do
    [
      {"opera",
       "Mozilla/5.0 (iPhone; CPU iPhone OS 7_1_2 like Mac OS X) AppleWebKit/537.51.2 (KHTML}, like Gecko) OPiOS/10.2.0.93022 Mobile/11D257 Safari/9537.53"},
      {"safari",
       "Mozilla/5.0 (iPod touch; CPU iPhone 14_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/14.0 Mobile/15E148 Safari/604.1"},
      {"webview",
       "Mozilla/5.0 (iPod touch; CPU iPhone OS 12_5_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148 musical_ly_19.1.0 JsSdk/2.0 NetType/WIFI Channel/App Store ByteLocale/fr Region/CA ByteFullLocale/fr-CA isDarkMode/0 WKWebView/1"},
      {"safari",
       "Mozilla/5.0 (iPhone; CPU iPhone OS 14_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/14.0 Mobile/15E148 Safari/604.1"},
      {"firefox",
       "Mozilla/5.0 (iPhone; CPU iPhone OS 10_3_2 like Mac OS X) AppleWebKit/603.2.4 (KHTML}, like Gecko) FxiOS/7.5b3349 Mobile/14F89 Safari/603.2.4"},
      {"safari",
       "Mozilla/5.0 (iPhone; CPU iPhone OS 6_1_4 like Mac OS X) AppleWebKit/536.26 (KHTML}, like Gecko) Version/6.0 Mobile/10B350 Safari/8536.25"},
      {"webview",
       "Mozilla/5.0 (iPhone; CPU iPhone OS 8_3 like Mac OS X) AppleWebKit/600.1.4 (KHTML, like Gecko) Mobile/12F70"},
      {"webview",
       "Mozilla/5.0 (iPhone; CPU iPhone OS 9_0 like Mac OS X) AppleWebKit/601.1.32 (KHTML, like Gecko) Mobile/13A4254v"},
      {"webview",
       "Mozilla/5.0 (iPhone; CPU iPhone OS 14_4_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Euclid/6.4.0.22"},
      {"chrome",
       "Mozilla/5.0 (iPhone; CPU iPhone OS 10_3 like Mac OS X) AppleWebKit/602.1.50 (KHTML, like Gecko) CriOS/56.0.2924.75 Mobile/14E5239e Safari/602.1"},
      {"chrome",
       "Mozilla/5.0 (iPhone; CPU iPhone OS 13_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) CriOS/78.0.3904.84 Mobile/15E148 Safari/604.1"},
      {"edge",
       "Mozilla/5.0 (iPhone; CPU iPhone OS 10_3_2 like Mac OS X) AppleWebKit/603.2.4 (KHTML, like Gecko) Mobile/14F89 Safari/603.2.4 EdgiOS/41.1.35.1"},
      {"opera",
       "Mozilla/5.0 (iPhone; CPU iPhone OS 14_4_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148 OPT/3.0.3"},
      {"duckduckgo",
       "Mozilla/5.0 (iPhone; CPU iPhone OS 14_4_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/14.4 Mobile/15E148 DuckDuckGo/7 Safari/605.1.15"},
      {"webview",
       "[FBAN/FBIOS;FBDV/iPhone8,1;FBMD/iPhone;FBSN/iOS;FBSV/13.6.1;FBSS/2;FBID/phone;FBLC/de_DE;FBOP/5]"},
      {"webview", "AlarmClockFree/3.8.8 CFNetwork/808.1.4 Darwin/16.1.0"},
      {"webview", "iFunny/21597 CFNetwork/1121.2.2 Darwin/19.2.0"},
      {"webview", "DreamIsland/8 CFNetwork/1209 Darwin/20.2.0"},
      {"webview", "iFunny/9218 CFNetwork/1125.2 Darwin/19.4.0"},
      {"webview", "Imgur/1764.0525 CFNetwork/974.2.1 Darwin/18.0.0"},
      {"webview", "Calculator'/1059 CFNetwork/808.1.4 Darwin/16.1.0"},
      {"qwant",
       "QwantMobile/2.0 (iPhone; CPU iPhone OS 14_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) QwantiOS/2.6.0b1 Mobile/15E148 Safari/605.1.15"}
    ]
    |> Enum.each(fn {browser, ua} ->
      assert %Result{browser: ^browser, os: "ios", type: :mobile} = OsDetect.parse(ua)
    end)
  end

  test "ipad" do
    [
      {"safari",
       "Mozilla/5.0 (iPad; CPU OS 14_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/14.0 Mobile/15E148 Safari/604.1"},
      {"safari",
       "Mozilla/5.0 (iPad; CPU OS 7_0 like Mac OS X) AppleWebKit/537.51.1 (KHTML}, like Gecko) Version/7.0 Mobile/11A465 Safari/9537.53"}
    ]
    |> Enum.each(fn {browser, ua} ->
      assert %Result{browser: ^browser, os: "ios", type: :tablet} = OsDetect.parse(ua)
    end)
  end

  test "mac os" do
    [
      {"skyfire",
       "Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_5_7; en-us) AppleWebKit/530.17 (KHTML, like Gecko) Version/4.0 Safari/530.17 Skyfire/2.0"},
      {"chrome",
       "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.116 Safari/537.36"},
      {"safari",
       "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Safari/605.1.15"},
      {"safari",
       "Mozilla/5.0 (Macintosh; Intel Mac OS X 11_3) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/14.0.3 Safari/605.1.15"},
      {"firefox",
       "Mozilla/5.0 (Macintosh; Intel Mac OS X x.y; rv:10.0) Gecko/20100101 Firefox/10.0"},
      {"firefox",
       "Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.10; rv:75.0) Gecko/20100101 Firefox/75.0"},
      # unknown on mac os usually means in-app
      {"unknown",
       "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148 [LinkedInApp]"},
      {"unknown",
       "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/605.1.15 (KHTML, like Gecko) Euclid/6.4.0.18"}
    ]
    |> Enum.each(fn {browser, ua} ->
      assert %Result{browser: ^browser, os: "mac os", type: :desktop} = OsDetect.parse(ua)
    end)
  end

  test "windows" do
    [
      {"ie", "Mozilla/5.0 CK={} (Windows NT 6.1; WOW64; Trident/7.0; rv:11.0) like Gecko"},
      {"chrome",
       "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.169 Safari/537.36"},
      {"opera", "Opera/9.80 (Windows NT 5.1) Presto/2.12.388 Version/12.17"},
      {"unknown", "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1)"},
      {"edge",
       "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4090.0 Safari/537.36 Edg/83.0.467.0"},
      {"edge",
       "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.74 Safari/537.36 Edg/79.0.309.43"},
      {"edge",
       "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.140 Safari/537.36 Edge/18.17763"},
      {"coc coc",
       "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) coc_coc_browser/94.0.202 Chrome/88.0.4324.202 Safari/537.36"},
      {"freeridegamesplayer",
       "Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) freeridegamesPlayer/11.3311.0.60"},
      {"chrome",
       "Mozilla/5.0 (Windows 10 Build 1802; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/81.0.3626.121 Safari/537.36"},
      {"firefox", "Mozilla/5.0 (Windows; U; Win95; de-AT; rv:1.7.11) Gecko/20050728"},
      {"opera", "Mozilla/4.0 (Windows 98; US) Opera 12.16 [en]"},
      # actual K-Meleon, but that is super old and Gecko based
      {"firefox",
       "Mozilla/5.0 (Windows; U; Win98; de-DE; rv:1.8.1.24) Gecko/20100228 K-Meleon/1.5.4"},
      {
        "firefox",
        "Mozilla/5.0 (Windows; U; WinNT4.0; en-US; rv:1.2b) Gecko/20021016 K-Meleon 0.7"
      },
      # actually SeaMonkey browser, Gecko based
      {"firefox",
       "Mozilla/5.0 (Windows; U; Win 9x 4.90; en-US; rv:1.8.1.22) Gecko/20090605 SeaMonkey/1.1.17"}
    ]
    |> Enum.each(fn {browser, ua} ->
      assert %Result{browser: ^browser, os: "windows", type: :desktop} = OsDetect.parse(ua)
    end)
  end

  test "windows phone" do
    [
      {"edge",
       "Mozilla/5.0 (Windows Phone 10.0; Android 6.0.1; Microsoft; Lumia 950) AppleWebKit/537.36 (KHTML}, like Gecko) Chrome/52.0.2743.116 Mobile Safari/537.36 Edge/15.14977"},
      {"edge",
       "Mozilla/5.0 (Windows Mobile 10; Android 8.0.0; Microsoft; Lumia 950XL) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.92 Mobile Safari/537.36 Edge/40.15254.369"},
      {"opera",
       "Opera/9.80 (Windows Mobile; Opera Mini/5.1.21594/29.3594; U; en) Presto/2.8.119 Version/11.10"},
      {"ie",
       "Mozilla/5.0 (Mobile; Windows Phone 8.1; Android 4.0; ARM; Trident/7.0; Touch; rv:11.0; IEMobile/11.0; NOKIA; Lumia 630 Dual SIM) like iPhone OS 7_0_3 Mac OS X AppleWebKit/537 (KHTML, like Gecko) Mobile Safari/537"},
      {"ie",
       "Mozilla/5.0 (Mobile; Windows Phone 8.1; Android 4.0; ARM; Trident/7.0; Touch; rv:11.0; IEMobile/11.0; Microsoft; Lumia 535 Dual SIM) like iPhone OS 7_0_3 Mac OS X AppleWebKit/537 (KHTML, like Gecko) Mobile Safari/537"},
      {"edge",
       "Mozilla/5.0 (Windows Phone 10.0; Android 6.0.1; ALCATELONETOUCH; FierceXL) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/52.0.2743.116 Mobile Safari/537.36 Edge/15.15254"},
      {"ie",
       "Mozilla/5.0 (Mobile; Windows Phone 8.1; Android 4.0; ARM; Trident/7.0; Touch; rv:11.0; IEMobile/11.0; NOKIA; Lumia 930; Vodafone) like iPhone OS 7_0_3 Mac OS X AppleWebKit/537 (KHTML, like Gecko) Mobile Safari/537"},
      {"ie", "Mozilla/5.0 (compatible; MSIE 9.0; Trident/5.0; IEMobile/9.0)"}
    ]
    |> Enum.each(fn {browser, ua} ->
      assert %Result{os: "windows phone", browser: ^browser, type: :mobile} = OsDetect.parse(ua)
    end)
  end

  test "windows tablet" do
    [
      {"outlook",
       "Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.2; Win64; x64; Trident/7.0; .NET4.0C; .NET4.0E; .NET CLR 2.0.50727; .NET CLR 3.0.30729; .NET CLR 3.5.30729; Tablet PC 2.0; Microsoft Outlook 14.0.7172; ms-office; MSOffice 14)"}
    ]
    |> Enum.each(fn {browser, ua} ->
      assert %Result{os: "windows", browser: ^browser, type: :tablet} = OsDetect.parse(ua)
    end)
  end

  test "samsung mobile" do
    [
      {"webview",
       "Mozilla/5.0 (Linux; diordnA 10; SM-A205G Build/QP1A.190711.020; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/90.0.4430.82 eliboM Safari/537.36"},
      {"webview",
       "Mozilla/5.0 (Linux; diordnA 9; SM-A307FN Build/PPR1.180610.011; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/78.0.3904.108 eliboM Safari/537.36"},
      {"webview",
       "Mozilla/5.0 (Linux; diordnA 11; SM-G781U Build/RP1A.200720.012; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/90.0.4430.66 eliboM Safari/537.36"},
      {"webview",
       "Mozilla/5.0 (Linux; diordnA 10; SM-A705W Build/QP1A.190711.020; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/89.0.4389.105 eliboM Safari/537.36"},
      {"webview",
       "Mozilla/5.0 (Linux; diordnA 10; SM-G965U Build/QP1A.190711.020; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/89.0.4389.90 eliboM Safari/537.36"},
      {"samsung browser",
       "Mozilla/5.0 (Linux; Android 10; SAMSUNG SM-N960F/N960FXXS6ETHB) AppleWebKit/537.36 (KHTML, like Gecko) SamsungBrowser/14.0 Chrome/87.0.4280.141 Mobile Safari/537.36"},
      {"webview",
       "Mozilla/5.0 (Linux; diordnA 11; SM-M215F Build/RP1A.200720.012; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/90.0.4430.91 eliboM Safari/537.36"}
    ]
    |> Enum.each(fn {browser, ua} ->
      assert %Result{os: "android", browser: ^browser, type: :mobile} = OsDetect.parse(ua)
    end)
  end

  test "samsung tablet" do
    [
      {"webview",
       "Mozilla/5.0 (Linux; diordnA 10; SM-T830 Build/QP1A.190711.020; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/90.0.4430.82 Safari/537.36"},
      {"webview",
       "Mozilla/5.0 (Linux; diordnA 11; SM-P610 Build/RP1A.200720.012; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/90.0.4430.82 Safari/537.36"}
    ]
    |> Enum.each(fn {browser, ua} ->
      assert %Result{os: "android", browser: ^browser, type: :tablet} = OsDetect.parse(ua)
    end)
  end

  test "kindle fire" do
    [
      {"silk",
       "Mozilla/5.0 (Linux; U; en-gb; KFTT Build/IML74K) AppleWebKit/535.19 (KHTML, like Gecko) Silk/3.17 Safari/535.19 Silk-Accelerated=true"},
      {"chrome",
       "Mozilla/5.0 (Linux; Android 7.1.2; Kindle Fire HDX) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.141 Safari/537.36"},
      {"silk",
       "Mozilla/5.0 (Linux; U; en-gb; KFOT Build/IML74K) AppleWebKit/535.19 (KHTML, like Gecko) Silk/3.19 Safari/535.19 Silk-Accelerated=true"},
      {"silk",
       "Mozilla/5.0 (Linux; U; en-us; KFJWI Build/IMM76D) AppleWebKit/535.19 (KHTML, like Gecko) Silk/3.17 Safari/535.19 Silk-Accelerated=true"},
      {"silk",
       "Mozilla/5.0 (Linux; Android 9; KFMUWI) AppleWebKit/537.36 (KHTML, like Gecko) Silk/87.1.160 like Chrome/87.0.4280.101 Safari/537.36"},
      {"chrome",
       "Mozilla/5.0 (Linux; Android 7.1.2; Kindle Fire HDX) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.105 Mobile Safari/537.36"},
      {"webview",
       "Mozilla/5.0 (Linux; U; Android 4.2.2; en-us; Amazon Kindle Fire Build/JDQ39E; CyanogenMod-10.1) AppleWebKit/534.30 (KHTML, like Gecko) Version/4.0 Mobile Safari/534.30"}
    ]
    |> Enum.each(fn {browser, ua} ->
      assert %Result{browser: ^browser, os: "kindle fire", type: :tablet} = OsDetect.parse(ua)
    end)
  end

  test "linux" do
    [
      {"firefox", "Mozilla/5.0 (X11; Fedora;Linux x86; rv:60.0) Gecko/20100101 Firefox/60.0"},
      {"firefox",
       "Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101 Firefox/38.0 Iceweasel/38.7.1"},
      {"firefox",
       "Mozilla/5.0 (X11; U; Linux amd64; rv:5.0) Gecko/20100101 Firefox/5.0 (Debian)"},
      {"chrome",
       "Mozilla/5.0 (Wayland; Linux x86_64; rv:67.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2526.108 Safari/537.36"},
      {"firefox", "Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:88.0) Gecko/20100101 Firefox/88.0"},
      {"chrome",
       "Mozilla/5.0 (Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.72 Safari/537.36"},
      {
        "chrome",
        "Mozilla/5.0 (Linux;) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.157 Safari/537.36"
      },
      {"chrome",
       "Mozilla/5.0 (Unknown; Linux) AppleWebKit/538.1 (KHTML, like Gecko) Chrome/v1.0.0 Safari/538.1"},
      {"chrome",
       "Mozilla/5.0 (Linux; Ubuntu 17.04) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.132 Safari/537.36"},
      {"chrome",
       "Mozilla/5.0 (Linux) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.118 Safari/537.36"},
      {"firefox", "Mozilla/5.0 (Linux x86_64; rv:75.0) Gecko/20100101 Firefox/75.0"},
      {"chrome",
       "Mozilla/5.0 (Linux aarch64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.91 Safari/537.36"},
      {"pafari",
       "Mozilla/5.0 (pearOS SnowMojave; x64) PearWebKit/537.36 (KHTML, like Gecko) Chrome/37.0.2049.0 Pafari/537.36"},
      {"chrome",
       "Mozilla/5.0 (Linux; U; X11; en-US; Valve Steam GameOverlay/1619223738; ) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.117 Safari/537.36"},
      {"chrome",
       "Mozilla/5.0 (X11; Fedora; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.100 Safari/537.36"},
      {"chrome",
       "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Ubuntu Chromium/70.0.3538.67 Chrome/70.0.3538.67 Safari/537.36"},
      {"firefox", "Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:15.0) Gecko/20100101 Firefox/15.0.1"},
      {"firefox",
       "Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.16) Gecko/20110323 Ubuntu/10.10 (maverick) Firefox/3.6.16"}
    ]
    |> Enum.each(fn {browser, ua} ->
      assert %Result{browser: ^browser, os: "linux", type: :desktop} = OsDetect.parse(ua)
    end)
  end

  test "freebsd" do
    [
      {"firefox", "Mozilla/5.0 (X11; FreeBSD i386; rv:66.0) Gecko/20100101 Firefox/66.0"},
      {"firefox",
       "Mozilla/5.0 (Darwin; FreeBSD 5.6; en-GB; rv:1.8.1.17pre) Gecko/20080716 K-Meleon/1.5.0"},
      {"firefox", "Mozilla/5.0 (X11; FreeBSD amd64; rv:5.0) Gecko/20100101 Firefox/5.0"}
    ]
    |> Enum.each(fn {browser, ua} ->
      assert %Result{browser: ^browser, os: "freebsd", type: :desktop} = OsDetect.parse(ua)
    end)
  end

  test "brightsign" do
    [
      "BrightSign/35D6AA000662/6.2.80.1 (HD1023) Mozilla/5.0 (Unknown; Linux arm) AppleWebKit/537.36 (KHTML, like Gecko) QtWebEngine/5.6.0 Chrome/45.0.2454.101 Safari/537.36",
      "BrightSign/R3E6DP000834/6.2.94 (XD233) Mozilla/5.0 (Unknown; Linux arm) AppleWebKit/537.36 (KHTML, like Gecko) QtWebEngine/5.6.0 Chrome/45.0.2454.101 Safari/537.36",
      "BrightSign/L8D69C002324/6.2.80.1 (XT1143) Mozilla/5.0 (Unknown; Linux arm) AppleWebKit/537.36 (KHTML, like Gecko) QtWebEngine/5.6.0 Chrome/45.0.2454.101 Safari/537.36"
    ]
    |> Enum.each(fn ua ->
      assert %Result{browser: "brightsign", os: "brightsign", type: :smart_tv} =
               OsDetect.parse(ua)
    end)
  end

  test "fire tv" do
    # https://developer.amazon.com/docs/fire-tv/user-agent-strings.html
    [
      "Mozilla/5.0 (Linux; Android 5.1.1; AFTT Build/LVY48F; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/49.0.2623.10",
      "Dalvik/2.1.0 (Linux; U; Android 5.1; AFTM Build/LMY47O)",
      "Mozilla/5.0 (Linux; U; Android 4.2.2; en-us; AFTM Build/JDQ39) AppleWebKit/534.30 (KHTML, like Gecko) Version/4.0 Safari/534.30",
      "Dalvik/2.1.0 (Linux; U; Android 9; AFTSSS Build/PS7234) (Philo TV Fire/4.1.48-13001-amazon)",
      "Mozilla/5.0 (Linux; Android 7.1.2; AFTN Build/NS6280; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/87.0.4280.101 Mobile Safari/537.36,gzip(gfe),gzip(gfe)",
      "Philo TV Fire/1.1.19-amazon/5.1.1/AFTT"
    ]
    |> Enum.each(fn ua ->
      assert %Result{browser: "fire tv", os: "fire tv", type: :smart_tv} = OsDetect.parse(ua)
    end)
  end

  test "tizen tv" do
    # https://developer.samsung.com/smarttv/develop/guides/fundamentals/retrieving-platform-information.html
    [
      "Mozilla/5.0 (SMART-TV; Linux; Tizen 2.4.0) AppleWebKit/538.1 (KHTML, like Gecko) Version/2.4.0 TV Safari/538.1",
      "Mozilla/5.0 (SMART-TV; Linux; Tizen 3.0) AppleWebKit/538.1 (KHTML, like Gecko) Version/3.0 TV Safari/538.1,gzip(gfe),gzip(gfe)",
      "Mozilla/5.0 (SMART-TV; LINUX; Tizen 4.0) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 TV Safari/537.36,gzip(gfe),gzip(gfe)",
      "Mozilla/5.0 (SMART-TV; Linux; Tizen 5.0) AppleWebKit/538.1 (KHTML, like Gecko) Version/5.0 TV Safari/538.1,gzip(gfe),gzip(gfe)",
      "Mozilla/5.0 (SMART-TV; Linux; Tizen 5.5) AppleWebKit/537.36 (KHTML, like Gecko) SamsungBrowser/3.0 Chrome/69.0.3497.106 TV Safari/537.36",
      "Mozilla/5.0 (SMART-TV; Linux; Tizen 6.0) AppleWebKit/538.1 (KHTML, like Gecko) Version/6.0 TV Safari/538.1",
      "Mozilla/5.0 (Linux; Tizen 2.3; SmartHub; SMART-TV; SmartTV; U; Maple2012) AppleWebKit/538.1+ (KHTML, like Gecko) TV Safari/538.1+",
      "Mozilla/5.0 (Linux; Tizen 2.3) AppleWebKit/538.1 (KHTML, like Gecko)Version/2.3 TV Safari/538.1",
      "Mozilla/5.0 (SmartHub; SMART-TV; U; Linux/SmartTV+2015; Maple2012) AppleWebKit/537.42+ (KHTML, like Gecko) SmartTV Safari/537.42+",
      "Mozilla/5.0 (SMART-TV; X11; Linux i686) AppleWebKit/534.7 (KHTML, like Gecko) Version/5.0 Safari/534.7"
    ]
    |> Enum.each(fn ua ->
      assert %Result{browser: "tizen", os: "tizen", type: :smart_tv} = OsDetect.parse(ua)
    end)
  end

  test "tizen mobile" do
    [
      {"unknown",
       "Mozilla/5.0 (Linux; Tizen 2.3; SAMSUNG SM-Z130H) AppleWebKit/537.3 (KHTML, like Gecko) Version/2.3 Mobile Safari/537.3"},
      {"android browser",
       "Mozilla/5.0 (Linux; Tizen 2.2; SAMSUNG SM-Z9005) AppleWebKit/537.3 (KHTML, like Gecko) Version/2.2 like Android 4.1; Mobile Safari/537.3"},
      {"samsung browser",
       "Mozilla/5.0 (Linux; Tizen 2.3; SAMSUNG SM-Z130H) AppleWebKit/537.3 (KHTML, like Gecko) SamsungBrowser/1.0 Mobile Safari/537.3"},
      {"tizen browser",
       "Mozilla/5.0 (Linux; U; Tizen 2.0; en-us) AppleWebKit/537.1 (KHTML, like Gecko) Mobile TizenBrowser/2"},
      {"opera",
       "Opera/9.80 (Tizen; Opera Mini/7.6.9/35.7827; U; en) Presto/2.8.119 Version/11.10"}
    ]
    |> Enum.each(fn {browser, ua} ->
      assert %Result{browser: ^browser, os: "tizen", type: :mobile} = OsDetect.parse(ua)
    end)
  end

  test "sailfish" do
    [
      {"firefox", "Mozilla/5.0 (Sailfish 4.0; Mobile; rv:60.0) Gecko/60.0 Firefox/60.0"}
    ]
    |> Enum.each(fn {browser, ua} ->
      assert %Result{browser: ^browser, os: "sailfish", type: :mobile} = OsDetect.parse(ua)
    end)
  end

  test "firefox os" do
    [
      {:mobile, "Mozilla/5.0 (Mobile; Orange KLIFD; rv:32.0) Gecko/32.0 Firefox/32.0"},
      {:mobile, "Mozilla/5.0 (Mobile; ALCATELOneTouch4019A; rv:28.0) Gecko/28.0 Firefox/28.0"},
      {:tablet, "Mozilla/5.0 (Tablet; rv:29.0) Gecko/29.0 Firefox/29.0"}
    ]
    |> Enum.each(fn {type, ua} ->
      assert %Result{browser: "firefox", os: "firefox os", type: ^type} = OsDetect.parse(ua)
    end)
  end

  test "lynx" do
    [
      "Lynx/2.8.8pre.4 libwww-FM/2.14 SSL-MM/1.4.1 GNUTLS/2.12.23"
    ]
    |> Enum.each(fn ua ->
      assert %Result{browser: "lynx", os: "unknown", type: :desktop} = OsDetect.parse(ua)
    end)
  end

  test "konqueror" do
    [
      "Mozilla/5.0 (compatible; Konqueror/3.1-rc1; i686 Linux; 20020823)"
    ]
    |> Enum.each(fn ua ->
      assert %Result{browser: "konqueror", os: "unknown", type: :desktop} = OsDetect.parse(ua)
    end)
  end

  test "googletv" do
    [
      "Mozilla/5.0 (X11; Linux i686; en-US) AppleWebKit/538.39.41 (KHTML, like Gecko) Chrome/10.0.648.205 Large Screen Safari/538.39.41 GoogleTV/162671",
      "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.101 Safari/537.36 Mozilla/5.0 (X11; U; Linux i686; de-DE) AppleWebKit/533.4 (KHTML, like Gecko) Chrome/5.0.375.127 Large Screen Safari/533.4 GoogleTV/162671"
    ]
    |> Enum.each(fn ua ->
      assert %Result{browser: "googletv", os: "googletv", type: :smart_tv} = OsDetect.parse(ua)
    end)
  end

  test "hbbtv" do
    [
      "Mozilla/5.0 (Linux armv9; U; ru;) AppleWebKit/537.17 (Grundig;G7;08.005.03;) CE-HTML/1.0 NETRANGEMMH HbbTV/1.2.1 (MWB;Arcelik_Gen3;RC_V2;Arcelik;G7;G7GRMR.-.-.-.-.V08.005.03;ru-TR;wireless;prod;)",
      "Mozilla/5.0 (DirectFB; Linux armv7l) AppleWebKit/534.26+ (KHTML, like Gecko) Version/5.0 Safari/534.26+ HbbTV/1.1.1 ( ;LGE ;NetCast 3.0 ;1.0 ;1.0M ;)",
      "Mozilla/5.0 (Linux armv7l) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/44.0.2403.130 Safari/537.36 OPR/31.0.1890.0 OMI/4.6.1.40.Dominik2.207 VSTVB MB100 FVC/1.0 (FINLUX; MB120; ) HbbTV/1.3.1 (; FINLUX; MB120; 2.45.12.0; ;) SmartTvA/3.0.0",
      "Opera/9.80 (Linux armv7l; HbbTV/1.2.1 (; Philips; 40HFL5010T12; ; PHILIPSTV; CE-HTML/1.0 NETTV/4.4.1 SmartTvA/3.0.0 Firmware/004.002.036.135 (PhilipsTV, 3.1.1,)en) ) Presto/2.12.407 Version/12.50",
      "Mozilla/5.0 (Linux; U) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36 OPR/46.0.2207.0 LOEWE-SL420/5.2.0.0 HbbTV/1.4.1 (; LOEWE; SL420; LOH/5.2.0.0;;) FVC/3.0 (LOEWE; SL420;) CE-HTML/1.0 Config (L:deu,CC:DEU) NETRANGEMMH",
      "Mozilla/5.0 (Linux armv7l) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/44.0.2403.130 Safari/537.36 OPR/31.0.1890.0 OMI/4.6.1.40.Dominik2.207 VSTVB MB100 FVC/1.0 (HITACHI; MB120; ) HbbTV/1.3.1 (; HITACHI; MB120; 2.45.12.0; ;) SmartTvA/3.0.0"
    ]
    |> Enum.each(fn ua ->
      assert %Result{browser: "hbbtv", os: "hbbtv", type: :smart_tv} = OsDetect.parse(ua)
    end)
  end

  test "roku" do
    [
      "Roku/DVP-9.0 (399.00E04151A)",
      "Roku/DVP (297.70E04154A)",
      "roku/dvp-9.26 (909.26e04132a)",
      "Mozilla/5.0 (Roku/DVP)",
      "Mozilla/5.0 (Roku/DVP) (KHTML, like Gecko) Version/14.0 Safari/605.1.15",
      "Roku/DVP-10.0.0 (10.0.0-4185; 3900X/Roku Express; STB; 999.99E99999A) ((Philo/1.34.12))",
      "Roku/DVP-10.0.0 (10.0.0-4185; 3800X/Roku Streaming Stick; STB; 999.99E99999A) ((Philo/1.34.12))",
      "Mozilla/5.0 (compatible; U; NETFLIX) AppleWebKit/533.3 (KHTML, like Gecko) Qt/4.7.0 Safari/533.3 Netflix/3.2 (DEVTYPE=RKU-42XXX-; CERTVER=0) QtWebKit/2.2, Roku 3/7.0 (Roku, 4200X, Wireless)"
      # found this here: https://developers.whatismybrowser.com/useragents/explore/software_name/roku-digital-video-player/11
      # not sure how Roku could be running on mac os...
      # "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15; Roku/DVP)"
    ]
    |> Enum.each(fn ua ->
      assert %Result{os: "roku", browser: "roku", type: :smart_tv} = OsDetect.parse(ua)
    end)
  end

  test "web os" do
    [
      "Mozilla/5.0 (Web0S; Linux/SmartTV) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/53.0.2785.34 Safari/537.36 DMOST/1.0.1 (; LGE; webOSTV; WEBOS4.1.0 04.10.40; W4_lm18a;)",
      "Mozilla/5.0 (Web0S; Linux/SmartTV) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/53.0.2785.34 Safari/537.36 DMOST/1.0.1 (; LGE; webOSTV; WEBOS4.5.0 03.50.31; W4_o18;)",
      "Mozilla/5.0 (Web0S; Linux/SmartTV) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/53.0.2785.34 Safari/537.36 DMOST/1.0.1 (; LGE; webOSTV; WEBOS4.5.0 03.50.40; W4_m16p3;)",
      "Mozilla/5.0 (webOS/1.4.5; U; en-US) AppleWebKit/532.2 (KHTML, like Gecko) Version/1.0 Safari/532.2 Pre/1.1",
      "Mozilla/5.0 (Web0S; Linux/SmartTV) AppleWebKit/538.2 (KHTML, like Gecko) Large Screen Safari/538.2 LG Browser/7.00.00(LGE; 24LF4820-BU; 03.20.14; 1; DTV_W15L); webOS.TV-2015; LG NetCast.TV-2013 Compatible (LGE, 24LF4820-BU, wireless)",
      "Mozilla/5.0 (Web0S; Linux/SmartTV) AppleWebKit/537.36 (KHTML, like Gecko) QtWebEngine/5.2.1 Chr0me/38.0.2125.122 Safari/537.36 LG Browser/8.00.00(LGE; 60UH6550-UB; 03.00.15; 1; DTV_W16N); webOS.TV-2016; LG NetCast.TV-2013 Compatible (LGE, 60UH6550-UB, wireless)",
      "Mozilla/5.0 (Web0S; Linux/SmartTV) AppleWebKit/538.2 (KHTML, like Gecko) Large Screen Safari/538.2 LG Browser/7.00.00(LGE; 65LF6300-UA; 04.00.30; 1; DTV_W15M); webOS.TV-2015; LG NetCast.TV-2013 Compatible (LGE, 65LF6300-UA, wireless)"
    ]
    |> Enum.each(fn ua ->
      assert %Result{os: "web os", browser: "web os", type: :smart_tv} = OsDetect.parse(ua)
    end)
  end

  test "chrome os" do
    [
      {"webview",
       "Mozilla/5.0 (Linux; Android 9; Acer Chromebook R11 (CB5-132T, C738T) Build/R89-13729.72.0; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/89.0.4389.105 Safari/537.36 [FB_IAB/FB4A;FBAV/313.0.0.35.119;]"},
      "Mozilla/5.0 (X11; CrOS x86_64 12239.92.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/76.0.3809.136 Safari/537.36",
      "Mozilla/5.0 (X11; CrOS x86_64 13099.19.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.33 Safari/537.36",
      "Mozilla/5.0 (X11; CrOS x86_64 13421.23.11) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.186 Safari/537.36",
      "Mozilla/5.0 (X11; CrOS x86_64 13080.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4136.1 Safari/537.36",
      "Mozilla/5.0 (X11; CrOS aarch64 10895.78.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.120 Safari/537.36",
      "Mozilla/5.0 (X11; CrOS aarch64 13904.16.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.25 Safari/537.36"
    ]
    |> Enum.each(fn
      {browser, ua} ->
        assert %Result{os: "chrome os", type: :desktop, browser: ^browser} = OsDetect.parse(ua)

      ua ->
        assert %Result{os: "chrome os", type: :desktop, browser: "chrome"} = OsDetect.parse(ua)
    end)
  end

  test "flipboard" do
    # https://flipboard.com/
    [
      {"mac os",
       "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/605.1.15 (KHTML, like Gecko) Flipboard/4.2.103"}
    ]
    |> Enum.each(fn {os, ua} ->
      assert %Result{os: ^os, browser: "flipboard", type: :desktop} = OsDetect.parse(ua)
    end)
  end

  test "blackberry" do
    [
      {"blackberry",
       "Mozilla/5.0 (BlackBerry; U; BlackBerry 9370; xx-xx) AppleWebKit/534.11+ (KHTML, like Gecko) Version/7.0.0.374 Mobile Safari/534.11+"},
      {"blackberry",
       "Mozilla/5.0 (Linux; Android 8.1.0; BBB100-1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.116 Mobile Safari/537.36"},
      {"blackberry",
       "BlackBerry9630/5.0.0.624 Profile/MIDP-2.1 Configuration/CLDC-1.1 VendorID/104"},
      {"blackberry",
       "Mozilla/5.0 (BB10; Kbd) AppleWebKit/537.35+ (KHTML, like Gecko) Version/10.3.3.3216 Mobile Safari/537.35+"}
    ]
    |> Enum.each(fn {browser, ua} ->
      assert %Result{os: "blackberry", browser: ^browser, type: :mobile} = OsDetect.parse(ua)
    end)
  end

  test "apple tv" do
    [
      "NFL-CTV/5917 appletv",
      "AppleTV/tvOS/9.1.1",
      "iTunes-AppleTV/4.1",
      "appletv/7.4 ios/8.4.3 appletv/7.4 model/appletv3\,2 build/12h876 (3; dt:12)",
      "AppleCoreMedia/1.0.0.12B466 (Apple TV; U; CPU OS 8_1_3 like Mac OS X; en_us)",
      "Haystack TV/20 (Apple TV; iOS 10.1; Scale/1.00)",
      "IMAtvOS/t.3.8.0 tvOS/14.4 com.univision.iphone/12.02,gzip(gfe),gzip(gfe); (gzip)"
    ]
    |> Enum.each(fn ua ->
      assert %Result{os: "apple tv", browser: "apple tv", type: :smart_tv} = OsDetect.parse(ua)
    end)
  end

  test "chromecast" do
    [
      "Mozilla/5.0 (Linux; Android) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.121 Safari/537.36 CrKey/1.52.241809",
      "Mozilla/5.0 (CrKey armv7l 1.5.16041) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/31.0.1650.0 Safari/537.36",
      "Mozilla/5.0 (X11; Linux aarch64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/52.0.2743.84 Safari/537.36 CrKey/1.21a.76178",
      "Mozilla/5.0 (X11; Linux armv7l) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/43.0.2357.90 Safari/537.36 CrKey/1.17.46278"
    ]
    |> Enum.each(fn ua ->
      assert %Result{os: "chromecast", browser: "chromecast", type: :smart_tv} =
               OsDetect.parse(ua)
    end)
  end

  test "android tv" do
    [
      # https://www.androidcentral.com/stagefright
      # https://source.android.com/devices/media
      "stagefright/1.2 (Linux;Android 4.4.2; Geniatech ATV-585 CTV STB; Jadoo4 JAB J4QC)",
      "Mozilla/5.0 (Linux; GoogleTV 3.2; NSZ-GS7GX70 Build/MASTER) AppleWebKit/534.24 (KHTML, like Gecko) Chrome/11.0.696.77 Safari/534.24",
      "Mozilla/5.0 (Linux; Android 6.0.1; NEXBOX-A95X) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.90 Safari/537.36",
      "TV Bro/1.0 Mozilla/5.0 (Linux; Android 9; SHIELD Android TV Build/PPR1.180610.011; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/88.0.4324.93 Safari/537.36",
      "Mozilla/5.0 (Linux; Android 5.1.1; ZIDOO_X6 Pro Build/LMY48G) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.98 Safari/537.36"
    ]
    |> Enum.each(fn ua ->
      assert %Result{os: "android tv", browser: "android tv", type: :smart_tv} =
               OsDetect.parse(ua)
    end)
  end

  test "tivo" do
    [
      "Mozilla/5.0 (Linux armv7l) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.112 Safari/537.36 OPR/36.0.2128.0 OMI/4.8.0.129.JFK.651 TiVo, TiVo_STB_BCM7438S/21.10.2.v13-USH-11 (TiVo, TCDA95000, wired)"
    ]
    |> Enum.each(fn ua ->
      assert %Result{os: "tivo", browser: "tivo", type: :smart_tv} = OsDetect.parse(ua)
    end)
  end

  test "benq" do
    [
      "Mozilla/5.0 (Linux; Andr0id 6.0; BenQ Smart Display Build/MRA58K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36 OPR/46.0.2207.0 OMI/4.11.3.57.JUNAND2.14 Model/Changhong-MSD6586"
    ]
    |> Enum.each(fn ua ->
      assert %Result{os: "benq", browser: "benq", type: :smart_tv} = OsDetect.parse(ua)
    end)
  end

  test "funai" do
    # http://www.funai.eu/section,tv-dvd-en
    [
      "Mozilla/5.0 (Linux armv7l) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36 OPR/46.0.2207.0 OMI/4.11.2.40.Wasabi.275 Model/Funai-Model18-43PFL5603F7 FW/UNI-0V0KU_223_0 (mi/Funai; ms/TV; mn/43PFL5603/F7_1; my/2018: cn/US; ln/en;)"
    ]
    |> Enum.each(fn ua ->
      assert %Result{os: "funai", browser: "funai", type: :smart_tv} = OsDetect.parse(ua)
    end)
  end

  test "vestel" do
    # https://vestelinternational.com/en/consumer-electronics/tv/
    [
      "Mozilla/5.0 (Linux ) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/53.0.2785.143 Safari/537.36 OPR/40.0.2207.0 OMI/4.9.0.237.DOM3-OPT.252 Model/Vestel-MB130 VSTVB MB100 SmartTvA/3.0.0"
    ]
    |> Enum.each(fn ua ->
      assert %Result{os: "vestel", browser: "vestel", type: :smart_tv} = OsDetect.parse(ua)
    end)
  end

  test "playstation" do
    [
      "Mozilla/5.0 (PlayStation; PlayStation 4/8.00) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/12.0 Safari/605.1.15",
      "PS4Application libhttp/1.000 (PS4) CoreMedia libhttp/8.50 (PlayStation 4)",
      "PS3Application libhttp/4.8.7-000 (CellOS)",
      "Mozilla/5.0 (PLAYSTATION 3 4.87) AppleWebKit/531.22.8 (KHTML, like Gecko)"
    ]
    |> Enum.each(fn ua ->
      assert %Result{os: "playstation", type: :smart_tv} = OsDetect.parse(ua)
    end)
  end

  test "xbox" do
    [
      "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Xbox/2003.1001.4.0 Chrome/69.0.3497.128 Electron/4.2.2 Safari/537.36",
      "Xbox/2.0.4548.0 UPnP/1.0 Xbox/2.0.4548.0",
      "Roblox/XboxOne ROBLOX Xbox App 1.0.0",
      "Xbox Live Client/2.0.17003.0",
      "Xbox/2006.0624.0124 (com.microsoft.smartglass; build:2006.0624.0124; iOS 12.4.8) Alamofire/4.7.3",
      "Mozilla/5.0 (Windows NT 10.0; Win64; x64; XBOX_ONE_ED) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.75 Safari/537.36"
    ]
    |> Enum.each(fn ua ->
      assert %Result{browser: "xbox", os: "xbox", type: :smart_tv} = OsDetect.parse(ua)
    end)
  end

  test "netcast" do
    [
      "GStreamer souphttpsrc (compatible; LG NetCast.TV-2013) libsoup/2.54.1",
      "Mozilla/5.0 (Linux; NetCast; U) AppleWebKit/538.39.41 (KHTML like Gecko) Chrome/22.0.1229.79 Safari/ 538.39.41 SmartTV/4.6",
      "Mozilla/5.0 (Linux; NetCast) AppleWebKit/538.39.41 (KHTML like Gecko) Chrome/22.0.1229.79 Safari/538.39.41 SmartTV/4.6",
      "Mozilla/5.0 (DirectFB; U; Linux mips; en) AppleWebKit/531.2+ (KHTML, like Gecko) Safari/531.2+ LG Browser/4.0.10(+SCREEN+TUNER; LGE; 42LE5500-SA; 04.02.02; 0x00000001;); LG NetCast.TV-2010"
    ]
    |> Enum.each(fn ua ->
      assert %Result{browser: "netcast", os: "netcast", type: :smart_tv} = OsDetect.parse(ua)
    end)
  end

  test "lg" do
    [
      "Mozilla/5.0 (DirectFB; Linux armv7l) AppleWebKit/537.1+ (KHTML, like Gecko) Safari/537.1+ LG Browser/6.00.00(+SCREEN+TUNER; LGE; 55LH5750-UB; 04.10.05; 0x00000001; LCD_SS1A); LG SimpleSmart.TV-2016/04.10.05 (LG, 55LH5750-UB, wireless)",
      "Mozilla/5.0 (DirectFB; Linux armv7l) AppleWebKit/537.1+ (KHTML, like Gecko) Safari/537.1+ LG Browser/6.00.00(+SCREEN+TUNER; LGE; 32LH570B-UC; 04.10.04; 0x00000001; LCD_SS1A); LG SimpleSmart.TV-2016/04.10.04 (LG, 32LH570B-UC, wireless)",
      "Mozilla/5.0 (Unknown; Linux armv7l) AppleWebKit/537.1+ (KHTML, like Gecko) Safari/537.1+ LG Browser/6.00.00(+mouse+3D+SCREEN+TUNER; LGE; model_name; 00.00.00; 0x00000001; LCD_SS1A); LG SimpleSmart.TV-2016 /00.00.00 (LG, model_name, wired)"
    ]
    |> Enum.each(fn ua ->
      assert %Result{browser: "lg", os: "lg", type: :smart_tv} = OsDetect.parse(ua)
    end)
  end

  test "commscope" do
    # https://www.commscope.com/solutions/in-home-service-delivery/video-device-platforms/
    [
      "Mozilla/5.0 (Linux armv7l) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.120 Safari/537.36 OPR/46.0.2207.0 OMI/4.20.2.31.Bravo.155 Model/ARRIS-IPC4100, Commscope_STB_BCM7271C0_2018/KA31.00.05.14 (Verizon, IPC4100, Wired)[bcd971fc963ccd3718e27b44"
    ]
    |> Enum.each(fn ua ->
      assert %Result{browser: "commscope", os: "commscope", type: :smart_tv} = OsDetect.parse(ua)
    end)
  end

  test "hisense" do
    [
      "Mozilla/5.0 (Linux armv7l) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/53.0.2785.143 Safari/537.36 OPR/40.0.2207.0 OMI/4.9.0.183.Catcher.151 Model/Hisense-MSD6586 (Hisense;HU55A6100UW;V0000.01.00a.K0829) MST6586"
    ]
    |> Enum.each(fn ua ->
      assert %Result{browser: "hisense", os: "hisense", type: :smart_tv} = OsDetect.parse(ua)
    end)
  end

  test "vizio" do
    [
      "Mozilla/5.0 (Linux armv7l) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.112 Safari/537.36 OPR/36.0.2128.0 OMI/4.8.0.129.ALISHAN6.19 VIZIO-DTV/V7.20.8 (Vizio, D48f-E0, wireless)",
      "Mozilla/5.0 (Linux armv7l) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/53.0.2785.143 Safari/537.36 OPR/40.0.2207.0 OMI/4.9.0.237.Clio.15 , _TV_D55-E0-UHD/17D-1.2.1.8-UHD (Vizio, D55-E0, Wired) Model/SigmaDesigns-SX7"
    ]
    |> Enum.each(fn ua ->
      assert %Result{browser: "vizio", os: "vizio", type: :smart_tv} = OsDetect.parse(ua)
    end)
  end

  test "sony bravia" do
    [
      "Mozilla/5.0 (Linux; BRAVIA 4K 2015 Build/LMY48E.S265) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.101 Safari/537.36 OPR/28.0.1754.0",
      "Opera/9.80 (Linux armv7l; Opera TV Store/6222) Presto/2.12.407 Version/12.50 Model/Sony-KJ-48W700C SonyCEBrowser/1.0 (KJ-48W700C; CTV/PKG2.401JPA; JPN)",
      "Mozilla/5.0 (Linux; Android 9; BRAVIA 4K UR2) AppleWebKit/537.36 (KHTML, like Gecko) SamsungBrowser/13.0 Chrome/83.0.4103.106 Mobile Safari/537.36"
    ]
    |> Enum.each(fn ua ->
      assert %Result{browser: "sony bravia", os: "sony bravia", type: :smart_tv} =
               OsDetect.parse(ua)
    end)
  end

  test "philips" do
    [
      "Mozilla/5.0 (Linux armv7l) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.112 Safari/537.36 OPR/36.0.2128.0 OMI/4.8.0.129.Driver3.34, _TV_MT5802/018.005.007.001 (Philips, PUS6523, wireless)  CE-HTML/1.0 NETTV/4.6.0.1 SignOn/2.0 SmartTvA/5.0.0 en",
      "Mozilla/5.0 (Linux aarch64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.112 Safari/537.36 OPR/36.0.2128.0 OMI/4.8.0.129.Driver6.32 , _TV_MT5806/092.003.166.031 (Philips, PUG6654, wireless)  CE-HTML/1.0 NETTV/4.6.0.2 SignOn/2.0 SmartTvA/5.0.0 W",
      "Mozilla/5.0 (Linux; Andr0id 9.0; TPM191E Build/PTT1.181130.001) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.112 Safari/537.36 OPR/32.0.2128.0 OMI/4.8.0.129.Sprinter7.172",
      "Mozilla/5.0 (Linux; Andr0id 9; TPM191E) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.120 Safari/537.36 OPR/46.0.2207.0 OMI/4.20.3.56.Typhoon.42 Model/TPVision-MT5599-2k18",
      "Mozilla/5.0 (Linux; Andr0id 8.0; TPM171E Build/OC) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.112 Safari/537.36 OPR/32.0.2128.0 OMI/4.8.0.129.Sprinter6.112",
      "Mozilla/5.0 (Linux; Andr0id 8.0; QM163E Build/OPR5.170623.014) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.112 Safari/537.36 OPR/32.0.2128.0 OMI/4.8.0.142.Racer2.51"
    ]
    |> Enum.each(fn ua ->
      assert %Result{browser: "philips", os: "philips", type: :smart_tv} = OsDetect.parse(ua)
    end)
  end

  test "toshiba" do
    [
      "Mozilla/5.0 (Linux; U; Linux; ja-jp; DTV; TSBNetTV/T3E01CD.0203.DDD) AppleWebKit/536(KHTML, like Gecko) NX/3.0 (DTV; HTML; R1.0;) DTVNetBrowser/2.2 (000039;T3E01CD;0203;DDD) InettvBrowser/2.2 (000039;T3E01CD;0203;DDD)"
    ]
    |> Enum.each(fn ua ->
      assert %Result{browser: "toshiba", os: "toshiba", type: :smart_tv} = OsDetect.parse(ua)
    end)
  end

  test "shivaki" do
    # http://shivaki.com/catalogue/50-55.html
    [
      "Mozilla/5.0 (Linux; Andr0id 6.0; SHIVAKI Andr0id TV Build/MRA58K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.112 Safari/537.36 OPR/32.0.2128.0 OMI/4.8.0.53.Junand.16"
    ]
    |> Enum.each(fn ua ->
      assert %Result{browser: "shivaki", os: "shivaki", type: :smart_tv} = OsDetect.parse(ua)
    end)
  end

  test "air tv" do
    [
      "Mozilla/5.0 (QSP; Air TV; AP; 6.2.40.2410)"
    ]
    |> Enum.each(fn ua ->
      assert %Result{browser: "air tv", os: "air tv", type: :smart_tv} = OsDetect.parse(ua)
    end)
  end

  test "verizon stb" do
    [
      "Mozilla/5.0 (Linux mips) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/53.0.2785.143 Safari/537.36 OPR/40.0.2207.0 OMI/4.9.0.176.Bravo.51 Model/ARRIS-VMS1100, Verizon_STB_Bcm/KA23.12.04.01 (Verizon, VMS1100, wired)[612e70728ce266f4623fb97e7cfa28ee0b0b5c65"
    ]
    |> Enum.each(fn ua ->
      assert %Result{browser: "verizon stb", os: "verizon stb", type: :smart_tv} =
               OsDetect.parse(ua)
    end)
  end

  test "aoc tv" do
    # aoc.com
    [
      "Mozilla/5.0 (Linux armv7l) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.112 Safari/537.36 OPR/36.0.2128.0 OMI/4.8.0.66.Driver2.33 , AOC_TV/012.002.067.001 (AOC, LE43S5970-20, wireless) CE-HTML/1.0 NETTV/4.5.0 SignOn/2.0 SmartTvA/4.0.0 en"
    ]
    |> Enum.each(fn ua ->
      assert %Result{browser: "aoc tv", os: "aoc tv", type: :smart_tv} = OsDetect.parse(ua)
    end)
  end

  test "panasonic" do
    [
      # https://www.panasonic.com/pe/consumo/televisores/smart-viera-tv.html
      "Mozilla/5.0 (Linux; U; Viera; pt-BR) AppleWebKit/537.36 (KHTML, like Gecko) Viera/4.0.0 Chrome/51.0.2704.100 Safari/537.36 SmartTV"
    ]
    |> Enum.each(fn ua ->
      assert %Result{browser: "panasonic", os: "panasonic", type: :smart_tv} = OsDetect.parse(ua)
    end)
  end

  test "zeasn" do
    # https://www.zeasn.com/
    [
      "Zeasn/2.0 NETTV/4.5.0 Mozilla/5.0 (Linux;CE-HTML/1.0;U;en), Chrome/42.0.2311.152 Safari/537.36 AppleWebKit 537.36 (KHTML, like Gecko) Tbrowser/2.0, _TV_nt563/V8-NT563NA-LF1V291 (JVC,32D1290,wireless)"
    ]
    |> Enum.each(fn ua ->
      assert %Result{browser: "zeasn", os: "zeasn", type: :smart_tv} = OsDetect.parse(ua)
    end)
  end

  test "plex" do
    [
      "Plex; 1.27.2.1599-7689068b; Windows 10 Version 2009",
      "PlexMobile/7.8.1 (iPad; iOS 14.4.2; Scale/2.00)",
      "Plex; 1.25.0.1511-47afccd4; macOS High Sierra (10.13)",
      "PlexMobile/7.16 (iPad; iOS 14.4.2; Scale/2.00)",
      "Plex; 1.31.0.2254-43df1e6e; macOS High Sierra (10.13)",
      "Plex; 1.30.1.2115-81e1fc3f; Windows 10 Version 1809",
      "Plex/8.4.2.19372 (Linux;Android 5.1.1) ExoPlayerLib/2.10.3",
      "Plex; 1.31.0.2254-43df1e6e; macOS Mojave (10.14)",
      "Plex; 1.29.0.1885-67668ec3; Windows 10 Version 2009",
      "PlexMobile/7.11 (iPhone; iOS 14.4.2; Scale/3.00)",
      "Plex/8.12.4.22902 (Linux;Android 5.1.1) ExoPlayerLib/2.12.1",
      "Plex; 1.24.0.1483-714cba36; macOS High Sierra (10.13)",
      "Plex/8.15.2.24006 (Linux;Android 7.0) ExoPlayerLib/2.12.1",
      "Plex; 1.17.0.1376-439f8b7f; Windows 10 Version 2009",
      "Plex; 1.23.0.1435-e10e14cf; Windows 10 Version 1909",
      "Plex; 1.28.0.1681-cc6e807c; Windows 10 Version 2009",
      "Plex; 1.26.0.1531-92029e9e; Windows 10 Version 2009",
      "Plex/8.14.0.23432 (Linux;Android 9) AmznExoPlayerLib/2.12.1"
    ]
    |> Enum.each(fn ua ->
      assert %Result{browser: "plex", os: "plex", type: :smart_tv} = OsDetect.parse(ua)
    end)
  end

  test "os/2" do
    # https://en.wikipedia.org/wiki/OS/2
    [
      {"firefox", "Mozilla/5.0 (OS/2; Warp 4.5; rv:45.0) Gecko/20100101 Firefox/45.0"}
    ]
    |> Enum.each(fn {browser, ua} ->
      assert %Result{browser: ^browser, os: "os/2", type: :desktop} = OsDetect.parse(ua)
    end)
  end

  test "kai os" do
    # https://www.kaiostech.com/ the continuation of Firefox's mobile os
    [
      "Mozilla/5.0 (Mobile; rv:48.0; A405DL) Gecko/48.0 Firefox/48.0 KAIOS/2.5",
      "Mozilla/5.0 (Mobile; ALCATEL4044N; rv:37.0) Gecko/37.0 Firefox/37.0 Kai/1.0"
    ]
    |> Enum.each(fn ua ->
      assert %Result{browser: "firefox", os: "kai os", type: :mobile} = OsDetect.parse(ua)
    end)
  end

  test "nintendo" do
    [
      {"nintendo switch",
       "Mozilla/5.0 (Nintendo Switch; WifiWebAuthApplet) AppleWebKit/606.4 (KHTML, like Gecko) NF/6.0.1.16.10 NintendoBrowser/5.1.0.20923"}
    ]
    |> Enum.each(fn {os, ua} ->
      assert %Result{browser: "nintendo", os: ^os, type: :other} = OsDetect.parse(ua)
    end)
  end

  test "nokia" do
    [
      "Nokia6280/2.0 (03.60) Profile/MIDP-2.0 Configuration/CLDC-1.1"
    ]
    |> Enum.each(fn ua ->
      assert %Result{browser: "nokia", os: "nokia", type: :mobile} = OsDetect.parse(ua)
    end)
  end

  test "bots" do
    [
      "Mozilla/5.0 (compatible; Bingbot/2.0; +http://www.bing.com/bingbot.htm)",
      "Mozilla/5.0 (compatible; Yahoo! Slurp; http://help.yahoo.com/help/us/ysearch/slurp)",
      "DuckDuckBot/1.0; (+http://duckduckgo.com/duckduckbot.html)",
      "Mozilla/5.0 (Unknown; Linux x86_64) AppleWebKit/534.34 (KHTML, like Gecko) PhantomJS/1.9.0 Safari/534.34",
      "Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)",
      "Mozilla/5.0 (compatible; YandexBot/3.0; +http://yandex.com/bots)",
      "Mozilla/5.0 (iPhone; CPU iPhone OS 8_1 like Mac OS X) AppleWebKit/600.1.4 (KHTML, like Gecko) Version/8.0 Mobile/12B411 Safari/600.1.4 (compatible; YandexMobileBot/3.0; +http://yandex.com/bots)",
      "Mozilla/5.0 (compatible; YandexAccessibilityBot/3.0; +http://yandex.com/bots)",
      "Mozilla/5.0 (iPhone; CPU iPhone OS 14_2 like Mac OS X) AppleWebKit/610.2.11 (KHTML, like Gecko) Mobile/18B92 jigsawpuzzle/134",
      "Apache/2.4.34 (Ubuntu) OpenSSL/1.1.1 (internal dummy connection)",
      "Mozilla/5.0 (compatible; Seekport Crawler; http://seekport.com/",
      "Sogou web spider/4.0(+http://www.sogou.com/docs/help/webmasters.htm#07)",
      "Mozilla/5.0 (compatible; AhrefsBot/7.0; +http://ahrefs.com/robot/)",
      "AdsBot-Google (+http://www.google.com/adsbot.html)",
      "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_1) AppleWebKit/600.2.5 (KHTML, like Gecko) Version/8.0.2 Safari/600.2.5 (Applebot/0.1; +http://www.apple.com/go/applebot)",
      "Mozilla/5.0 (compatible; Yahoo Ad monitoring; https://help.yahoo.com/kb/yahoo-ad-monitoring-SLN24857.html)  tands-prod-eng.hlfs-prod---sieve.hlfs-desktop/1605741856-0",
      "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/74.0.3729.157 Safari/537.36",
      "Mozilla/5.0 (Linux; 906SH Build/S1004; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/90.0.4430.91 YJApp-ANDROID jp.co.yahoo.android.ybrowser/3.11.1.1 MicroAdBot/1.1 (https://www.microad.co.jp/contact/)",
      "Mozilla/5.0 (compatible; AddSearchBot/1.0; +http://www.addsearch.com/bot/)",
      "Mozilla/5.0 (compatible;PetalBot;+https://webmaster.petalsearch.com/site/petalbot)",
      "Mozilla/5.0 (Linux; Android 7.0; C Bot Tab 100) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.125 Safari/537.36",
      "Mozilla/5.0 (compatible; Cincraw/1.0; +http://cincrawdata.net/bot/)",
      "Mozilla/5.0 (compatible; KantarSifoMediaAuditBot/1.1; +https://www.kantarsifo.se/mediaaudit)",
      "Mozilla/5.0 (compatible; proximic; +https://www.comscore.com/Web-Crawler)",
      "Mozilla/5.0 (TweetmemeBot/4.0; +http://datasift.com/bot.html) Gecko/20100101 Firefox/31.0",
      "proxy_ip:207.90.15.45:60000 AccompanyBot",
      "akka-http/10.1.13",
      "curl/7.64.1",
      "okhttp/4.8.1",
      "Python/3.7 aiohttp/3.6.3",
      "NinjBot/2.0 (+http://www.webuildpages.com)",
      "Mozilla/5.0 (Linux; Android 8.0.0; Nexus 5X Build/OPR4.170623.006) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/75.0.3765.0 Mobile Safari/537.36 (compatible; TiggeritoBot/1.0; +https://websiteadvantage.com.au/)",
      "Mozilla/5.0 (compatible; Pinterestbot/1.0; +http://www.pinterest.com/bot.html)",
      "facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)",
      "Mozilla/5.0 (compatible; Yeti/1.1; +http://help.naver.com/support/robots.html)",
      "Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; GoogleAdwordsExpress) Chrome/89.0.4389.127 Safari/537.36",
      "Mozilla/5.0 (compatible; Squidbot/1.0)",
      "MAZBot/1.0 (http://mazdigital.com)",
      "Mozilla/5.0 (Linux; Android 4.0.4; Galaxy Nexus Build/IMM76B) AppleWebKit/535.19 (KHTML, like Gecko) Chrome/18.0.1025.133 Mobile Safari/535.19 moatbot",
      "Apache-HttpClient/4.5.12 (Java/11.0.7)",
      "site24x7",
      "Screaming Frog SEO Spider/14.2",
      "Mozilla/5.0 (en-us) AppleWebKit/534.14 (KHTML, like Gecko; Google Wireless Transcoder) Chrome/9.0.597 Safari/534.14",
      # Googlebots: https://developers.google.com/search/docs/advanced/crawling/overview-google-crawlers
      "APIs-Google (+https://developers.google.com/webmasters/APIs-Google.html)",
      "Mediapartners-Google",
      "AdsBot-Google (+http://www.google.com/adsbot.html)",
      "Googlebot-Image/1.0",
      "Googlebot-News",
      "Googlebot-Video/1.0",
      "Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)",
      "Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; Googlebot/2.1; +http://www.google.com/bot.html) Chrome/W.X.Y.Z‡ Safari/537.36",
      "Googlebot/2.1 (+http://www.google.com/bot.html)",
      "Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) compatible; Mediapartners-Google/2.1; +http://www.google.com/bot.html)",
      "AdsBot-Google-Mobile-Apps",
      "FeedFetcher-Google; (+http://www.google.com/feedfetcher.html)",
      "google-speakr",
      "Mozilla/5.0 (Linux; Android 8.0; Pixel 2 Build/OPD3.170816.012; DuplexWeb-Google/1.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.131 Mobile Safari/537.36",
      "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.75 Safari/537.36 Google Favicon",
      "Mozilla/5.0 (Linux; Android 4.2.1; en-us; Nexus 5 Build/JOP40D) AppleWebKit/535.19 (KHTML, like Gecko; googleweblight) Chrome/38.0.1025.166 Mobile Safari/535.19",
      "Mozilla/5.0 (X11; Linux x86_64; Storebot-Google/1.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.88 Safari/537.36",
      "Mozilla/5.0 (Linux; Android 8.0; Pixel 2 Build/OPD3.170816.012; Storebot-Google/1.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/81.0.4044.138 Mobile Safari/537.36",
      "Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.96 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)",
      "Mozilla/5.0 (Linux; Android 5.0; SM-G920A) AppleWebKit (KHTML, like Gecko) Chrome Mobile Safari (compatible; AdsBot-Google-Mobile; +http://www.google.com/mobile/adsbot.html)",
      "Mozilla/5.0 (iPhone; CPU iPhone OS 9_1 like Mac OS X) AppleWebKit/601.1.46 (KHTML,like Gecko) Version/9.0 Mobile/13B143 Safari/601.1 (compatible; AdsBot-Google-Mobile; +http://www.google.com/mobile/adsbot.html)",
      "Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/W.X.Y.Z‡ Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)",
      "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.118 Safari/537.36 (compatible; Google-Read-Aloud; +https://developers.google.com/search/docs/advanced/crawling/overview-google-crawlers)",
      "Mozilla/5.0 (Linux; Android 7.0; SM-G930V Build/NRD90M) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.125 Mobile Safari/537.36 (compatible; Google-Read-Aloud; +https://developers.google.com/search/docs/advanced/crawling/overview-google-crawlers)"
    ]
    |> Enum.each(fn ua ->
      %Result{type: type} = OsDetect.parse(ua)
      assert type in [:bot, :unknown]
    end)
  end

  test "type: :other" do
    # Samgsung Refrigerator
    assert %Result{type: :other, browser: "samsung family hub", os: "tizen"} ==
             OsDetect.parse(
               "Mozilla/5.0 (Linux; Tizen 3.0; FamilyHub) AppleWebKit/537.3 (KHTML, like Gecko) Version/2.3 Mobile Safari/537.3"
             )
  end

  test "unknown" do
    [
      "Opera/9.80 (J2ME/MIDP; Opera Mini/5.1.21214/28.2725; U; ru) Presto/2.8.119 Version/11.10",
      "Mozilla/4.0 (compatible; MSIE 4.5; Mac_PowerPC)",
      "   ",
      "",
      nil
    ]
    |> Enum.each(fn ua ->
      assert %Result{type: :unknown} = OsDetect.parse(ua)
    end)
  end
end
