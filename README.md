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

Screenshots

 Basic Mode
	
<img width="444" height="749" alt="image" src="https://github.com/user-attachments/assets/92918059-b114-4e51-8bcc-d27c023c5657" />

	
Scientific Mode
	
<img width="436" height="759" alt="image" src="https://github.com/user-attachments/assets/db3f6d9f-993d-444d-94ab-4c0cd5569ca8" />

	
Programmer Mode
	
<img width="452" height="760" alt="image" src="https://github.com/user-attachments/assets/0ec57802-e40a-42ea-90ae-e962ce1c9b97" />

	
🎨 Theme Showcase
Light
<img width="481" height="728" alt="image" src="https://github.com/user-attachments/assets/25529334-366e-4596-9510-7a98a6dfbc97" />

Dark
<img width="424" height="750" alt="image" src="https://github.com/user-attachments/assets/46d283ba-b82c-4161-97b2-f4174a37c8e7" />

	
📜 History & Settings
<img width="433" height="746" alt="image" src="https://github.com/user-attachments/assets/c2fd0310-c64b-47c1-81d0-c37d84c8b6a8" />

<img width="460" height="745" alt="image" src="https://github.com/user-attachments/assets/1b70f7fd-f9df-40be-a249-7dc7b9e3ddf2" />
<img width="425" height="745" alt="image" src="https://github.com/user-attachments/assets/18b7b292-8884-44dc-ade1-af694c566ae3" />

	
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
