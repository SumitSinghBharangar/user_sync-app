# UserSync Documentation

This document provides detailed technical information about the UserSync app, a Flutter-based application for browsing users, viewing their details, and creating posts. It covers the architecture, file structure, state management, theming, and color scheme.

# Architecture

UserSync follows the BLoC (Business Logic Component) pattern for state management, ensuring a separation of concerns between UI and business logic. The app uses a layered architecture:

# Data Layer:

Handles API calls and data models.

# Presentation Layer:

Manages UI and state using BLoC.

# App Layer:

Centralizes shared resources like colors and themes.

# File Structure

lib/
├── app_colors.dart # Defines the color scheme for the app
├── data/
│ ├── models/ # Data models for User, Post, and Todo
│ │ ├── user_model.dart
│ │ ├── post_model.dart
│ │ └── todo_model.dart
│ └── services/
│ └── api_service.dart # Service for fetching user data from API
├── presentation/
│ ├── blocs/ # BLoC for state management
│ │ ├── user_list/ # BLoC for user list screen
│ │ ├── user_detail/ # BLoC for user detail screen
│ │ └── theme/ # BLoC for theme management (in main.dart)
│ └── screens/ # UI screens
│ ├── user_list_screen.dart
│ ├── user_detail_screen.dart
│ └── create_post_screen.dart
└── main.dart # Entry point with ThemeBloc setup

# State Management

The app uses flutter_bloc for state management. Key BLoCs include:

# UserListBloc

Location: lib/presentation/blocs/user_list/
Purpose: Manages the state of the user list screen, including fetching users, pagination, and search.
Events:
FetchUsers: Fetches users with pagination (skip, limit).
SearchUsers: Filters users by name.

States:
UserListLoading: Indicates loading state.
UserListLoaded: Contains the list of users and pagination info.
UserListError: Displays error messages.

# UserDetailBloc

Location: lib/presentation/blocs/user_detail/
Purpose: Manages the state of the user detail screen, including fetching posts/todos and adding local posts.
Events:
FetchUserDetails: Fetches posts and todos for a user.
AddPost: Adds a new local post.

States:
UserDetailLoading: Indicates loading state.
UserDetailLoaded: Contains posts, todos, and local posts.
UserDetailError: Displays error messages.

ThemeBloc

Location: lib/main.dart
Purpose: Manages theme switching between light and dark modes.
Events:
ToggleTheme: Toggles between light and dark themes.

States:
ThemeData: Emits the current theme (light or dark).

# Theming

The app supports light and dark themes, managed by ThemeBloc in main.dart. Themes are defined using ThemeData:

# Light Theme:

Background: AppColors.lightBackground (white, #FFFFFF).
Primary Text: AppColors.primaryTextLight (dark gray, #212121).
AppBar: AppColors.primaryColor (green, #00C853).

# Dark Theme:

Background: AppColors.darkBackground (black, #000000).
Primary Text: AppColors.primaryTextDark (white, #FFFFFF).
AppBar: AppColors.primaryColor (green, #00C853).

# Theme Toggle

The theme toggle button is in the UserListScreen AppBar.
It switches between light and dark themes by dispatching a ToggleTheme event to ThemeBloc.

# Color Scheme

The color scheme is defined in app_colors.dart and is inspired by a vibrant UI design with a black-and-white theme and colorful cards. Key colors include:

# Backgrounds:

lightBackground: #FFFFFF (white).
darkBackground: #000000 (black).

Text:
primaryTextLight: #212121 (dark gray).
primaryTextDark: #FFFFFF (white).
secondaryTextLight: #757575 (muted gray).
secondaryTextDark: #B0B0B0 (muted gray).

Accents:
primaryColor: #00C853 (vibrant green).
accentColor: #3B82F6 (bright blue).

Cards:
cardColor1: #D4F7E2 (light green).
cardColor2: #D1E8FF (light blue).
cardColor3: #FFF9C4 (yellow).
cardColor4: #E1D5F7 (purple).

These colors are applied to cards, buttons, and other UI elements to create a lively and attractive interface.

# Screens

# UserListScreen

Path: lib/presentation/screens/user_list_screen.dart
Features:
Displays a paginated list of users.
Supports search by name.
Pull-to-refresh functionality.
Theme toggle button in the AppBar.

UI:
Users are displayed in cards with alternating colors (cardColor1 to cardColor4).
TextField for search uses theme-defined inputDecorationTheme.

# UserDetailScreen

Path: lib/presentation/screens/user_detail_screen.dart
Features:
Shows user info (name, email, image).
Displays posts and todos fetched via UserDetailBloc.
Allows creating new posts via a "+" button.

UI:
User info in a Card with cardColor2 (light blue).
Posts and todos in cards with alternating colors (cardColor1 to cardColor4).
Divider between sections uses hintText grey (#9E9E9E).

# CreatePostScreen

Path: lib/presentation/screens/create_post_screen.dart
Features:
Form to create a new post (title, body).
Submits the post locally via UserDetailBloc.

UI:
User info in a Card with cardColor2 (light blue).
Form fields in a Card with cardColor3 (yellow).
Submit button uses buttonPrimary (green, #00C853).

# Dependencies

Add the following to your pubspec.yaml:
dependencies:
flutter:
sdk: flutter
flutter_bloc: ^8.1.1
cached_network_image: ^3.2.3

# API Integration

ApiService (lib/data/services/api_service.dart): Fetches user data, posts, and todos from an API (assumed to be a placeholder like JSONPlaceholder).
Models:
User: Contains user info (id, name, email, image).
Post: Contains post info (id, title, body).
Todo: Contains todo info (id, todo, completed).

# Notes

Accessibility: The color scheme ensures high contrast for readability (e.g., white text on black background in dark theme).
Current Date: This app was developed as of June 03, 2025, ensuring modern Flutter practices.

# Future Improvements:

Add animations for theme transitions.
Support offline storage for posts.
Enhance error handling with retry mechanisms.

# Contact

For questions or contributions, please open an issue on the repository.
contact : +91 9917709350
email : bharangarsinghsumit@gmail.com
