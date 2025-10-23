@echo off
setlocal

REM === Path準備（このbatのあるフォルダを起点にする） ======================
set "ROOT=%~dp0"
pushd "%ROOT%"

REM === Python 3.10想定。仮想環境 .venv を作成（存在しなければ） ==========
if not exist ".venv" (
  echo [SETUP] Creating virtual environment at .venv ...
  python -m venv .venv
  if errorlevel 1 (
    echo [ERROR] Failed to create venv. Make sure Python 3.10 is installed and on PATH.
    exit /b 1
  )
)

REM === venv 有効化 ===========================================================
call ".venv\Scripts\activate.bat"
if errorlevel 1 (
  echo [ERROR] Failed to activate venv.
  exit /b 1
)

REM === pipアップグレード =====================================================
python -m pip install --upgrade pip
if errorlevel 1 (
  echo [ERROR] Failed to upgrade pip.
  exit /b 1
)

REM === 依存インストール（requirements.txtを参照） ============================
echo [SETUP] Installing Python dependencies from requirements.txt ...
pip install -r requirements.txt
if errorlevel 1 (
  echo [ERROR] pip install failed. Check CUDA/PyTorch wheel compatibility lines in requirements.txt
  exit /b 1
)

REM === static フォルダの作成＆リソース移動 ===================================
set "STATIC_DIR=static"
if not exist "%STATIC_DIR%" (
  echo [SETUP] Creating folder: %STATIC_DIR%
  mkdir "%STATIC_DIR%"
  if errorlevel 1 (
    echo [ERROR] Failed to create "%STATIC_DIR%".
    exit /b 1
  )
)

REM -- HTML/JS/CSS をプロジェクト直下から static/ へ移動（同名は上書きしない）
set "MOVED_ANY="
for %%F in (*.html) do (
  if exist "%%F" (
    if not exist "%STATIC_DIR%\%%~nxF" (
      echo [SETUP] Moving "%%F" -> "%STATIC_DIR%\"
      move /Y "%%F" "%STATIC_DIR%\" >nul
      set "MOVED_ANY=1"
    ) else (
      echo [SETUP] Skip "%%F" (already exists in "%STATIC_DIR%")
    )
  )
)
for %%F in (*.js) do (
  if exist "%%F" (
    if not exist "%STATIC_DIR%\%%~nxF" (
      echo [SETUP] Moving "%%F" -> "%STATIC_DIR%\"
      move /Y "%%F" "%STATIC_DIR%\" >nul
      set "MOVED_ANY=1"
    ) else (
      echo [SETUP] Skip "%%F" (already exists in "%STATIC_DIR%")
    )
  )
)
for %%F in (*.css) do (
  if exist "%%F" (
    if not exist "%STATIC_DIR%\%%~nxF" (
      echo [SETUP] Moving "%%F" -> "%STATIC_DIR%\"
      move /Y "%%F" "%STATIC_DIR%\" >nul
      set "MOVED_ANY=1"
    ) else (
      echo [SETUP] Skip "%%F" (already exists in "%STATIC_DIR%")
    )
  )
)

if not defined MOVED_ANY (
  echo [SETUP] No *.html/*.js/*.css found in project root or all already in "%STATIC_DIR%".
)

echo.
echo [SETUP] Done.
echo.
echo Note:
echo    DeepSeek-OCR itself is not obtained through this script.
echo    Please download it manually beforehand.
echo.
echo    If your CUDA version is not 11.8, modify the --index-url at the
echo    beginning of requirements.txt to match your CUDA version (e.g., cu121).
echo.

popd
pause
