@echo off
cd /d "%~dp0"
echo 🚀 オリパシミュレーターを起動しています...
echo 📡 ローカルサーバー: http://localhost:8000
echo.
echo ✅ ブラウザを自動で開きます...
echo ⏹  終了するには Ctrl+C を押してください
echo.

REM ブラウザを開く
timeout /t 1 /nobreak >nul
start http://localhost:8000

REM サーバーを起動
python -m http.server 8000
pause
