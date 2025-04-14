[![Swift](https://img.shields.io/badge/Swift-5.9-orange)](https://swift.org)
[![Tuist](https://img.shields.io/badge/Tuist-Modular-blue)](https://tuist.io)
[![iOS](https://img.shields.io/badge/iOS-16+-lightgrey)](https://developer.apple.com/ios/)


<img src="https://github.com/user-attachments/assets/590f4ebb-2f0a-45ba-a111-c5a73c780384" alt="Hero Banner" width="100%" />

# 🧠 ImageDescriberAI

Effortlessly turn images into natural language descriptions using OpenAI’s GPT-4o vision model. Built in SwiftUI with a modular, production-ready architecture.

---

## ✨ Features

- Beautiful native SwiftUI interface
- Clean, scalable architecture (MVVM + Tuist)
- Modular codebase with separation of concerns
- Vision-powered AI descriptions via GPT-4o
- Integrated Photos picker UI
- Responsive loading and error states
- Debounced scanning to prevent duplicate requests

---

## 📷 How It Works

1. Pick an image from your photo library
2. Image is encoded and passed to an OpenAI-powered service
3. GPT-4o vision model processes and returns a description
4. Result is displayed in a styled UI card

---

## 🛠 Architecture

- **SwiftUI + MVVM**
- **Modular Design:** Built with [Tuist](https://tuist.io)
- **Main Modules:**
  - `ImageDescriberAI` (App entry)
  - `ImageScannerUI`
  - `ImageAnalysis`
  - `AIDescriptionService`
  - `SharedModels`
  - `Utilities`
  - `OpenAIProvider`

---

## 🔐 Secrets / API Keys

This project uses a `.env` file to securely load API keys:

```env
OPENAI_API_KEY=your-api-key-here
```

- Copy `.env.example` to `.env`
- Add your OpenAI key
- `.env` is listed in `.gitignore`
- During debug, the file must be copied into the app bundle manually
- During CI builds, a dummy `.env` is injected automatically

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

This project includes a GitHub Actions workflow for CI:

- 🏗 Builds and tests on `macos-latest`
- ✅ Automatically disables code signing
- 📦 Injects a dummy `.env` value for testing
- 🧼 Cleans derived data for consistency
- 🔍 Uses `xcodebuild` with inline build flags:

```bash
xcodebuild build-for-testing \  
  CODE_SIGNING_ALLOWED=NO CODE_SIGNING_REQUIRED=NO CODE_SIGN_IDENTITY=""
```

> ⚠️ Note: Do not define these variables separately with backslashes (`\`) across lines.  
They must be **inline build settings**, or they will be ignored.

---

## 📦 Future Enhancements

- Usage-based credit system for scans
- Backend proxy to shield OpenAI keys
- In-app purchases or Stripe integration
- Scan history log
- Multilingual support

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

**Oniel Rosario** – iOS Engineer & AI Explorer

Have ideas, feedback, or want to collaborate? Feel free to reach out or contribute ✌️



