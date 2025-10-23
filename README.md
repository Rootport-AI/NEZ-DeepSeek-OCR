
# NEZ-DeepSeek-OCR GUI

**NEZ-DeepSeek-OCR GUI**は、画像認識AI「DeepSeek-OCR」を簡単に試すための非エンジニア向けのGUIです（NEZ = Non-Engineer's Zapper）。
スマートフォン等で撮影した**レシートの画像をテキスト化する**ことを主な使用目的として想定しています。

![DeepSeek-OCR_demo_20251023](https://github.com/user-attachments/assets/69836652-b5b5-4702-a2a2-a9004a2537a9)

## DeepSeek-OCRとは？
中国企業DeepSeek社の開発した、オープンウェイトの画像認識AIです。**ローカル環境で（つまり、オフラインのパソコンで）実行できます**。たとえばChatGPTやGeminiなどのオンラインサービスでは、読み取った画像やテキストのデータをOpenAIやGoogleに提供することになります。一方、ローカル環境のDeepSeek-OCRなら、情報を外部に漏らさずに画像をテキスト化できます。

DeepSeek-OCRのAI本体のデータおよび詳細な情報は、HuggingFaceの公式リポジトリで公開されています。（※HuggingFaceとは、AI研究者やAI技術者の情報交流サイトです）
https://huggingface.co/deepseek-ai/DeepSeek-OCR


## 動作検証環境
以下の環境で動作を検証しています。

- **OS:** Windows 11  
  Windows 10でも動くかもしれませんが未検証です。Mac、Linuxは非対応です。

- **GPU:** RTX 4070 Ti SUPER  
  現状ではVRAM 12GB以上のGPUが推奨です。低VRAMマシンやCPU演算は、将来的に対応するかも。

- **使用言語:** Python 3.10  
  別途インストールが必要です（下記参照）。

- **ファイル管理:** git  
  別途インストールが必要です（下記参照）。


---

## インストール方法（非エンジニア向け）
ここでは非エンジニア向けに、インストール方法を解説します。以下6つのステップでインストールしてください。

1. Python 3.10以上をインストールする  
2. gitをインストールする  
3. このアプリのデータをダウンロードする  
4. DeepSeek-OCRのデータをダウンロードする  
5. このアプリに同梱されている`setup.bat`を実行して、インストールする  
6. このアプリに同梱されている`run.bat`を実行して、アプリを起動する

---  

### 1) Python 3.10以上をダウンロードする
Pythonは、生成AI研究で広く使われているプログラミング言語です。このアプリは**Ver.3.10で動作検証**しました。理屈の上では、より新しいバージョンでも動く可能性が高いです（未検証）。検証報告をお待ちしています。

- まずは以下のURLより、Python公式サイトにアクセスしてください。
  https://www.python.org/  
  
![PythonスクショA](https://github.com/user-attachments/assets/b0cdb185-c40e-415d-8b6e-8e89755e909a)  
- ① [Downloads] → ② [Windows] を開きます。  
  
![PythonスクショB](https://github.com/user-attachments/assets/974f82ae-5472-4c21-88b2-b31d8b88d388)  
- ③ページ下部の「3.10.**」から「**Windows installer (64-bit)**」をダウンロードしてください。  
- ダウンロードが完了したら、`python-3.10.**-amd64.exe` を実行してインストールします。  
  
![PythonスクショC](https://github.com/user-attachments/assets/0509d307-6b8b-486d-8379-c56c24cb260d)  
- **Note:** インストール時に **「Add python 3.10 to PATH」** のチェックを必ず入れてください。チェックを入れ忘れると「パスが通っていない」状態になり、上手く動作しません。


### 2) gitをインストールする
Gitとは、オンラインのファイル管理サービスです。現代ではエンジニアの間で広く普及しており、デファクトスタンダードになっています。今回は、`NEZ-DeepSeek-OCR GUI` を動かすために必要なファイルをまとめてダウンロードするために使います。

- Git公式サイト（Windows版）: https://git-scm.com/install/windows  

![Gitスクショ](https://github.com/user-attachments/assets/753809df-367f-41a8-969c-8e7d96c538f7)
- 普通のパソコンなら、`Git for Windows/x64 Setup`を選択してください。
  `ARM64`は、サーバーマシンやモバイル端末などの（いわば）特殊なパソコン向けです。CPUの種類によって区別されます。

- ダウンロードが終わったら、インストーラーを起動してインストールしてください。
  たくさんの質問をされますが、基本的に **すべて「Next」** で問題ありません。
 

### 3) このアプリのデータをダウンロードする

**方法A：ブラウザからZIPで落とす（超かんたん）**  

![githubスクショ01_02](https://github.com/user-attachments/assets/fa620afb-b4cd-46bc-b531-651b10a09389)
1) 緑色の「Code」ボタンを押します。

![githubスクショ02_02](https://github.com/user-attachments/assets/634b6589-d50b-4b68-8dfd-55306c2c7f39)
2) 「Download ZIP」を押します。  
3) このアプリの保存先にしたいフォルダに解凍します。  

**方法B：gitでクローン（中級者向け）**
1) このアプリの保存先にしたいフォルダをWindowsのエクスプローラーで開き、アドレスバーに`cmd`と打ってエンターキーを押します。
2) コマンドプロンプト（黒い画面）が開きます。
3) 以下のコマンドをコピペしてエンターキーを押します。
```bat
git clone https://github.com/Rootport-AI/NEZ-DeepSeek-OCR.git
cd NEZ-DeepSeek-OCR
```
  

### 4) DeepSeek-OCRのデータをダウンロードする

このアプリは**モデル本体だけでは動きません**。Hugging Faceの**DeepSeek-OCRリポジトリを丸ごと**取ってくる必要があります。

1) **先ほどダウンロードした`NEZ-DeepSeek-OCR`フォルダをエクスプローラーで開いて**ください。
たとえば`C:\download`で解凍したなら、`C:\download\NEZ-DeepSeek-OCR`です。  

