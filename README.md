[![Swift](https://img.shields.io/badge/Swift-5.9-orange)](https://swift.org)
[![Tuist](https://img.shields.io/badge/Tuist-Modular-blue)](https://tuist.io)
[![iOS](https://img.shields.io/badge/iOS-16+-lightgrey)](https://developer.apple.com/ios/)

<img src="https://github.com/user-attachments/assets/590f4ebb-2f0a-45ba-a111-c5a73c780384" alt="Hero Banner" width="100%" />

# 🧠 ImageDescriberAI

Effortlessly turn images into natural language descriptions using OpenAI’s GPT-4o vision model. Built with SwiftUI, Cloudinary, and a scalable backend proxy—ready for real-world use and distribution.

---

## ✨ Features

- 📸 Native SwiftUI interface with Photos picker
- 🧠 Vision-powered GPT-4o AI descriptions
- ⚡️ Secure image uploads via **Cloudinary**
- 🔐 OpenAI API access via Vercel proxy (no key in app)
- 🧱 Modular Tuist-based architecture (MVVM)
- ✅ Responsive loading/error states + debounced scanning
- 📦 Seamless TestFlight automation with Fastlane + GitHub Actions

---

## 📷 How It Works

1. Select an image from your library
2. The image is uploaded to Cloudinary
3. The Cloudinary URL is sent to a **Vercel proxy**
4. The proxy securely talks to OpenAI’s `gpt-4o` model
5. A natural-language description is returned and displayed in-app

---

## 🛠 Architecture

- **SwiftUI + MVVM**
- **Tuist Modular Design**
- **Backend Proxy (Vercel)** for secure key handling
- **Cloudinary SDK** integration for image hosting
- **Main Modules:**
  - `ImageDescriberAI` (App entry)
  - `ImageScannerUI`
  - `ImageAnalysis`
  - `AIDescriptionService`
  - `SharedModels`
  - `ImageUploader`
  - `OpenAIProvider`

---

## 🔐 Secrets / API Keys

The app does **not** expose OpenAI keys. Keys are securely used in the backend proxy.

For local testing, the project uses `.env`:

```env
OPENAI_API_KEY=your-api-key-here


- Copy `.env.example` to `.env`
- Add your OpenAI key
- `.env` is listed in `.gitignore`
- During debug, the file must be copied into the app bundle manually
- During CI builds, a dummy `.env` is injected automatically
```

---

## 🚀 Getting Started

This project uses Tuist for project generation and includes CI automation:

```bash
# 1. Clone this repo
# 2. Install Tuist
brew install tuist

# 3. Generate the project
cd ImageDescriberAI
tuist generate

# 4. Tuist usually opens the project automatically. But if not, open the workspace:
open ImageDescriberAI.xcworkspace
```

---

## 🧪 CI Pipeline

TestFlight deployment is automated using GitHub Actions + Fastlane:

- 🏗 Builds and tests on `macos-latest`
- ✅ Automatically disables code signing
- 📦 Injects a dummy `.env` value for testing and builds and pushes to TestFlight on tag push (e.g. v1.0.0-testflight)
  Example:
   ```
  on:
  push:
    tags:
      - 'v*.*.*-testflight'
   ```
- 🧼 Cleans derived data for consistency
- 🔐 Secrets handled with GitHub Actions encrypted secrets
- 🔍 Uses `xcodebuild` with inline build flags:

```bash
xcodebuild build-for-testing \  
  CODE_SIGNING_ALLOWED=NO CODE_SIGNING_REQUIRED=NO CODE_SIGN_IDENTITY=""
```

> ⚠️ Note: Do not define these variables separately with backslashes (`\`) across lines.  
They must be **inline build settings**, or they will be ignored.

---

## 📦 Future Enhancements

- 🔄 Usage-based scan credits
- 🛒 In-app purchases via StoreKit or Stripe
- 🧠 Scan history and logging
- 🌐 Multilingual support
- 🧼 Offline caching of results

---

## 📸 Demo & Screenshots

*Coming soon: demo of image selection → AI description.*

---

## 🧪 Testing & Contribution

- Unit testing is supported through the `ImageDescriberAITests` target
- Modular design makes mocking and test injection easy

### 👥 Contributing

PRs welcome! If you find a bug or want to propose an improvement, open an issue or submit a pull request. Let's make it better together.

---

## 👨‍💻 Built By

**Oniel Rosario** – iOS Engineer | AI Explorer | Modular Design Enthusiast

Have ideas, feedback, or want to collaborate? Feel free to reach out or contribute ✌️



