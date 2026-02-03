# Wahyu Dwi - MD Test Project

A Flutter application demonstrating authentication, user management, and email verification features using Firebase.

## 📋 Features

### Splash Screen

- ✅ Initial loading screen with app branding and gradient design
- ✅ Automatic authentication state checking

### Authentication

- ✅ **Login Screen**: Users can sign in using email and password
- ✅ **Registration Screen**: New users can sign up with email and password
- ✅ **Forgot Password Screen**: Users can request a password reset email

### Home Page

- ✅ Display user's name and email verification status
- ✅ Display a list of users retrieved from Firestore
- ✅ Show user's name, email, and verification status for each user in the list
- ✅ Filter users by email verification status (All/Verified/Unverified)
- ✅ Search users by name or email

### Email Verification

- ✅ Users receive a verification email upon registration
- ✅ UI updates based on email verification status changes
- ✅ Pull-to-refresh to sync verification status

### Password Reset

- ✅ Users can reset their password via email
- ✅ Dedicated UI screen for password reset

### Unit Tests

- ✅ Repository tests for authentication
- ✅ Repository tests for Firestore data retrieval
- ✅ Controller tests for home screen logic
- ✅ Mock dependencies for isolated testing

---

## 🏗️ Architecture

This project follows **Clean Architecture** principles with three main layers:

```
lib/
├── core/               # Core utilities, routing, and providers
├── data/               # Data layer (models, repositories, remote sources)
├── domain/             # Domain layer (entities, repository interfaces, use cases)
└── presentation/       # Presentation layer (UI, controllers, widgets)
```

### Architecture Layers

- **Domain Layer**: Business logic and entities (framework-independent)
- **Data Layer**: Implementation of repositories, API calls, and data models
- **Presentation Layer**: UI components and state management

---

## 📚 Third-Party Libraries

### Core Dependencies

#### **1. Firebase Suite**

```yaml
firebase_core: ^4.4.0
firebase_auth: ^6.1.4
cloud_firestore: ^6.1.2
```

**Reason**:

- Authentication management (sign in, sign up, password reset, email verification)
- Cloud Firestore for real-time user data storage and retrieval
- Industry-standard backend solution with scalability

#### **2. Flutter Riverpod**

```yaml
flutter_riverpod: ^3.1.0
riverpod_annotation: ^4.0.0
riverpod_generator: ^4.0.0+1
```

**Reason**:

- Modern, compile-safe state management
- Dependency injection out of the box
- Code generation for type-safe providers
- Better testability with provider overrides
- Eliminates boilerplate code

#### **3. GoRouter**

```yaml
go_router: ^17.0.1
```

**Reason**:

- Declarative routing for Flutter
- Deep linking support
- Type-safe navigation
- Automatic route-based authentication redirects
- Better than Navigator 1.0 for complex navigation flows

#### **4. Dartz**

```yaml
dartz: ^0.10.1
```

**Reason**:

- Functional programming utilities
- `Either<Left, Right>` type for error handling
- Makes error handling explicit and type-safe
- Avoids try-catch hell in business logic

#### **5. Freezed**

```yaml
freezed: ^3.2.3
freezed_annotation: ^3.1.0
```

**Reason**:

- Immutable data classes
- Union types and pattern matching
- Reduces boilerplate for models
- Built-in `copyWith`, equality, and `toString` methods
- Better null-safety handling

#### **6. JSON Serialization**

```yaml
json_annotation: ^4.9.0
json_serializable: ^6.7.1
```

**Reason**:

- Type-safe JSON serialization/deserialization
- Code generation for `fromJson` and `toJson`
- Reduces manual parsing errors

### Dev Dependencies

#### **7. Mockito**

```yaml
mockito: ^5.6.3
```

**Reason**:

- Mock dependencies in unit tests
- Verify method calls and behaviors
- Isolate units of code for testing

#### **8. Build Runner**

```yaml
build_runner: ^2.4.13
```

**Reason**:

- Code generation for Riverpod, Freezed, JSON serialization
- Automates repetitive code creation

#### **9. Custom Lint & Riverpod Lint**

```yaml
custom_lint: ^0.8.1
riverpod_lint: ^3.1.0
```

**Reason**:

- Additional lint rules for Riverpod best practices
- Catches common mistakes at compile time

---

## 🚀 Installation & Setup

### Prerequisites

- Flutter SDK (≥ 3.10.4)
- Dart SDK (≥ 3.10.4)
- Android Studio / VS Code
- Git

### Step 1: Clone the Repository

```bash
git clone <repository-url>
cd wahyu_dwi_mdtest
```

### Step 2: Install Dependencies

```bash
flutter pub get
```

### Step 3: Firebase Setup

#### Option A: Use Existing Configuration (Already Included)

