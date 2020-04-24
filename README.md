<div align="center">
  <a href="https://phraselib.work">
    <img src="https://user-images.githubusercontent.com/59187251/78864468-a28b7700-7a76-11ea-8d22-df9a2dc119c4.png" width="200">
  </a>
</div>

# About
Phrase.libは、ワンフレーズのみの投稿アプリケーションです。<br />
非ログイン時は閲覧のみ、ログイン後は、投稿、編集を行うことができます。<br />
基本的なCRUD機能の他、外部APIと連携した会員登録機能、翻訳機能、投稿と関連づく商品検索等を実装しています。

# URL
https://phraselib.work にアクセスしてください。

# Built with
- Ruby v.2.5.7
- Rails v.5.2.4.1
- Gem
  - <a href="https://docs.google.com/spreadsheets/d/1ZZj6fMFO6sZn-UmaIGmRy14gnBIFzHmhs0Nt3umSMZ8/edit?usp=sharing">Googleスプレッドシートにまとめています。</a>
- GoogleAppsScript
- DB: MySQL
- OS: Linux
- WEBサーバー: nginx
- アプリケーションサーバー: puma
<div align="center">
  <img src="https://user-images.githubusercontent.com/59187251/79635254-e2efa100-81aa-11ea-8e9b-2aa2c27a12eb.jpg">
</div>

# Features
- ユーザー関連
  - メールアドレスを用いたユーザー登録
  - Twitter、GoogleでのOAuth認証
  - プロフィール画像の登録
  - パスワードリセットトークンのメール送信
- 投稿関連
  - CRUD機能
  - 英語、中国語等の翻訳機能（非同期化）
  - 公開範囲の設定
  - いいね！機能（非同期化）
  - 共有用の短縮URL生成
- 検索関連
  - ユーザー、投稿検索機能
  - 楽天市場での関連商品検索（非同期化）
- その他
  - 問い合わせ内容のメール送信、LINE通知
  - RSpec、Capybara、Factorybotを用いたテスト実施

# Background
製作経緯等をスライド形式で掲載しております。<br />
<a href="https://drive.google.com/file/d/1_vRqxU3VpQRyvyB1xux-ZDm23wWQlCJ_/view?usp=sharing">Googleスライド</a>

# Author
[stat-ki](https://github.com/stat-ki)  
mail to: per_ik at outlook.com
