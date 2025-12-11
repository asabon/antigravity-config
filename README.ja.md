# Antigravity Configuration

**Antigravity** エージェントコーディングアシスタントのための共有設定リポジトリです。このリポジトリは、複数のプロジェクト間で共有できるルール、ワークフロー、および設定を一元管理するために使用されます。

## 概要

このリポジトリが提供するもの:

- **グローバルルール**: `.antigravity.yml` に定義された、標準化されたコーディングガイドラインとエージェントの振る舞い。
- **ワークフロー**: `.agent/workflows` にある再利用可能なエージェントワークフロー（init, resume, save など）。
- **ユーザー設定**: エージェントとの対話設定をカスタマイズするためのテンプレート。

## 始め方

1. **サブモジュールとして追加**:
   プロジェクトのルートディレクトリで以下のコマンドを実行し、このリポジトリをサブモジュールとして追加してください。
   ```bash
   git submodule add <REPOSITORY_URL> .shared-config
   ```

2. **セットアップスクリプトの実行**:
   必要なシンボリックリンクや設定ファイルを作成するために、セットアップスクリプトを実行します。

   **Windows (PowerShell):**
   ```powershell
   ./.shared-config/scripts/setup.ps1
   ```

   **macOS / Linux:**
   ```bash
   chmod +x .shared-config/scripts/setup.sh
   ./.shared-config/scripts/setup.sh
   ```

3. **`.gitignore` の設定**:
   プロジェクトの `.gitignore` に以下を追加してください。
   ```gitignore
   .work/
   .agent/config.yml
   ```

4. **設定のカスタマイズ**:
   `.agent/config.yml` を編集して、言語設定等を変更してください。

## ディレクトリ構成

```
.
├── .agent/
│   ├── config.yml.sample   # ユーザー固有設定のテンプレート
│   └── workflows/          # 共有エージェントワークフロー
├── .antigravity.yml        # コア設定とルール定義
├── README.md               # ドキュメント（英語）
└── README.ja.md            # このファイル（日本語）
```

## 貢献について

- このリポジトリ内のルールやドキュメントは **英語** で記述してください。
- 内部的なコミュニケーション（チャット等）は、ローカルの `config.yml` の設定に従います。
