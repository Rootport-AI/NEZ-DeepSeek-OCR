@echo off
setlocal

REM === Path準備 ==============================================================
set "ROOT=%~dp0"
pushd "%ROOT%"

REM === venv 有効化 ===========================================================
if not exist ".venv\Scripts\activate.bat" (
  echo [WARN] .venv が見つかりません。先に setup.bat を実行してください。
  exit /b 1
)
call ".venv\Scripts\activate.bat"

REM === （任意）環境変数：モデルIDやデフォルト推論パラメータを上書き =========
set DEEPSEEK_OCR_MODEL=.\DeepSeek-OCR
REM set BASE_SIZE=1024
REM set IMAGE_SIZE=640

REM === アプリ起動 ============================================================
echo [RUN] Starting server at http://127.0.0.1:8000/
python app.py
if errorlevel 1 (
  echo [ERROR] App failed to start. Check console logs.
  exit /b 1
)

popd
endlocal