The project already includes Firebase configuration files:

- `android/app/google-services.json`
- `lib/firebase_options.dart`

#### Option B: Set Up Your Own Firebase Project

1. Create a new project at [Firebase Console](https://console.firebase.google.com)
2. Enable **Authentication** (Email/Password method)
3. Create a **Cloud Firestore** database
4. Add Android/iOS/Web apps to your Firebase project
5. Download configuration files:
   - Android: `google-services.json` → `android/app/`
   - iOS: `GoogleService-Info.plist` → `ios/Runner/`
6. Run FlutterFire CLI:

```bash
dart pub global activate flutterfire_cli
flutterfire configure
```

### Step 4: Generate Code

```bash
dart run build_runner build --delete-conflicting-outputs
```

### Step 5: Run the App

```bash
flutter run
```

---

## 🧪 Running Tests

### Run All Tests

```bash
flutter test
```

### Run Specific Test File

```bash
flutter test test/data/repositories/auth/auth_repository_test.dart
flutter test test/data/repositories/home/home_repository_test.dart
flutter test test/presentation/home_controller_test.dart
```

### Generate Test Coverage

```bash
flutter test --coverage
```

---

## 🗂️ Project Structure

```
lib/
├── core/
│   ├── constants/          # Route constants
│   ├── providers/          # Firebase providers
│   └── routing/            # GoRouter configuration
├── data/
│   ├── mapper/             # Entity to Model mappers
│   ├── models/             # Data models (Freezed)
│   ├── repositories/       # Repository implementations
│   └── sources/            # Remote data sources
├── domain/
│   ├── entities/           # Business entities
│   ├── repositories/       # Repository interfaces
│   └── usecase/            # Use cases (business logic)
└── presentation/
    ├── splash/             # Splash screen
    ├── auth/               # Authentication screens
    │   ├── sign_in/
    │   ├── sign_up/
    │   ├── forgot_password/
    │   └── provider/
    └── home/               # Home screen
        ├── provider/
        └── widget/

test/
├── data/
│   └── repositories/       # Repository tests
└── presentation/           # Controller tests
```

---

## App Flow

### 1. Authentication Flow

```
Launch → Splash Screen → Check Auth State
  ├─ Not Logged In → Sign In Screen
  │   ├─ Sign Up
  │   └─ Forgot Password
  └─ Logged In → Home Screen
```

### 2. Home Screen Features

- Display current user info with verification status
- Pull to refresh to sync verification status
- Search users by name or email
- Filter users by verification status
- View all users from Firestore (except self)

---

## 🎨 Key Features

### State Management

- **Riverpod** for dependency injection and state management
- Auto-generated providers for type safety
- AsyncValue for loading/error/data states

### Error Handling

- Graceful error messages in Indonesian
- Firebase error code mapping to user-friendly messages
- Visual feedback with SnackBars

### Code Generation

- Riverpod providers auto-generated
- Freezed models with immutability
- JSON serialization auto-generated

### Testing

- Unit tests for repositories
- Unit tests for controllers
- Mocked dependencies with Mockito
- Stream and Future testing

---

## 🌟 Additional Enhancements

Beyond the basic requirements, this project includes:

1. **Pull-to-Refresh**: Sync email verification status manually
2. **Clean Architecture**: Separation of concerns with 3-layer architecture
3. **Functional Programming**: Error handling with Either type
4. **Code Generation**: Reduced boilerplate with build_runner
5. **Real-time Updates**: Firestore streams for live data
6. **Modern UI**: Material Design 3 components
7. **Type Safety**: Compile-time safety with Riverpod and Freezed
8. **Comprehensive Testing**: Repository and controller tests

---

## 📝 Environment

- **Flutter Version**: 3.10.4+
- **Dart Version**: 3.10.4+
- **Minimum Android SDK**: 21
- **Minimum iOS Version**: 12.0

---

## 👨‍💻 Development

### Code Generation Commands

```bash
# Watch for changes and rebuild
dart run build_runner watch

# One-time build
dart run build_runner build --delete-conflicting-outputs
```

### Linting

```bash
flutter analyze
```

### Format Code

```bash
dart format .
```

---

## 🐛 Troubleshooting

### Issue: Build runner fails

**Solution**: Delete generated files and rebuild

```bash
flutter clean
flutter pub get
dart run build_runner build --delete-conflicting-outputs
```

### Issue: Firebase not initialized

**Solution**: Ensure Firebase is initialized in `main.dart`

```dart
await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
```

### Issue: Tests fail with "Bad state: disposed"

**Solution**: Properly dispose ProviderContainer in tests

---

## 📄 License

This project is created for testing purposes.

---

## 📧 Contact

For questions or issues, please contact the developer.
