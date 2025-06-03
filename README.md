# UserSync

UserSync is a Flutter application that allows users to browse a list of users, view their detailed profiles (including posts and todos), and create new posts. The app features a modern UI with a theme toggle (light/dark) and a vibrant color scheme inspired by a sleek, black-and-white design with colorful accents.

# Features

User List: Displays a paginated list of users with search functionality.
User Details: Shows user info, their posts, and todos, with local post creation support.
Create Post: Allows users to create new posts for a selected user.
Theme Toggle: Switch between light and dark themes with a vibrant color palette.
Responsive UI: Designed with a clean, attractive interface using vibrant colors for cards and buttons.

# Screenshots

![alt text](<WhatsApp Image 2025-06-03 at 14.20.55_240edd5a.jpg>)

![alt text](<WhatsApp Image 2025-06-03 at 14.20.55_a3e6ecfa.jpg>)

![alt text](<WhatsApp Image 2025-06-03 at 14.20.55_66c5d285.jpg>)

![alt text](<WhatsApp Image 2025-06-03 at 14.20.54_20ae1b33.jpg>)

![alt text](<WhatsApp Image 2025-06-03 at 14.20.54_49465c5e.jpg>)

![alt text](<WhatsApp Image 2025-06-03 at 14.20.54_f5dc9a03.jpg>)

![alt text](<WhatsApp Image 2025-06-03 at 14.20.53_6f0eea6e.jpg>)

![alt text](<WhatsApp Image 2025-06-03 at 14.20.53_220dbe39.jpg>)

## Getting Started

# Prerequisites

Flutter SDK: Ensure you have Flutter installed (version 3.0.0 or higher recommended).
Dart: Comes with Flutter.
Dependencies:
flutter_bloc for state management.
cached_network_image for loading user images.

# Installation

Clone the Repository:git clone https://github.com/SumitSinghBharangar/user_sync-app.git
cd usersync

# Install Dependencies:

flutter pub get

# Run the App:

flutter run

# Project Structure

lib/
├── app_colors.dart # Color scheme definitions
├── data/
│ ├── models/ # Data models (User, Post, Todo)
│ └── services/ # API service for fetching data
├── presentation/
│ ├── blocs/ # BLoC for state management (UserList, UserDetail, Theme)
│ └── screens/ # UI screens (UserList, UserDetail, CreatePost)
└── main.dart # Entry point with ThemeBloc setup

# Usage

User List Screen: View a list of users, search by name, and pull to refresh. Tap a user to view details.
User Detail Screen: See user info, their posts, and todos. Use the "+" button to create a new post.
Create Post Screen: Add a new post for a user with a title and body.
Theme Toggle: Use the button in the AppBar on the User List screen to switch between light and dark themes.

# Contributing

Contributions are welcome! Please follow these steps:

# Fork the repository.

Create a new branch (git checkout -b feature/your-feature).
Make your changes.
Commit your changes (git commit -m "Add your feature").
Push to the branch (git push origin feature/your-feature).
Create a Pull Request.

# License

This project is licensed under the MIT License - see the LICENSE file for details.
Acknowledgments

Built with Flutter and Dart.
Inspired by a vibrant UI design with a black-and-white theme and colorful cards.
