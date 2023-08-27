# Pokemon
## _Flutter application task_

![Build Status](https://travis-ci.org/joemccann/dillinger.svg?branch=master)

This is a Flutter project that demonstrates various features and concepts,
including a splash screen, navigation, state management,
animations, and pagination.

The project follows the principles of clean architecture and SOLID principles..

## Features

- Splash Screen: The application starts with a splash screen that stays for 3
  seconds before navigating to the home page.

- Home Page: The home page contains a text field, a text widget that displays
  the entered text, and a clear button. The login functionality is handled by the HomeBloc,
  which is a global instance managed using the locator pattern provided
  by the get_it third-party package.

- Animation Page: The animation page allows the user to choose between
  three shapes and animate the displayed widget accordingly.
  This page demonstrates the usage of animations in Flutter.

- Paginated List Page: The paginated list page displays a list of Pokémon.
  The pagination functionality is implemented using a custom widget that handles the pagination logic.

## Architecture

The project follows the principles of clean architecture and SOLID principles.
The code is organized into different layers, including:
- Presentation Layer: Contains the UI components, such as screens, widgets, and animations.
- Domain Layer: Contains the business logic and use cases of the application.
- Data Layer: Handles data retrieval and storage, including API calls and database operations.
- Bloc Layer: Implements the state management using the BLoC (Business Logic Component) pattern.
  Each page or feature has its own BLoC responsible for managing its state.


## Installation

Clone the repository: git clone [Pokemon App](https://github.com/muhammdsh/pokemon.git).



Navigate to the project directory

```sh
cd project-directory
flutter pub get
flutter run
```

## Dependencies

The project uses the following dependencies:


| Dependency | Description |
| ------ | ------ |
| flutter_bloc | For implementing the BLoC pattern and managing state. |
| get_it |  For dependency injection and managing global instances. |
| go_router | For navigation management and routing. |
| Other | Other Flutter dependencies as required. |


## Contributing
Contributions are welcome! If you find any issues or have suggestions for improvements,
please open an issue or submit a pull request.

## License

This project is licensed under the MIT License.
