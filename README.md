# 注意点
- 直前にモノレポにしたので、困ったらこっちのリポジトリでバックエンドを立ち上げてください。一応一回はdeployして動作確認してます
  * https://github.com/bannzai/zennAIHackathonBackend/
- `TODOMaker Flutter App` と `TODOMaker Backend` とセットアップ方法が分かれています。すべてこのREADMEに記載されています

### 動作
ref: https://zenn.dev/bannzai/articles/12d0443426876e#%E5%8B%95%E4%BD%9C%E3%81%95%E3%81%9B%E3%82%8B%E4%B8%8A%E3%81%A7%E3%81%AE%E6%B3%A8%E6%84%8F%E7%82%B9
- Geminiのエラーで429 Too Many Requestが時たま発生します。Cloud Tasksを利用して並行にGeminiを使用しているので発生しやすくなります。リトライもある程度設定してますが、クライアント側の表示とCloud Tasksを利用しての非同期処理の進捗状況やエラー表示について同期を取る仕組みは用意していません。雑に「時間がかかったら停止してやり直してね」という機能は用意されているので5分とかかかってたらやり直してみてください。一番良いのはGeminiの制限を緩めるようにGoogleにお願いすることです
- GeminiのJSON Modeで string | null の型を指定した場合に 「"null"」って文字が返ってくることがしばしばあります。AIの精度が上がれば解決するのでそのまま表示される場所もあったりします
- 実機では全部動きます。Simulator,Emulatorだと動かなかったり、動作が微妙機能があります。Geo Coding, LocationやCalendarへの追加機能がありそこら辺です


# TODOMaker Flutter App
## Setup
1. Firebaseプロジェクトを用意してください。バックエンドと一緒なプロジェクトにする必要があります。
2. iOS・Androidのプロジェクトを作成します。その際にiOS→GoogleService-Info.plist,Android→google-services.json を落としてください
3. 次の環境変数を用意してください。Makefileを参考に
- FILE_FIREBASE_IOS: GoogleService-Info.plist を base64したもの
- FILE_FIREBASE_ANDROID: google-services.json を base64したもの
4. `$ make secret` を実行します
5. 好きな方法でFlutterアプリを起動してください。著者はいつもVSCodeのFlutter extensionで起動しています。CLIだと `$ flutter run`だと思います。参考までに実際使っているVSCodeのlaunch.jsonを貼っておきます

```
{
    // Use IntelliSense to learn about possible attributes.
    // Hover to view descriptions of existing attributes.
    // For more information, visit: https://go.microsoft.com/fwlink/?linkid=830387
    "version": "0.2.0",
    "configurations": [
        {
            "name": "zenn_ai_hackathon",
            "request": "launch",
            "type": "dart"
        },
        {
            "name": "zenn_ai_hackathon (profile mode)",
            "request": "launch",
            "type": "dart",
            "flutterMode": "profile"
        },
        {
            "name": "zenn_ai_hackathon (release mode)",
            "request": "launch",
            "type": "dart",
            "flutterMode": "release"
        }
    ]
}

```

## 実行時の注意点
iOSの実機実行はApple Developerのチームに属する必要があったかもしれません(違うかもしれない)。実機実行する際は何かしらエラーが出た場合はその点を疑ってください。Androidに関しては全く覚えてないですが、何もしなくても`$ flutter run` や`$ flutter build appbundle --release` で作成したapkさえインストールできれば起動できる気がします


# TODOMaker Backend
## Setup
1. node のバージョンはv22系です
```bash
$ node --version
v22.12.0
```
2. Firebaseプロジェクトを一つ作ってください
3. 次に `.firebaserc` を作成します。このリポジトリでは .gitignoreしています

```
{
  "projects": {
    "default": "PROJECT_NAME" ← ここにプロジェクトネーム入れる
  }
}
```

## Env
See [.env.sample](./functions/.env.sample)

```
# localhostで起動する場合は local を設定。あとはdev,prodどちらでも良い
APP_ENV=dev
# 多分ここから取得。https://aistudio.google.com/app/apikey?hl=ja
GOOGLE_GENAI_API_KEY=
# この命名のサービスアカウントがいるのでそれを使います。何必要かは忘れました(Cloud TasksのURLを取得だったかな)
GOOGLE_APPLICATION_CREDENTIALS_SERVICE_ACCOUNT_ID=PROJECT_ID@appspot.gserviceaccount.com
```

## Development
`Env` を用意します。ただ、localhostで動作確認する場合は APP_ENV=local に設定してください。authが無効になるのでdeploy時は気をつけてください
`functions` ディレクトリに移動して `npm run genkit:start` をします

`
$ cd functions
$ npm run genkit:start
`

http://localhost:4000/ からgenkitのWeb UIから動作確認できます

## Deploy

functionsディレクトリに移動します。firebase deployをすればdeployされますが、./lib とかも消したい場合は以下のようにしています

```
$ cd functions
$ rm -rf ./lib && npm run build && firebase deploy --only functions
```

また、IAMの権限の問題で何かが必要なことがあったかもしれません。なんの権限か忘れましたが、エラーメッセージに表示されると思います。必要があれば連絡ください
