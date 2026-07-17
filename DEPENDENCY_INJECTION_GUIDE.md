# Clean Architecture with Dependency Injection Implementation Guide

This document provides a comprehensive guide to implementing Clean Architecture with Dependency Injection in Flutter projects, based on the nan-mobile project structure.

## Table of Contents

1. [Project Structure Overview](#project-structure-overview)
2. [Dependency Injection Setup](#dependency-injection-setup)
3. [Clean Architecture Layers](#clean-architecture-layers)
4. [Implementation Flow](#implementation-flow)
5. [Key Components](#key-components)
6. [Best Practices](#best-practices)
7. [Step-by-Step Implementation](#step-by-step-implementation)

## Project Structure Overview

```
lib/
├── app/
│   ├── app.dart                          # Main application widget
│   ├── app_dependency_injection.dart     # DI container setup
│   ├── app_environment.dart             # Environment configuration
│   └── app_router.dart                  # Navigation routing
├── constants/
│   ├── http_constants.dart              # HTTP client constants
│   └── constants.dart                   # Export file
├── data/
│   ├── datasources/
│   │   ├── local/                       # Local data sources
│   │   └── remote/                      # Remote API data sources
│   └── repositories/                    # Repository implementations
├── domain/
│   ├── interactors/                     # Use cases/business logic
│   ├── models/                          # Domain entities
│   └── repositories/                    # Repository interfaces
└── presentation/
    ├── blocs/                           # State management (BLoC)
    └── features/                        # UI screens and widgets
```

## Dependency Injection Setup

### 1. Core DI Container

The project uses `get_it` package for dependency injection with a singleton pattern:

```dart
// app/app_dependency_injection.dart
final class DI {
  late GetIt _getIt;
  static final DI shared = DI._();

  factory DI() => shared;

  DI._() {
    _getIt = GetIt.instance;
  }

  T get<T extends Object>() => _getIt<T>();

  Future<void> initialize() async {
    // Registration logic here
  }
}
```

### 2. Registration Categories

The dependency injection is organized into logical categories:

#### A. HTTP Clients Registration
```dart
// Multiple named HTTP clients for different services
_getIt.registerSingleton<BaseHttpClient>(
  DioClient(
    Dio(),
    host: AppEnvironment.lmsHost,
    certPining: AppEnvironment.certPinning,
    shouldIgnoreSSL: AppEnvironment.ignoreSSL,
    headers: {
      HttpConstants.contentType: HttpConstants.jsonContentType,
    },
  ),
  instanceName: HttpConstants.lmsHttpClient,
);
```

#### B. Local Storage Registration
```dart
_getIt.registerSingleton<LocalStorage>(
  SecureStorage(),
);
```

#### C. Data Sources Registration
```dart
// Local Data Sources
_getIt.registerFactory<AuthLocalDatasource>(
  () => AuthLocalDatasourceImpl(
    localStorage: _getIt<LocalStorage>(),
  ),
);

// Remote Data Sources
_getIt.registerFactory<AuthRemoteDatasource>(
  () => AuthRemoteDatasourceImpl(
    indentityClient: _getIt<BaseHttpClient>(
      instanceName: HttpConstants.identityHttpClient,
    ),
    lmsClient: _getIt<BaseHttpClient>(
      instanceName: HttpConstants.lmsHttpClient,
    ),
  ),
);
```

#### D. Repositories Registration
```dart
_getIt.registerFactory<AuthRepository>(
  () => AuthRepositoryImpl(
    authRemoteDatasource: _getIt<AuthRemoteDatasource>(),
    authLocalDatasource: _getIt<AuthLocalDatasource>(),
  ),
);
```

#### E. Interactors (Use Cases) Registration
```dart
_getIt.registerFactory<AuthInteractor>(
  () => AuthInteractorImpl(
    authRepository: _getIt<AuthRepository>(),
    userRepository: _getIt<UserRepository>(),
  ),
);
```

## Clean Architecture Layers

### 1. Domain Layer (Business Logic Core)

**Location**: `lib/domain/`

- **Models**: Pure Dart entities representing business objects
- **Repositories**: Abstract interfaces defining data operations
- **Interactors**: Use cases containing business logic

```dart
// domain/repositories/auth_repository.dart
abstract class AuthRepository {
  Future<Either<Failure, AuthModel>> login(LoginRequest request);
  Future<Either<Failure, void>> logout();
}

// domain/interactors/auth_interactor.dart
abstract class AuthInteractor {
  Future<Either<Failure, AuthModel>> login(LoginRequest request);
  Future<Either<Failure, void>> logout();
}
```

### 2. Data Layer (External Interfaces)

**Location**: `lib/data/`

- **Data Sources**: Handle data from specific sources (API, local storage)
- **Repository Implementations**: Concrete implementations of domain repositories

```dart
// data/datasources/remote/auth_remote_datasource.dart
abstract class AuthRemoteDatasource {
  Future<AuthResponseDto> login(LoginRequestDto request);
}

// data/repositories/auth_repository_impl.dart
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource authRemoteDatasource;
  final AuthLocalDatasource authLocalDatasource;

  AuthRepositoryImpl({
    required this.authRemoteDatasource,
    required this.authLocalDatasource,
  });

  @override
  Future<Either<Failure, AuthModel>> login(LoginRequest request) async {
    // Implementation with error handling and data transformation
  }
}
```

### 3. Presentation Layer (UI and State Management)

**Location**: `lib/presentation/`

- **BLoCs**: State management using flutter_bloc
- **Features**: UI screens and widgets

```dart
// presentation/blocs/authentication/auth_bloc.dart
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthInteractor authInteractor;

  AuthBloc({
    required this.authInteractor,
  }) : super(AuthInitial()) {
    on<LoginRequested>(_onLoginRequested);
  }

  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    // Business logic execution
    final result = await authInteractor.login(event.request);
    // State emission based on result
  }
}
```

## Implementation Flow

### 1. Application Bootstrap

```dart
// main.dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize dependencies
  await DI().initialize();
  
  runApp(const NanApp());
}
```

### 2. DI Integration in App Widget

```dart
// app/app.dart
class NanApp extends StatefulWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(
            authInteractor: DI().get<AuthInteractor>(),
          ),
        ),
        // Other BLoCs...
      ],
      child: MaterialApp.router(
        routerConfig: AppRouter().router,
      ),
    );
  }
}
```

### 3. HTTP Client Configuration

```dart
// constants/http_constants.dart
class HttpConstants {
  static String lmsHttpClient = 'lmsHttpClient';
  static String identityHttpClient = 'identityHttpClient';
  static String coursesHttpClient = 'coursesHttpClient';
  
  static String contentType = 'Content-Type';
  static String jsonContentType = 'application/json';
  static String authorization = 'Authorization';
}
```

## Key Components

### 1. Environment Configuration

```dart
// app/app_environment.dart
class AppEnvironment {
  static String get lmsHost => _getConfig('LMS_HOST');
  static String get identityHost => _getConfig('IDENTITY_HOST');
  static String get coursesHost => _getConfig('COURSES_HOST');
  static bool get certPinning => _getBoolConfig('CERT_PINNING');
  static bool get ignoreSSL => _getBoolConfig('IGNORE_SSL');
}
```

### 2. Base HTTP Client

```dart
// Using nan_mobile_common package
abstract class BaseHttpClient {
  Future<Response> get(String path, {Map<String, dynamic>? queryParameters});
  Future<Response> post(String path, {dynamic data});
  // Other HTTP methods...
}

class DioClient implements BaseHttpClient {
  final Dio _dio;
  final String host;
  
  DioClient(
    this._dio, {
    required this.host,
    Map<String, String>? headers,
    bool certPining = false,
    bool shouldIgnoreSSL = false,
  });
}
```

### 3. Local Storage Interface

```dart
// Using nan_mobile_common package
abstract class LocalStorage {
  Future<void> write(String key, String value);
  Future<String?> read(String key);
  Future<void> delete(String key);
  Future<void> clear();
}

class SecureStorage implements LocalStorage {
  // Implementation using flutter_secure_storage
}
```

## Best Practices

### 1. Registration Strategies

- **Singleton**: Use for shared resources (HTTP clients, storage)
- **Factory**: Use for stateless services (repositories, interactors)
- **LazySingleton**: Use for expensive objects that might not be used immediately

### 2. Named Instances

```dart
// Register multiple instances of the same type
_getIt.registerSingleton<BaseHttpClient>(
  lmsClient,
  instanceName: HttpConstants.lmsHttpClient,
);

_getIt.registerSingleton<BaseHttpClient>(
  identityClient,
  instanceName: HttpConstants.identityHttpClient,
);

// Retrieve specific instance
final lmsClient = _getIt<BaseHttpClient>(
  instanceName: HttpConstants.lmsHttpClient,
);
```

### 3. Error Handling

```dart
// Use Either for error handling
Future<Either<Failure, T>> executeOperation() async {
  try {
    final result = await dataSource.getData();
    return Right(result);
  } catch (e) {
    return Left(ServerFailure(e.toString()));
  }
}
```

### 4. Separation of Concerns

- **Data Sources**: Handle single source of data (API endpoint, database table)
- **Repositories**: Orchestrate multiple data sources and handle business rules
- **Interactors**: Contain pure business logic without external dependencies

## Step-by-Step Implementation

### Step 1: Setup Dependencies

```yaml
# pubspec.yaml
dependencies:
  get_it: ^7.6.4
  dio: ^5.3.2
  flutter_bloc: ^8.1.3
  dartz: ^0.10.1
  flutter_secure_storage: ^9.0.0
```

### Step 2: Create Base Interfaces

```dart
// Create abstract classes for repositories and data sources
// Define common failure types
// Setup base HTTP client interface
```

### Step 3: Implement Data Layer

```dart
// Create data source implementations
// Implement repository classes
// Handle data transformation between DTOs and domain models
```

### Step 4: Implement Domain Layer

```dart
// Create domain models
// Implement interactors/use cases
// Define repository interfaces
```

### Step 5: Setup Dependency Injection

```dart
// Create DI container
// Register all dependencies in correct order
// Initialize DI in main.dart
```

### Step 6: Implement Presentation Layer

```dart
// Create BLoCs that use interactors
// Inject BLoCs using MultiBlocProvider
// Build UI screens and widgets
```

### Step 7: Integration

```dart
// Wire everything together in app.dart
// Configure routing
// Handle app-level state management
```

### 5. Integration with Feature Generation

When you use `make gen-feature` to create a new feature with data flow, the script creates the interfaces and implementations. You MUST manually register these in `DI.initialize()`:

```dart
// Example: Registering a newly generated feature
_getIt.registerFactory<NewFeatureRemoteSource>(
  () => NewFeatureRemoteSourceImpl(client: _getIt<BaseHttpClient>(instanceName: HttpConstants.defaultClient)),
);
_getIt.registerFactory<NewFeatureRepository>(
  () => NewFeatureRepositoryImpl(remoteSource: _getIt<NewFeatureRemoteSource>()),
);
_getIt.registerFactory<NewFeatureInteractor>(
  () => NewFeatureInteractorImpl(repository: _getIt<NewFeatureRepository>()),
);
```

## Common Packages Used

### Core Dependencies
- `get_it`: Dependency injection container
- `dio`: HTTP client
- `flutter_bloc`: State management
- `dartz`: Functional programming (Either, Option)

### Storage & Security
- `flutter_secure_storage`: Secure local storage
- `hive`: Local database
- `shared_preferences`: Simple key-value storage

### Network & Security
- `http_certificate_pinning`: Certificate pinning
- `connectivity_plus`: Network connectivity detection

### Custom Packages
- `nan_mobile_common`: Common utilities and base classes
- `nan_mobile_ui`: Reusable UI components

This architecture ensures:
- **Testability**: Each layer can be tested independently
- **Maintainability**: Clear separation of concerns
- **Scalability**: Easy to add new features and modules
- **Flexibility**: Easy to change implementations without affecting other layers

## Usage in Other Projects

To implement this architecture in a new project:

1. Copy the base structure (`app/`, `data/`, `domain/`, `presentation/`)
2. Setup dependency injection container
3. Create your domain models and interfaces
4. Implement data sources and repositories
5. Create interactors for business logic
6. Build presentation layer with BLoCs
7. Wire everything together with DI

This approach provides a solid foundation for scalable Flutter applications following Clean Architecture principles.
