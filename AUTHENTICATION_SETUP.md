# Union Shop - Authentication Setup Guide

## Overview
The Union Shop now includes a complete user authentication system with the following features:

### Authentication Methods
- ✅ Email/Password registration and login
- ✅ Google Sign-In
- ✅ Password reset functionality

### Account Management Features
- ✅ User profile dashboard
- ✅ Profile settings (edit name, change password)
- ✅ Order history viewing
- ✅ Account deletion
- ✅ Persistent authentication state

## Firebase Setup (Required)

### 1. Create a Firebase Project
1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Click "Add project" and follow the setup wizard
3. Name your project (e.g., "union-shop")

### 2. Enable Authentication Methods
1. In Firebase Console, go to **Authentication** → **Sign-in method**
2. Enable the following providers:
   - **Email/Password**: Click "Enable" and save
   - **Google**: Click "Enable", add a support email, and save

### 3. Register Your App

#### For Web (Required)
1. In Firebase Console, go to **Project Settings** (gear icon)
2. Scroll down to "Your apps" and click the **Web** icon (`</>`)
3. Register your app with a nickname (e.g., "Union Shop Web")
4. Copy the Firebase configuration object

#### For Android (Optional)
1. Click the **Android** icon in "Your apps"
2. Register with package name: `com.example.union_shop`
3. Download `google-services.json` and place it in `android/app/`

#### For iOS (Optional)
1. Click the **iOS** icon in "Your apps"
2. Register with bundle ID: `com.example.unionShop`
3. Download `GoogleService-Info.plist` and add it to `ios/Runner/`

### 4. Update Firebase Configuration
The Firebase configuration is already set in `lib/main.dart` with your project details.

## Google Sign-In Setup

### IMPORTANT: Get Your Web Client ID

