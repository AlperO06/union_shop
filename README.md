# Union Shop 🛍️

A modern e-commerce Flutter application for the **University of Portsmouth Student Union Shop**, featuring official merchandise, campus essentials, local gifts, and a personalized print service.

[![Flutter](https://img.shields.io/badge/Flutter-3.0+-02569B?logo=flutter)](https://flutter.dev)
[![Firebase](https://img.shields.io/badge/Firebase-Enabled-FFCA28?logo=firebase)](https://firebase.google.com)
[![Tests](https://img.shields.io/badge/Tests-144%20Passing-success)](test/)

## 📋 Table of Contents

- [Features](#-features)
- [Screenshots](#-screenshots)
- [Installation & Setup](#-installation--setup)
- [Usage](#-usage)
- [Running Tests](#-running-tests)
- [Project Structure](#-project-structure)
- [Technologies Used](#-technologies-used)
- [Known Issues](#-known-issues)
- [Future Improvements](#-future-improvements)
- [Contributing](#-contributing)
- [Contact](#-contact)

## ✨ Features

### 🛒 E-Commerce Core
- **Product Catalog**: Browse official university merchandise, clothing, accessories, and Portsmouth souvenirs
- **Product Details**: View multiple product images, select sizes and colors, and read detailed descriptions
- **Shopping Cart**: Add/remove items, adjust quantities, and persist cart across sessions
- **Sale Items**: Dedicated sale page with discounted products
- **Collections**: Organized product categories (clothing, accessories, etc.)
- **Search**: Find products quickly with search functionality

### 🎨 Print Shack Service
- **Custom Personalization**: Create personalized hoodies with custom text
- **Character Limits**: Configurable character limits per line
- **Dynamic Pricing**: Price calculation based on personalization lines
- **Live Preview**: See your customization before adding to cart

### 👤 User Authentication
- **Email/Password Authentication**: Traditional sign-up and login
- **Google Sign-In**: Quick authentication with Google accounts
- **Password Reset**: Email-based password recovery
- **Profile Management**: Update display name and view account details
- **Order History**: Track past purchases
- **Account Dashboard**: Centralized user information

### 🎯 User Experience
- **Responsive Design**: Optimized for mobile, tablet, and desktop
- **Hero Slider**: Engaging homepage carousel with promotional content
- **Persistent Cart**: Cart data saved locally using SharedPreferences
- **Clean UI**: Modern, intuitive interface with Material Design
- **Navigation**: Easy-to-use navigation with header and footer
- **About Pages**: Information about the shop and Print Shack service

## 📱 Screenshots

<img width="2879" height="1799" alt="image" src="https://github.com/user-attachments/assets/b9d9138c-b7ad-4cfd-97f5-6602092a8136" />


```
[Homepage]  [Product Page]  [Cart]  [Login]
```

## 🚀 Installation & Setup

### Prerequisites

Before you begin, ensure you have the following installed:

- **Flutter SDK** (3.0 or higher): [Installation Guide](https://flutter.dev/docs/get-started/install)
- **Dart SDK** (2.17.0 or higher) - Included with Flutter
- **Git**: For cloning the repository
- **IDE**: VS Code or Android Studio (recommended)
- **Platform-specific tools**:
  - For Android: Android Studio & Android SDK
  - For iOS: Xcode (macOS only)
  - For Web: Chrome browser
  - For Desktop: Visual Studio (Windows), Xcode (macOS), or GTK (Linux)

### Step-by-Step Installation

1. **Clone the repository**
   ```powershell
   git clone https://github.com/AlperO06/union_shop.git
   cd union_shop
   ```

2. **Install Flutter dependencies**
   ```powershell
   flutter pub get
   ```

3. **Configure Firebase (Required for Authentication)**
   
   The app uses Firebase for authentication. Firebase is already initialized in the code, but you can customize it:
   
   - Review `AUTHENTICATION_SETUP.md` for detailed Firebase configuration
   - The app includes default Firebase configuration for web platform
   - For production, update Firebase credentials in `lib/main.dart`

4. **Verify installation**
   ```powershell
   flutter doctor
   ```
   Fix any issues reported by Flutter Doctor.

5. **Run the app**
   ```powershell
   # For development on default device
   flutter run
   
   # For web
   flutter run -d chrome
   
   # For Android
   flutter run -d android
   
   # For iOS (macOS only)
   flutter run -d ios
   
   # For Windows desktop
   flutter run -d windows
   ```

## 📖 Usage

### Main Features

#### 1. **Browse Products**
- Open the app to see the homepage with hero slider
- Scroll down to view featured products
- Click "SHOP NOW" or navigate to Collections to browse all products
- Filter by category (Clothing, Accessories, etc.)

#### 2. **View Product Details**
- Click on any product card to see full details
- Browse through multiple product images
- Select size and color options
- Adjust quantity
- Add to cart

#### 3. **Shopping Cart**
- Click the cart icon in the header to view your cart
- Update quantities or remove items
- View subtotal, delivery fee, and total
- Cart persists across sessions using local storage

#### 4. **User Authentication**
- Click "Login" in the header to access authentication
- Sign up with email/password or use Google Sign-In
- Access your profile and order history
- Update your profile information
- Reset password via email if forgotten

#### 5. **Print Shack (Custom Products)**
- Navigate to the Print Shack section
- Select a personalizable product (e.g., hoodie)
- Add custom text (up to character limit)
- See real-time price updates
- Add personalized product to cart

#### 6. **Search & Sale**
- Use the search bar to find specific products
- Visit the Sale page for discounted items
- Browse collections by category

### Configuration Options

#### Cart Persistence
Cart data is automatically saved to local storage. To clear cart:
- Use the "Clear Cart" button in cart page, or
- Clear app data in device settings

#### Firebase Configuration
To use your own Firebase project:
1. Create a Firebase project at [Firebase Console](https://console.firebase.google.com)
2. Enable Authentication with Email/Password and Google providers
3. Update Firebase configuration in `lib/main.dart`
4. Follow instructions in `AUTHENTICATION_SETUP.md`

## 🧪 Running Tests

The project includes comprehensive test coverage with **122 passing tests**.

### Run All Tests
```powershell
flutter test
```

### Run Specific Test File
```powershell
flutter test test/product_test.dart
```

### Run Tests with Coverage
```powershell
flutter test --coverage
```

### Test Categories
- **Unit Tests**: Cart logic, product models, data services
- **Widget Tests**: UI components, screens, navigation
- **Integration Tests**: Authentication flow, cart operations

Test files are located in the `test/` directory, mirroring the `lib/` structure.

## 📁 Project Structure

```
union_shop/
├── lib/
│   ├── main.dart                    # App entry point
│   ├── about_page.dart              # About Us page
│   ├── bottom_union_footer.dart     # Reusable footer widget
│   ├── product_page.dart            # Product details page
│   │
│   ├── data/                        # Data layer
│   │   ├── cart.dart                # Cart state management
│   │   ├── products.dart            # Product catalog data
│   │   └── print_shack.dart         # Print service products
│   │
│   ├── models/                      # Data models
│   │   ├── product.dart             # Product model
│   │   └── user.dart                # User model
│   │
│   ├── screens/                     # App screens
│   │   ├── home_screen.dart         # Homepage
│   │   ├── about_print.dart         # About Print Shack
│   │   ├── account_dashboard.dart   # User account
│   │   ├── cart.dart                # Shopping cart
│   │   ├── collections_page.dart    # Product collections
│   │   ├── collections_landing_page.dart
│   │   ├── login_page.dart          # Authentication
│   │   ├── signup_page.dart         # User registration
│   │   ├── order_history.dart       # Past orders
│   │   ├── print_shack_product_page.dart
│   │   ├── profile_settings.dart    # User profile
│   │   ├── sale_page.dart           # Sale items
│   │   └── search_page.dart         # Product search
│   │
│   ├── services/                    # Business logic
│   │   └── auth_service.dart        # Firebase authentication
│   │
│   └── widgets/                     # Reusable components
│       ├── hero_slider.dart         # Carousel slider
│       ├── product_card.dart        # Product card widget
│       ├── union_header.dart        # App header/navbar
│       └── union_page_scaffold.dart # Page template
│
├── test/                            # Test files (122 tests)
│   ├── *_test.dart                  # Unit & widget tests
│   └── ...
│
├── android/                         # Android platform
├── ios/                             # iOS platform
├── web/                             # Web platform
├── windows/                         # Windows platform
├── linux/                           # Linux platform
├── macos/                           # macOS platform
│
├── pubspec.yaml                     # Dependencies
├── analysis_options.yaml            # Linting rules
├── AUTHENTICATION_SETUP.md          # Firebase setup guide
└── README.md                        # This file
```

### Key Files

- **`lib/main.dart`**: App initialization, Firebase setup, routing
- **`lib/data/cart.dart`**: Shopping cart logic with persistence
- **`lib/services/auth_service.dart`**: Authentication service with Firebase
- **`lib/widgets/union_page_scaffold.dart`**: Common page layout template
- **`pubspec.yaml`**: Package dependencies and app metadata

## 🛠 Technologies Used

### Frontend Framework
- **Flutter** (3.0+) - Cross-platform UI toolkit
- **Dart** (2.17.0+) - Programming language

### State Management
- **Provider** (^6.1.1) - State management solution
- **ChangeNotifier** - Built-in state notification

### Backend & Services
- **Firebase Core** (^3.6.0) - Firebase SDK
- **Firebase Auth** (^5.3.1) - User authentication
- **Google Sign-In** (^6.2.1) - Google authentication

### Data Persistence
- **SharedPreferences** (^2.5.3) - Local storage for cart

### UI & Navigation
- **Material Design** - Design system
- **Cupertino Icons** (^1.0.0) - iOS-style icons
- **URL Launcher** (^6.1.7) - External link handling

### Development Tools
- **Flutter Test** - Testing framework
- **Flutter Lints** (^2.0.0) - Code quality rules
- **Dart DevTools** - Debugging and profiling

### Architecture Patterns
- **MVC Pattern** - Model-View-Controller separation
- **Provider Pattern** - Dependency injection and state management
- **Repository Pattern** - Data layer abstraction

## ⚠️ Known Issues

### Current Limitations

1. **Google Sign-In Configuration**
   - People API needs to be enabled in Google Cloud Console for full functionality
   - Workaround implemented with minimal scopes
   - See `lib/services/auth_service.dart` for details

2. **Cart Persistence**
   - Cart data stored locally (not synced across devices)
   - Logged-in users should have server-side cart sync (future enhancement)

3. **Payment Integration**
   - No payment gateway integrated yet
   - Checkout flow is placeholder

4. **Responsive Design**
   - Some layout overflow issues on very small screens (<350px width)
   - Fixed header may overlap content on some tablet sizes

5. **Image Loading**
   - External image URLs may fail if source is unavailable
   - No image caching implemented yet

### Browser Compatibility (Web)
- Optimized for Chrome/Edge
- Some features may have limited support in Safari/Firefox

## 🚧 Future Improvements

### Planned Features
- [ ] Complete checkout and payment integration (Stripe/PayPal)
- [ ] User reviews and ratings for products
- [ ] Wishlist functionality
- [ ] Order tracking and notifications
- [ ] Admin panel for product management
- [ ] Multi-language support (i18n)
- [ ] Dark mode theme
- [ ] Push notifications
- [ ] Social media sharing
- [ ] Advanced search with filters (price range, ratings, etc.)
- [ ] Product recommendations based on browsing history
- [ ] Loyalty points system
- [ ] Gift cards and promo codes
- [ ] Inventory management
- [ ] Server-side cart synchronization
- [ ] Image optimization and caching
- [ ] Progressive Web App (PWA) support
- [ ] Analytics integration (Google Analytics/Firebase Analytics)

### Technical Improvements
- [ ] Implement proper error boundaries
- [ ] Add loading states and skeleton screens
- [ ] Improve test coverage to 90%+
- [ ] Add integration tests
- [ ] Implement CI/CD pipeline
- [ ] Performance optimization (lazy loading, code splitting)
- [ ] Accessibility improvements (screen reader support)
- [ ] SEO optimization for web version

## 🤝 Contributing

Contributions are welcome! This is a university project, but improvements and bug fixes are appreciated.

### How to Contribute

1. **Fork the repository**
2. **Create a feature branch**
   ```powershell
   git checkout -b feature/your-feature-name
   ```
3. **Make your changes**
   - Follow the existing code style
   - Add tests for new features
   - Update documentation as needed
4. **Run tests**
   ```powershell
   flutter test
   ```
5. **Commit your changes**
   ```powershell
   git commit -m "Add: your feature description"
   ```
6. **Push to your fork**
   ```powershell
   git push origin feature/your-feature-name
   ```
7. **Create a Pull Request**

### Code Style Guidelines
- Follow [Effective Dart](https://dart.dev/guides/language/effective-dart) guidelines
- Use meaningful variable and function names
- Add comments for complex logic
- Keep functions small and focused
- Write tests for new features

## 📄 License

This project is a university coursework project for the **University of Portsmouth**. 

For educational purposes only. Not for commercial use.

## 👤 Contact

**Alper Ozturk**
- GitHub: [@AlperO06](https://github.com/AlperO06)
- Project Repository: [union_shop](https://github.com/AlperO06/union_shop)
- University: University of Portsmouth

---

## 🙏 Acknowledgments

- **University of Portsmouth Student Union** - Project inspiration
- **Flutter Team** - Amazing cross-platform framework
- **Firebase** - Backend services
- **Material Design** - UI/UX guidelines

---

### 📝 Notes

- This is a coursework project demonstrating Flutter development skills
- The app showcases e-commerce functionality, authentication, and state management
- All 122 tests passing ensure code quality and reliability
- Responsive design works across mobile, tablet, desktop, and web platforms

**Built with ❤️ using Flutter
flutter build windows --release
```

## Tests

Run unit and widget tests with:

```powershell
flutter test
```

There are tests in the `test/` directory (for example `home_test.dart`, `product_test.dart`).

## Project structure (high level)

- `lib/` - application source code (UI and logic)
- `test/` - unit and widget tests
- `android/`, `ios/`, `linux/`, `macos/`, `web/`, `windows/` - platform folders for builds

## Notes

- The package is configured in `pubspec.yaml` (SDK constraints and basic dependencies). Update dependencies there and run `flutter pub get`.
- If you plan to run on iOS or macOS, use a macOS host with Xcode installed.

## License

Add a license file if you intend to publish this project.