2) **アドレスバーに`cmd`と打ってエンターキー**を押してください。  
コマンドプロンプト（黒い画面）が開きます。  

3) 以下のコマンドをコピペしてエンターキーを押します。  
```bat
git lfs install
```
画面に`Git LFS initialized`と表示されたら（画面を閉じずに）次の手順に進みます。

4) 以下のコマンドをコピペしてエンターキーを押します。
```bat
git clone https://huggingface.co/deepseek-ai/DeepSeek-OCR
```
DeepSeek-OCR本体のリポジトリのダウンロードが始まります。  
**Note:**DeepSeek-OCRのサイズは6～7GBです。回線速度にもよりますが、ダウンロードには20～30分間かかります。動きが止まっているように見えるときは、**タスクマネージャーなどでダウンロードが進行していることを確認**してみましょう。
![DeepSeek-OCR_ダウンロード02](https://github.com/user-attachments/assets/8202f329-09de-4c13-a238-400c5ccb1834)
ダウンロードが完了していれば、コマンドプロンプトが「入力待ち」の状態になります。入力待ちになっていない＝裏側でダウンロードが進行中です。

5) ダウンロードできたか確認  
`DeepSeek-OCR\model-00001-of-000001.safetensors` の**サイズがGB級**→OK（数KBならダウンロード途中か、LFSに問題があります）。

フォルダ構成イメージ：
```
NEZ-DeepSeek-OCR-GUI/
├─ app.py
├─ setup.bat
├─ run.bat
├─ requirements.txt
├─ static/
│   ├─ index.html
│   ├─ main.js
│   └─ style.css
└─ DeepSeek-OCR/
    ├─ config.json
    ├─ model-00001-of-000001.safetensors
    └─ ...
```

### 6) setup.batをダブルクリックする
これはインストール用のバッチファイルです。初回だけ実行します。  
環境にもよりますが、インストールには10～15分程度かかります。  
  
以下のメッセージが表示されたら、インストール完了です。  
```
Note:
   DeepSeek-OCR itself is not obtained through this script.
   Please download it manually beforehand.

   If your CUDA version is not 11.8, modify the --index-url at the
   beginning of requirements.txt to match your CUDA version (e.g., cu121).

続行するには何かキーを押してください．．．
```

