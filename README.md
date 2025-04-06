[![Swift](https://img.shields.io/badge/Swift-5.9-orange)](https://swift.org)
[![Tuist](https://img.shields.io/badge/Tuist-Modular-blue)](https://tuist.io)
[![iOS](https://img.shields.io/badge/iOS-16+-lightgrey)](https://developer.apple.com/ios/)


<img src="https://github.com/user-attachments/assets/590f4ebb-2f0a-45ba-a111-c5a73c780384" alt="Hero Banner" width="100%" />

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

![Architecture](https://github.com/user-attachments/assets/18b88d76-24bb-4aa8-bf25-abacb0bf97a4)

---

## 🔐 Secrets / API Keys

This project uses a `.env` file to securely load API keys:

```
OPENAI_API_KEY=your-api-key-here
```

- Copy `.env.example` to `.env`
- Add your OpenAI key
- `.env` is listed in `.gitignore`
- During debug, the file must be copied into the app bundle manually

---

## 🚀 Getting Started

This project includes a `bootstrap.sh` script to help set up your development environment quickly:
```
./bootstrap.sh
```
This installs Tuist (if needed), sets up modules, and configures local paths.

1. Clone this repo
2. Install [Tuist](https://tuist.io)
3. Run `tuist generate`
4. Open `ImageDescriberAI.xcworkspace`
5. Build and run in Xcode (simulator or device)

---

## 📦 Future Enhancements

- Usage-based credit system for scans
- Backend proxy to shield OpenAI keys
- In-app purchases or Stripe integration
- Scan history log
- Multilingual support

---

## 📸 Demo & Screenshots

*Coming soon: GIF demo of image selection → AI description.*

*Add screenshots of sample usage here.*

---

## 👨‍💻 Built By

**Oniel Rosario** – iOS Engineer

Have ideas, feedback, or want to collaborate? Feel free to reach out or contribute ✌️