1. In [Google Cloud Console](https://console.cloud.google.com/), select your Firebase project
2. Navigate to **APIs & Services** → **Credentials**
3. Find your **Web client** OAuth 2.0 Client ID (created automatically by Firebase)
4. Copy the **Client ID** (it looks like: `123456789-abc123xyz.apps.googleusercontent.com`)
5. Open `web/index.html` and replace the placeholder:
   ```html
   <meta name="google-signin-client_id" content="YOUR_WEB_CLIENT_ID_HERE.apps.googleusercontent.com">
   ```

### Web Configuration
1. In the same Credentials page, edit your Web client
2. Add authorized JavaScript origins:
   - `http://localhost:5000` (for local testing)
   - `http://localhost` (for local testing)
   - Your production domain (when deployed)
3. Add authorized redirect URIs:
   - `http://localhost:5000/__/auth/handler`
   - `http://localhost/__/auth/handler`
   - Your production redirect URI

### Android Configuration
1. Get your SHA-1 fingerprint:
   ```bash
   keytool -list -v -keystore ~/.android/debug.keystore -alias androiddebugkey -storepass android -keypass android
   ```
2. In Firebase Console, go to **Project Settings** → **Your apps** → Android app
3. Add the SHA-1 fingerprint

### iOS Configuration
1. Download `GoogleService-Info.plist` from Firebase
2. Add it to your Xcode project under `ios/Runner/`
3. In `ios/Runner/Info.plist`, add your reversed client ID

## Facebook Sign-In Setup

### 1. Create a Facebook App
1. Go to [Facebook Developers](https://developers.facebook.com/)
2. Create a new app (select "Consumer" type)
3. Add **Facebook Login** product to your app

### 2. Configure Facebook Login
1. In your Facebook app dashboard, go to **Facebook Login** → **Settings**
2. Add these URLs to "Valid OAuth Redirect URIs":
   - `https://YOUR_PROJECT_ID.firebaseapp.com/__/auth/handler`
   - `http://localhost:5000/__/auth/handler` (for testing)

### 3. Get App Credentials
1. Go to **Settings** → **Basic**
2. Copy your **App ID** and **App Secret**
3. In Firebase Console, go to **Authentication** → **Sign-in method** → **Facebook**
4. Paste the App ID and App Secret, then save

### 4. Update Platform Settings

#### Web
Add this to your `web/index.html` before `</body>`:
```html
<script>
  window.fbAsyncInit = function() {
    FB.init({
      appId      : 'YOUR_FACEBOOK_APP_ID',
      cookie     : true,
      xfbml      : true,
      version    : 'v18.0'
    });
  };
</script>
<script async defer crossorigin="anonymous" 
  src="https://connect.facebook.net/en_US/sdk.js"></script>
```

#### Android
Add to `android/app/src/main/res/values/strings.xml`:
```xml
<string name="facebook_app_id">YOUR_FACEBOOK_APP_ID</string>
<string name="fb_login_protocol_scheme">fbYOUR_FACEBOOK_APP_ID</string>
```

Add to `android/app/src/main/AndroidManifest.xml` inside `<application>`:
```xml
<meta-data android:name="com.facebook.sdk.ApplicationId" 
    android:value="@string/facebook_app_id"/>
```

#### iOS
Add to `ios/Runner/Info.plist`:
```xml
<key>CFBundleURLTypes</key>
<array>
  <dict>
    <key>CFBundleURLSchemes</key>
    <array>
      <string>fbYOUR_FACEBOOK_APP_ID</string>
    </array>
  </dict>
</array>
<key>FacebookAppID</key>
<string>YOUR_FACEBOOK_APP_ID</string>
<key>FacebookDisplayName</key>
<string>Union Shop</string>
<key>LSApplicationQueriesSchemes</key>
<array>
  <string>fbapi</string>
  <string>fb-messenger-share-api</string>
</array>
```

## Installation & Running

### Install Dependencies
```bash
flutter pub get
```

### Run the App
```bash
# Web
flutter run -d chrome

# Android
flutter run -d android

# iOS
flutter run -d ios
```

## Features Guide

### For Users

#### Sign Up / Login
- Navigate to the login page (profile icon in header)
- Choose from:
  - Email/password (create account or sign in)
  - Google Sign-In (one-click)
  - Facebook Sign-In (one-click)

#### Account Dashboard
Once logged in, click your profile avatar to access:
- **My Account**: View profile overview
- **My Orders**: See order history (with mock data for demo)
- **Settings**: Edit profile, change password
- **Sign Out**: Log out of your account

#### Profile Management
- Update display name
- Change password (requires Firebase re-authentication for security)
- Upload profile photo (coming soon)
- Delete account (permanent action)

### For Developers

#### Auth Service (`lib/services/auth_service.dart`)
Main authentication service using Provider pattern:
```dart
// Access auth service
final authService = Provider.of<AuthService>(context);

// Check if user is logged in
if (authService.isAuthenticated) {
  // User is logged in
  final user = authService.currentUser;
}

// Sign in with email
await authService.signInWithEmail(email, password);

// Sign in with Google
await authService.signInWithGoogle();

// Sign in with Facebook
await authService.signInWithFacebook();

// Sign out
await authService.signOut();
```

#### User Model (`lib/models/user.dart`)
User data structure:
- `uid`: Unique user ID
- `email`: User email
- `displayName`: User's display name
- `photoUrl`: Profile photo URL
- `phoneNumber`: Phone number (optional)
- `orderHistory`: List of order IDs
- `preferences`: Custom user preferences

#### Protected Routes
Routes that require authentication automatically redirect to login if user is not authenticated.

## Testing Locally

### Web Testing
```bash
flutter run -d chrome --web-port=5000
```
Access at: `http://localhost:5000`

### Test Accounts
Create test accounts using:
- Email: `test@example.com`
- Password: `Test123!`

Or use Google/Facebook test users configured in their respective developer consoles.

## Production Deployment

### Before Deploying
1. ✅ Replace demo Firebase config with production credentials
2. ✅ Configure authorized domains in Firebase Console
3. ✅ Set up production OAuth redirect URIs
4. ✅ Enable email verification (optional but recommended)
5. ✅ Configure Firebase Security Rules
6. ✅ Set up Cloud Firestore for user data persistence (optional)

### Security Checklist
- [ ] Firebase Security Rules configured
- [ ] API keys restricted to specific domains
- [ ] OAuth clients configured for production URLs
- [ ] Email verification enabled
- [ ] Password reset emails customized
- [ ] Rate limiting configured

## Troubleshooting

### Firebase Initialization Fails
- Ensure Firebase config credentials are correct
- Check that Firebase project exists
- Verify all required Firebase services are enabled

### Google Sign-In Not Working
- Check authorized JavaScript origins in Google Cloud Console
- Verify SHA-1 fingerprint for Android
- Ensure GoogleService-Info.plist is properly configured for iOS

### Facebook Sign-In Not Working
- Verify Facebook App ID in all configuration files
- Check OAuth redirect URIs match exactly
- Ensure Facebook app is in "Live" mode (not Development)

### "User Not Found" Errors
- This is expected for new authentication systems
- Users need to create accounts before logging in
- Consider implementing account creation flow

## Next Steps

Recommended enhancements:
1. **Email Verification**: Require users to verify email before full access
2. **Cloud Firestore**: Store additional user data (addresses, preferences)
3. **Order Integration**: Connect order history to actual e-commerce backend
4. **Profile Photos**: Implement Firebase Storage for user photos
5. **2FA**: Add two-factor authentication for enhanced security
6. **Social Profiles**: Fetch additional data from social providers

## Support

For issues or questions:
- Check Firebase documentation: https://firebase.google.com/docs
- Google Sign-In: https://pub.dev/packages/google_sign_in
- Facebook Login: https://pub.dev/packages/flutter_facebook_auth