### 7) run.batをダブルクリックする
これはアプリの起動用バッチファイルです。

起動に成功すると、以下の表示（例）が出ます：
```
[RUN] Starting server at http://127.0.0.1:8000/
INFO:     Will watch for changes in these directories: ['S:\\OriginalApps\\04_NEZ-DeepSeek-OCR']
INFO:     Uvicorn running on http://127.0.0.1:8000 (Press CTRL+C to quit)
INFO:     Started reloader process [31260] using WatchFiles
INFO:     Started server process [14820]
INFO:     Waiting for application startup.
INFO:     Application startup complete.
```
`Application startup complete`というメッセージが表示されたら、アプリの起動完了です。
ブラウザで `http://127.0.0.1:8000/` を開けばGUIが表示されます。

---

## 使い方（カンタン版）

1) **画像をドロップ** → プレビューに表示されます  
2) 必要なら**プロンプト**をプリセットボタンで切替  
   - **Standard**：帳票・レシートをMarkdown化
   - **Long Text**：論文・長文向け  
   - **Charts & Figures**：図・チャートの要約  
3) **OCRを実行** → 下のテキスト欄に結果が出ます（**コピー**ボタンで全選択＆コピー）  
4) **フォルダまとめてOCR**：  
   - フォルダパスに `S:\Receipts\2025-03` のように入力  
   - **［まとめてOCRを実行］** → 1枚ずつ処理・連結して出力。  
   - 各画像のテキストは、「`--- --- ---  `」「ファイル名」→その画像のテキスト、というブロックで区切られた状態で出力されます。

---

## アプリの終了方法
このアプリが動いているコマンドプロンプト（黒い画面）を閉じてください。

---

## アプリの削除（アンインストール）方法

- アプリ本体フォルダ（例：`NEZ-DeepSeek-OCR-GUI`）を削除  
- 同フォルダ内の `.venv` / `_tmp_inputs` / `_ocr_out` / `_ocr_out_jobs` も削除  
- DeepSeek-OCRフォルダが別にあるならそれも削除

※なお、PythonとGitはこの方法ではアンインストールされません。これらを消したいときは、別途アンインストールする必要があります。

---

## よくあるトラブルと対処（中級者以上向け）

- **「Model load failed」や「No module named xxx」**  
  → `setup.bat` を実行して依存を入れてください。社内プロキシ環境では `pip` のプロキシ設定が必要なことがあります。

- **Hugging Face の重みが数KBで壊れている**  
  → `git lfs install` を忘れている可能性。`DeepSeek-OCR` フォルダを削除 → 再クローン。

- **Torch/CUDA の版が合わずインストールできない**  
  → `requirements.txt` 冒頭の `--index-url` を **環境のCUDA版**に合わせて変更（例：`cu121`）。その後、`setup.bat`。

---

## 仕様のポイント

- **完全ローカル**：画像・テキストは**外部に送信されません**。  
- **進捗**：単枚は「前処理→エンコード→デコード→整形」、フォルダは**枚数＋枚内進捗**で実値%。  
- **推奨GPU**：VRAM **12GB以上**（4070 Ti SUPERで実用確認）。  
- **Python**：3.10で検証（3.11+は未検証）。  
- **Windows専用**（11を検証／10は未検証）。

---

## アップデート

- このアプリの更新を取り込む（gitクローンした場合）
```bat
cd /d S:\OriginalApps\NEZ-DeepSeek-OCR-GUI
git pull
setup.bat   rem 依存が増えた場合のみ。基本は不要
run.bat
```

- DeepSeek-OCR本体を更新
```bat
cd /d S:\OriginalApps\NEZ-DeepSeek-OCR-GUI\DeepSeek-OCR
git pull
```

---

## ライセンス・クレジット

- このGUI：MIT（予定／リポジトリに記載）  
- **DeepSeek-OCR**：MIT（DeepSeek社の配布条件に従う）  
- 画像に含まれる個人情報の取り扱いには十分ご注意ください。

---

## 作者

- Rootport-AI（GitHub）  
  https://github.com/Rootport-AI

**気に入ったらStar✨お願いします！** バグ報告・要望も大歓迎です（Issueにて）。
