# AeroSKK #
Mac で SKY配列 + SKK したい。

- **SKY配列**: 左手に子音、右手に母音が割り振られている交互打鍵重視ローマ字入力配列。  
  http://ja.wikipedia.org/wiki/SKY%E9%85%8D%E5%88%97
- **SKY#配列**: SKY配列に中指シフトを導入して拗音(ゃゅょ)の入力を促進した配列。  
  http://homepage2.nifty.com/Khwarizmi/type/skysharp.html
- **SKK**: 大文字で変換ポイントを明示する漢字変換メソッド。  
  http://openlab.ring.gr.jp/skk/index-j.html

## 環境 ##
- OSX 10.9
- RubyMotion 2.19

## インストール ##
`rake install`

development 版がビルドされ、`~/Library/InputMethod` にインストールされる。

## アンインストール ##
`rake uninstall`

インストールされたファイル一式を削除する。
AeroSKK のプロセスが存在する場合は、`kill` する。

## テスト ##
`guard start`

### 問題 ###
たまにフリーズすることがある。
どこかで nil 参照しているのが問題らしいが、原因はよく分からない。

    2014-01-12 13:07:52.122 AeroSKK[66154:303] *nil description*

こうなったら guard のプロセスを kill して、再開させる。
プロセスIDは `AeroSKK[xxxxx:yyy]` の `xxxxx` の部分。

    kill 66154
    guard start

## 参考 ##
- **Gyaim**: MacRuby 製の IME。  
  https://github.com/masui/Gyaim
- **Input Method Kit**: 公式リファレンス  
  https://developer.apple.com/library/mac/documentation/Cocoa/Reference/InputMethodKitFrameworkRef/_index.html
