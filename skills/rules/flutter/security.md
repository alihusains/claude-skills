> This file extends [common/security.md](../common/security.md) with Flutter/Dart specific content.

# Flutter Security

## Data Protection
- NEVER store sensitive data (API keys, tokens) in plain text in `SharedPreferences` or `sqflite`.
- Use `flutter_secure_storage` for storing secrets (KeyChain on iOS, AES on Android).
- Obfuscate your app using `--obfuscate --split-debug-info` during release builds.

## Network Security
- ALWAYS use HTTPS for all network requests.
- Implement SSL Pinning for high-security applications using `http_certificate_pinning`.
- Sanitize and validate all user inputs before displaying them in UI to prevent injection.
