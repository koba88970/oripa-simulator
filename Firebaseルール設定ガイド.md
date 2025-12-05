# Firebase Realtime Database ルール設定ガイド

## 🚨 エラーが出る場合

コンソールに以下のエラーが表示される場合、Firebaseのセキュリティルールを設定する必要があります：

```
❌ Error: permission_denied at /temporaryPrizeMaster
❌ Error: permission_denied at /prizeMaster
```

## 📋 現在の動作

エラーが出ていても、**アプリは正常に動作します**：

- ✅ データは**localStorageに保存**されます
- ✅ 同じブラウザ内では完全に使用可能
- ❌ 別のデバイスとの同期はできません
- ❌ クラウド保存機能は使えません

## 🔧 Firebaseルールの設定方法

### 手順1: Firebase Consoleにアクセス

1. [Firebase Console](https://console.firebase.google.com/) を開く
2. プロジェクトを選択

### 手順2: Realtime Databaseのルールを開く

1. 左メニューから「**ビルド**」→「**Realtime Database**」を選択
2. 上部タブから「**ルール**」を選択

### 手順3: ルールを編集

現在のルールを以下のように変更してください：

#### パターンA：完全オープン（開発用・推奨）

```json
{
  "rules": {
    ".read": true,
    ".write": true
  }
}
```

**メリット**：
- ✅ すぐに使える
- ✅ 認証不要
- ✅ テストに最適

**デメリット**：
- ⚠️ 誰でもデータを読み書きできる
- ⚠️ 本番環境では非推奨

#### パターンB：認証済みユーザーのみ（推奨）

```json
{
  "rules": {
    ".read": "auth != null",
    ".write": "auth != null"
  }
}
```

**メリット**：
- ✅ 認証済みユーザーのみアクセス可能
- ✅ 匿名認証でも動作
- ✅ セキュリティが高い

**デメリット**：
- Firebase認証が必須（既に実装済み）

#### パターンC：パスごとに詳細設定（最も安全）

```json
{
  "rules": {
    "oripas": {
      ".read": "auth != null",
      ".write": "auth != null"
    },
    "prizeMaster": {
      ".read": "auth != null",
      ".write": "auth != null"
    },
    "temporaryPrizeMaster": {
      ".read": "auth != null",
      ".write": "auth != null"
    },
    "configs": {
      ".read": "auth != null",
      ".write": "auth != null"
    }
  }
}
```

**メリット**：
- ✅ パスごとに権限を管理
- ✅ 最も安全
- ✅ 拡張性が高い

### 手順4: ルールを公開

1. 「**公開**」ボタンをクリック
2. 確認ダイアログで「**公開**」を選択

### 手順5: 動作確認

1. ブラウザでアプリを**リロード**（Cmd+R / Ctrl+R）
2. コンソールで以下が表示されることを確認：
   ```
   ✅ 景品マスターをクラウドに保存しました
   ✅ 仮装景品マスターをクラウドに保存しました
   ```

## 🎯 推奨設定

開発中は**パターンA（完全オープン）**、本番では**パターンB（認証済みユーザーのみ）**を推奨します。

現在のアプリは匿名認証を使用しているため、パターンBでも問題なく動作します。

## ⚠️ よくある質問

### Q: エラーが出てもアプリは使えますか？

**A: はい、使えます。**
- データはlocalStorageに保存されます
- 同じブラウザ内では完全に動作します
- ただし、クラウド同期機能は使えません

### Q: ルール設定しないとどうなる？

**A: localStorageのみで動作します。**
- ✅ 単一ブラウザでの使用: 問題なし
- ❌ 複数デバイス間の同期: 不可
- ❌ データのクラウドバックアップ: 不可

### Q: 設定後もエラーが出る場合は？

**A: 以下を確認してください：**
1. ルールを「公開」したか確認
2. ブラウザをリロード（Cmd+R / Ctrl+R）
3. ブラウザのキャッシュをクリア（Cmd+Shift+R / Ctrl+Shift+R）
4. Firebase認証が完了しているか確認（「✅ クラウド接続済み」表示）

### Q: セキュリティは大丈夫？

**A: パターンBまたはCを使用すれば安全です。**
- 匿名認証済みのユーザーのみアクセス可能
- 未認証ユーザーはアクセス不可
- Firebaseが自動的に管理

## 📚 参考リンク

- [Firebase Realtime Database ルール](https://firebase.google.com/docs/database/security)
- [Firebase 認証](https://firebase.google.com/docs/auth)

## 💡 まとめ

1. **エラーが出ても動作はする**（localStorageを使用）
2. **クラウド同期が必要なら**Firebaseルールを設定
3. **推奨設定**はパターンB（認証済みユーザーのみ）
4. **開発中**はパターンA（完全オープン）が簡単
