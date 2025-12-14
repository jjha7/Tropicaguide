# tropicaguide

TropicaGuide

TropicaGuide is a collaborative travel planning application built with Flutter.
It helps groups plan trips together by organizing itineraries, packing lists, travelers, shared files, and group communication in one place.

The project is designed to simulate a real-world travel planning product with a modern UI, scalable structure, and future-ready backend integration.

Project Overview

Travel planning often becomes chaotic when multiple people are involved. Important details get lost across chats, documents, and notes. TropicaGuide centralizes everything into a single app where travelers can coordinate plans clearly and efficiently.

The application focuses on usability, visual clarity, and collaboration rather than just static planning.

# PPT LINK - https://drive.google.com/file/d/16HBgFwfkIx4KuQ4wD6zxQxWK4lqlAcTY/view?usp=sharing
# SHORT DEMO - https://drive.google.com/file/d/151mjffGHxBxav9ejIDVOaaZh-_BiuEPX/view?usp=sharing

Core Features

User authentication screens (login and signup UI)

Home dashboard displaying all trips

Create new trips with destination, dates, and cover image

Detailed trip view with tab-based navigation:

Itinerary planning

Packing list

Checklist

Members management

Shared files (PDF uploads)

Group chat

Add guest travelers to trips

Upload and view travel documents such as tickets and reservations

Clean, modern UI with animations, illustrations, and dark theme styling

Tech Stack

Flutter (Dart)

Provider for state management

Material 3 UI

Lottie animations

Google Fonts

File Picker for document uploads

UUID for unique IDs

Firebase dependencies are included and will be fully integrated in later milestones.

Project Structure
lib/
 ├── app/
 │   └── app.dart
 ├── screens/
 │   ├── auth/
 │   ├── home/
 │   ├── trip/
 │   ├── profile/
 │   └── explore/
 ├── store/
 │   └── trip_store.dart
 ├── models/
 ├── theme/
 └── main.dart

assets/
 ├── images/
 ├── icons/
 └── lottie/

How to Run the App
Prerequisites

Flutter SDK installed

Chrome (for web) or Android emulator/device

Install dependencies
flutter pub get

Run on Chrome
flutter run -d chrome

Build APK (Android)
flutter build apk --release


The generated APK will be located at:

build/app/outputs/flutter-apk/app-release.apk

Assets

All assets are stored locally and declared in pubspec.yaml.

Travel images for trips

App logo

Lottie animations for travel illustrations

Current Status

UI and local state management implemented

Core screens and navigation completed

File upload works locally

Chat and collaboration logic implemented locally

Future Enhancements

Firebase Authentication

Firestore real-time sync

Cloud storage for files

Real-time collaborative editing

Push notifications

Drag-and-drop itinerary planning

Multi-device sync
![WhatsApp Image 2025-12-13 at 22 24 45_52a16e91](https://github.com/user-attachments/assets/04e35000-31b3-4b04-a5fe-9cc5baed5790)

![WhatsApp Image 2025-12-13 at 22 26 57_2a28f1f9](https://github.com/user-attachments/assets/5f58a5fa-fe1c-46c7-98a5-833b2e8828cf)

![WhatsApp Image 2025-12-13 at 22 25 02_eb9fcd40](https://github.com/user-attachments/assets/e60aff96-95b7-4448-a4d2-0f3d8aae2302)


Contributors

Jigyasa Jha and Dhruv lineswala

License

This project is for educational and portfolio purposes.
