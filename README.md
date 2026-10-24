# Smart Pay

A Flutter fintech app covering onboarding and authentication, built with a modular, feature-based architecture.

## Features
- Onboarding carousel and splash screen
- Register, log in, email OTP verification, country selection, PIN set-up and PIN login
- Authenticated dashboard that calls a protected API endpoint
- Tokens stored in `flutter_secure_storage`

## Stack
Flutter · hooks_riverpod / flutter_hooks · http · pin_code_fields · flutter_svg

## Structure
```
lib/app/modules/{onboard,authentication,dashboard}/{data,domain,presentation}
lib/app/shared/  HTTP client, secure storage, shared components
```

## Run
```bash
flutter pub get
flutter run
```
