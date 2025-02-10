
## バックエンド・APIのリポジトリ
https://github.com/bannzai/zennAIHackathonBackend/

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

