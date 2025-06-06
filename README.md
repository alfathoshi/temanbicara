# Teman Bicara  
**Your Personal Mental Health Companion**  

[![Last Commit](https://img.shields.io/github/last-commit/alfathoshi/temanbicara?color=blue)](https://github.com/alfathoshi/temanbicara/commits/main)
[![Release](https://img.shields.io/github/v/release/alfathoshi/temanbicara?color=green)](https://github.com/alfathoshi/temanbicara/releases)
[![Issues](https://img.shields.io/github/issues/alfathoshi/temanbicara)](https://github.com/alfathoshi/temanbicara/issues)
[![License](https://img.shields.io/github/license/alfathoshi/temanbicara)](LICENSE)

---

## 🛠️ Tools and Technologies

<p align="left"> <img alt="Flutter" src="https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white"/> <img alt="Dart" src="https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white"/> <img alt="Firebase" src="https://img.shields.io/badge/Firebase-FFCA28?style=for-the-badge&logo=firebase&logoColor=black"/> <img alt="Laravel" src="https://img.shields.io/badge/Laravel-FF2D20?style=for-the-badge&logo=laravel&logoColor=white"/> <img alt="MySQL" src="https://img.shields.io/badge/MySQL-4479A1?style=for-the-badge&logo=mysql&logoColor=white"/> <img alt="Supabase" src="https://img.shields.io/badge/Supabase-3ECF8E?style=for-the-badge&logo=supabase&logoColor=white"/> <img alt="GetX" src="https://img.shields.io/badge/GetX-68D391?style=for-the-badge&logo=github&logoColor=white"/> <img alt="Firebase Realtime DB" src="https://img.shields.io/badge/Firebase_Realtime_DB-FFCA28?style=for-the-badge&logo=firebase&logoColor=black"/> <img alt="Midtrans" src="https://img.shields.io/badge/Midtrans-0086C3?style=for-the-badge&logo=google-pay&logoColor=white"/> </p>

---

## 📚 Table of Contents

- [Overview](#-overview)  
- [Getting Started](#-getting-started)  
- [Features](#-features)  
- [Project Index](#-project-index)  
- [Roadmap](#-roadmap)  
- [Acknowledgements](#-acknowledgements)  
- [Contributing](#-contributing)  
- [Project Structure](#-project-structure)  
- [License](#-license)  

---

## 🔍 Overview

**Teman Bicara** is a mobile application aimed to support users' mental wellness.  
From AI-based mental health tracking to journaling and professional consultations, this app helps users build awareness and take control of their emotional well-being.

---

## 🚀 Getting Started

### ✅ Prerequisites

- Flutter SDK (≥ 3.0.0)  
- Dart SDK  
- Firebase project setup (for Auth & Realtime Database)  
- Laravel backend (API server)  
- MySQL database  
- Midtrans developer account  
- Gemini AI API access  

### 📦 Installation

1. Clone this repository:

    ```bash
    git clone https://github.com/your-username/teman-bicara.git
    cd teman-bicara
    ```

2. Install Flutter dependencies:

    ```bash
    flutter pub get
    ```

3. Set up Firebase:

    - Add your `google-services.json` (Android) and `GoogleService-Info.plist` (iOS)  
    - Enable Firebase Authentication and Realtime Database  

4. Configure Laravel backend:

    - Clone Laravel backend repository  
    - Setup `.env`, database, and run migrations  
    - Serve the API using:

    ```bash
    php artisan serve
    ```

5. Run the Flutter app:

    ```bash
    flutter run
    ```

---

## ✨ Features

### 🔐 Authentication

- Register, login, and password reset with OTP verification  

### 👤 Personal Profile

- Fill in user info after registration (name, nickname, phone, gender, birthdate)  
- Edit name and birthdate  

### 📊 Mental Tracking

- Input daily mood, sleep quality, stress level, steps per day, screen time  
- View AI-based daily and weekly mental health insights  

### 📓 Journal

- Create a journal entry with title, content, and optional image  

### 🤖 AI Chatbot

- Talk to your AI friend powered by Gemini for emotional support  

### 📚 Articles

- Read mental health articles created by certified counselors  

### 💬 Consultations

- Filter and book sessions with mental health experts  
- Payment handled via Midtrans  
- View consultation history  

---

## 🗂️ Project Index

| Module            | Description                          |
|-------------------|--------------------------------------|
| `lib/views/`      | UI screens                           |
| `lib/viewmodels/` | State management logic (MVVM)        |
| `lib/models/`     | Data models                          |
| `lib/services/`   | API, Firebase, DB services           |
| `lib/widgets/`    | Reusable UI components               |
| `lib/utils/`      | Helpers, constants                   |

---

## 🧭 Roadmap

- [x] MVP release (auth, journal, chatbot, tracking)  
- [x] Integrate Gemini AI  
- [x] Consultation module with Midtrans payment  
- [ ] Dark mode support  
- [ ] Push notifications (FCM)  
- [ ] Multi-language support (EN/ID)  
- [ ] Admin dashboard (Web)  

---

## 🙌 Acknowledgements

- [OpenAI / Gemini](https://deepmind.google/technologies/gemini/) – for AI model  
- [Flutter Devs](https://flutter.dev) – for open-source libraries  
- [Midtrans](https://midtrans.com) – for payment API  
- [Firebase](https://firebase.google.com) – for Auth & Realtime Database  

---

## 👥 Contributors

Thanks to these amazing people for contributing to Teman Bicara:

<a href="https://github.com/alfathoshi">
  <img src="https://avatars.githubusercontent.com/u/alfathoshi?v=4" width="60" alt="Muhammad Bintang Al-Fath"/>
</a>
<a href="https://github.com/Raga-Git">
  <img src="https://avatars.githubusercontent.com/u/Raga-Git?v=4" width="60" alt="Ragadhitya Janatantra Koeshutama"/>
</a>
<a href="https://github.com/RevanArturito">
  <img src="https://avatars.githubusercontent.com/u/RevanArturito?v=4" width="60" alt="Cokorda Arturito Revan Putra Diarta"/>
</a>
<a href="https://github.com/Febry3">
  <img src="https://avatars.githubusercontent.com/u/Febry3?v=4" width="60" alt="Febry Twenido Firmanio"/>
</a>
<a href="https://github.com/hafiiddd">
  <img src="https://avatars.githubusercontent.com/u/hafiiddd?v=4" width="60" alt="Hafid Alakhyar"/>
</a>
<a href="https://github.com/GinaSoraya">
  <img src="https://avatars.githubusercontent.com/u/GinaSoraya?v=4" width="60" alt="Gina Soraya"/>
</a>

---

## 🧱 Project Structure

```bash
lib/
├── models/          # Data classes
├── views/           # UI pages
├── viewmodels/      # Business logic / state
├── services/        # API & DB handling
├── widgets/         # Custom reusable components
├── utils/           # Constants & helpers
└── main.dart        # App entry point
