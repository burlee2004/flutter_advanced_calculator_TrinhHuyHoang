Advanced Calculator – Flutter App

Ứng dụng máy tính nâng cao được xây dựng bằng Flutter, hỗ trợ 3 chế độ: Basic, Scientific, và Programmer.
Giao diện hiện đại, hỗ trợ Light/Dark theme, history, animations, và nhiều tính năng nâng cao.

✨ Tính năng chính
🔢 Basic Mode

Phép tính cơ bản: + - × ÷

Phần trăm %

Đổi dấu ±

Xoá nhanh: C, CE

🧪 Scientific Mode

Trigonometric: sin, cos, tan

Logarithmic: ln, log

Lũy thừa – căn: x², x^y, √

Hằng số: π

Memory: M+, M-, MR, MC

DEG / RAD

💻 Programmer Mode

Hệ số: BIN / OCT / DEC / HEX

Bitwise: AND, OR, XOR, NOT

Shift: <<, >>

Hỗ trợ nhập Hex: A–F

🎨 Giao diện & Theme

Light Theme – sáng, dễ nhìn

Dark Theme – tối ưu cho ban đêm

Hiệu ứng mượt:

Button press

Mode switching

Error shake

💾 History

Lưu 25 / 50 / 100 phép tính

Lưu bằng SharedPreferences

Nhấn để dùng lại kết quả

⚙️ Settings

Theme: Light / Dark / System

Decimal precision: 2–10

DEG / RAD

Haptic Feedback

Sound Effects

History size

📸 Screenshots

(Đặt ảnh vào các vị trí dưới đây)

📱 Basic Mode
	

	
🧪 Scientific Mode
	

	
💻 Programmer Mode
	

	
🎨 Theme Showcase
Light	Dark

	
📜 History & Settings
	

	
🏗️ Cấu trúc Project
lib/
├── main.dart
├── models/
├── providers/
├── screens/
├── widgets/
├── utils/
└── services/

🧪 Bộ Test Mẫu
Basic
5 + 3 = 8
(5 + 3) × 2 = 16
10 ÷ 2 = 5

Scientific
sin(45°) ≈ 0.707
log(100) = 2
√9 = 3

Programmer
FF AND F0 = 240
8 << 2 = 32
NOT 5 = -6

🚀 Cài đặt
git clone <repo-url>
cd advanced_calculator
flutter pub get
flutter run


Build APK:

flutter build apk --release

👨‍💻 Developer

Họ Tên: Trinh Huy Hoang
mssv: 2224802010159
Email: Hoanglubo2004@gmail.com
