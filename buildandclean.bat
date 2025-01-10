@echo off
REM Điều này để tắt hiển thị các lệnh trên màn hình

REM Chuyển đến thư mục chứa file bat (cũng là thư mục dự án)
cd C:\Users\Loc\Documents\khoaluan\t_store\cacchucnangcuaflutter\flutter_run.bat
REM Lệnh Flutter để dọn dẹp, tải lại dependencies và chạy ứng dụng
flutter clean
flutter pub get
flutter run


pause