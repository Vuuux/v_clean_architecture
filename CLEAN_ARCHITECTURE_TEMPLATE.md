# Clean Architecture Template - Flutter Project

Based on app-mobile project structure. Use this as a base template for new Flutter projects.

## Project Structure

```
project-name/
├── pubspec.yaml                    # Dependencies (get_it, go_router, flutter_bloc, dio, etc.)
├── analysis_options.yaml           # Dart analysis configuration
├── firebase.json                   # Firebase configuration
├── env/                            # Environment configurations
│   ├── dev.json
│   ├── sit.json
│   └── prod.json
├── assets/                         # Static assets
│   ├── fonts/                      # Custom fonts
│   ├── images/                     # Images with 2.0x, 3.0x variants
│   ├── l10n/                       # Localization files (en.json, th.json)
│   └── svg/                        # SVG assets
├── lib/
│   ├── main.dart                   # App entry point
│   ├── firebase_options.dart       # Firebase configuration
│   ├── app/                        # App-level configuration
│   │   ├── app.dart                # Main app widget
│   │   ├── app_dependency_injection.dart  # DI setup
│   │   ├── app_environment.dart    # Environment handling
│   │   └── app_router.dart         # Route configuration
│   ├── constants/                  # App-wide constants
│   ├── data/                       # Data Layer (Clean Architecture)
│   │   ├── sources/                # Data sources
│   │   │   ├── sources.dart        # Barrel export
│   │   │   ├── local_storage/      # Local data sources
│   │   │   └── remote/             # Remote data sources
│   │   └── repositories_impl/      # Repository implementations
│   ├── domain/                     # Domain Layer (Clean Architecture)
│   │   ├── entities/               # Domain entities/models
│   │   ├── repositories/           # Repository interfaces (abstract)
│   │   └── interactors/            # Use cases/business logic
│   └── presentation/               # Presentation Layer (Clean Architecture)
│       ├── global_blocs/           # App-wide BLoCs (Session, Loader, etc.)
│       └── features/               # UI features/screens
│           └── feature_name/       # Feature folder
│               ├── feature_page.dart
│               ├── feature_screen.dart
│               └── bloc/           # Feature BLoC
├── packages/                       # Local packages
│   ├── project_core/             # Shared utilities package
│   │   ├── lib/
│   │   │   ├── project_core.dart # Main export
│   │   │   └── src/
│   │   │       ├── enums/          # Shared enums
│   │   │       ├── extensions/     # Dart extensions
│   │   │       ├── http_client/    # HTTP client setup
│   │   │       ├── l10n/           # Localization utilities
│   │   │       ├── local_database/ # Database utilities
│   │   │       ├── local_storage/  # Storage utilities
│   │   │       ├── mixins/         # Shared mixins
│   │   │       ├── services/       # Shared services
│   │   │       └── types/          # Type definitions
│   │   └── pubspec.yaml
│   └── project_ui/                 # Shared UI components package
│       ├── lib/
│       │   ├── project_ui.dart     # Main export
│       │   └── src/
│       │       ├── theme/          # App themes, colors, text styles
│       │       └── widgets/        # Reusable UI components
│       ├── storybook/              # Component documentation
│       └── pubspec.yaml
└── test/                           # Tests
    └── widget_test.dart
```

## Key Dependencies (pubspec.yaml)

```yaml
dependencies:
  # State Management & Architecture
  flutter_bloc: ^8.1.6
  get_it: ^7.6.0              # Dependency injection
  equatable: ^2.0.5           # Value equality
  fpdart: ^1.1.0              # Functional programming

  # Navigation
  go_router: ^14.2.7

  # Network
  dio: ^5.7.0

  # Other common dependencies
  app_links: ^6.3.2
  url_launcher: ^6.3.0
  package_info_plus: ^8.0.2
  firebase_messaging: ^15.1.0
  flutter_local_notifications: ^17.2.3
  permission_handler: ^11.3.1
  toastification: ^2.3.0
```

## Architecture Principles

1. **Clean Architecture**: Separation of concerns with data, domain, and presentation layers
2. **Dependency Injection**: Using get_it for IoC container
3. **State Management**: BLoC pattern for predictable state management
4. **Modular Packages**: Separate packages for common utilities and UI components
5. **Feature-based Organization**: Group related functionality together
6. **Barrel Exports**: Use index files for clean imports

## Development Workflow

### 1. Feature Generation
Use the provided automation script to maintain architectural consistency:
```bash
make gen-feature
```
- Creates: `page`, `screen`, `bloc`, `interactor`, `repository`.
- Handles boilerplate for both state management and data flow.

### 2. Asset Management
Standardize asset usage via the `AssetConstants` class:
1. Place assets in `assets/`.
2. Update `pubspec.yaml`.
3. Run `make gen-assets` to generate Dart constants.
4. Use `AssetConstants.yourAssetName` in code.

### 3. Dependency Registration
Always register new dependencies in `lib/app/app_dependency_injection.dart` following the layers:
- Remote Data Sources
- Local Data Sources
- Repositories
- Interactors (Use Cases)

## App Flow & Logic

### 1. Overall Application Flow
<!-- Space for high-level navigation and app flow diagram -->
![App Flow Diagram](path/to/app_flow.png)

### 2. Data Flow (Clean Architecture)
<!-- Space for a diagram showing how data flows from DataSource -> Repository -> Interactor -> Bloc -> UI -->
![Data Flow Diagram](path/to/data_flow.png)

### 3. State Management (BLoC)
<!-- Space for BLoC state machine or event-state mapping diagram -->
![State Management Diagram](path/to/state_management.png)

## Usage

1. Copy this folder structure for new projects
2. Replace "project" with your actual project name
3. Update pubspec.yaml dependencies as needed
4. Implement your specific business logic following the same patterns
5. Use the packages/ folder for shared code across multiple apps

This structure provides a solid foundation for scalable Flutter applications following Clean Architecture principles.
