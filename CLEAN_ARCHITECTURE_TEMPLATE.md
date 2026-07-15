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
│   │   ├── assets.dart             # Asset paths
│   │   ├── bloc_operation_ids.dart # Bloc operation identifiers
│   │   ├── constants.dart          # General constants
│   │   ├── http_constants.dart     # HTTP/API constants
│   │   ├── app_constants.dart      # Business-specific constants
│   │   ├── route_names.dart        # Route name constants
│   │   └── app_local_storage_key.dart        # Storage key constants
│   ├── data/                       # Data Layer (Clean Architecture)
│   │   ├── datasources/            # Data sources
│   │   │   ├── datasources.dart    # Barrel export
│   │   │   ├── local/              # Local data sources
│   │   │   │   ├── local.dart      # Barrel export
│   │   │   │   ├── *_local_datasource.dart  # Local datasource implementations
│   │   │   │   └── impl/           # Concrete implementations
│   │   │   └── remote/             # Remote data sources
│   │   │       ├── remote.dart     # Barrel export
│   │   │       ├── *_remote_datasource.dart  # Remote datasource interfaces
│   │   │       └── impl/           # Concrete implementations
│   │   └── repositories/           # Repository implementations
│   │       ├── repositories.dart   # Barrel export
│   │       └── *_repository_impl.dart  # Repository concrete implementations
│   ├── domain/                     # Domain Layer (Clean Architecture)
│   │   ├── models/                 # Domain entities/models
│   │   ├── repositories/           # Repository interfaces (abstract)
│   │   └── interactors/            # Use cases/business logic
│   │       ├── interactors.dart    # Barrel export
│   │       ├── *_interactor.dart   # Use case interfaces
│   │       └── impl/               # Use case implementations
│   └── presentation/               # Presentation Layer (Clean Architecture)
│       ├── global_blocs/                  # State management (BLoC pattern)
│       │   ├── global_blocs.dart          # Barrel export
│       │   ├── common/             # Shared blocs
│       │   ├── handle_error/       # Error handling bloc
│       │   └── feature_name/       # Feature-specific blocs
│       │       ├── feature_bloc.dart
│       │       ├── feature_event.dart
│       │       └── feature_state.dart
│       └── features/               # UI features/screens
│           ├── authentication/     # Auth-related screens
│           ├── onboarding/         # Onboarding screens
│           ├── home/               # Home screens
│           ├── profile/            # Profile screens
│           ├── navigation_scaffold/  # Navigation wrapper
│           └── feature_name/       # Feature screens
│               ├── pages/          # Screen widgets
│               └── widgets/        # Feature-specific widgets
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

## Usage

1. Copy this folder structure for new projects
2. Replace "project" with your actual project name
3. Update pubspec.yaml dependencies as needed
4. Implement your specific business logic following the same patterns
5. Use the packages/ folder for shared code across multiple apps

This structure provides a solid foundation for scalable Flutter applications following Clean Architecture principles.
