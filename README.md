# Movies in Showcase App

A Flutter application that allows users to browse, search, and discover movies. The app provides detailed information about each movie, including ratings, and more.

## Demo

<p align="center">
  <img src="demo.gif" alt="animated" width="200" height="350"/>
</p>

## Features

- Browse a list of movies in showcase
- Search for movies by title
- View movie details, including synopsis, release date, and ratings

## Technologies Used

- Flutter
- Dart
- The Movie Database [TMDb](https://www.themoviedb.org/) API

## Getting Started

### Prerequisites

- Flutter SDK (https://flutter.dev/docs/get-started/install)
- Dart SDK (comes with Flutter)
- An IDE (Android Studio, Visual Studio Code, etc.)

### Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/csq/movie_app.git
   ```

2. Navigate to the project directory:

    ```bash
    cd movie_app
    ```

3. Install the dependencies:

    ```bash
    flutter pub get
    ```

4. Obtain an API key from The Movie Database (TMDb) and add it to your project and paste in `.env` file:

    ```bash
    # Secret for api.themoviedb.org
    API_THEMOVIEDB_KEY='PASTE HERE YOUR KEY';
    ```

5. Run the app:

    ```bash
    flutter run
    ```

## Usage

    Launch the app to see the list of movies in showcase.
    Use the search bar to find specific movies.
    Tap on a movie to view its details.
