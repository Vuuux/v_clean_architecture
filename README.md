# v_clean_architecture

A Flutter project implementing Clean Architecture with a modular structure and BLoC for state management.

## Project Architecture

This project follows Clean Architecture principles, separating the application into three main layers:
1. **Data Layer**: Repositories implementations and Data Sources.
2. **Domain Layer**: Entities, Repository Interfaces, and Interactors (Use Cases).
3. **Presentation Layer**: BLoCs and UI Features.

For a detailed breakdown of the structure, see [CLEAN_ARCHITECTURE_TEMPLATE.md](./CLEAN_ARCHITECTURE_TEMPLATE.md).

## Dependency Injection
We use `get_it` for Dependency Injection. For more details on how to register and use dependencies, refer to the [DEPENDENCY_INJECTION_GUIDE.md](./DEPENDENCY_INJECTION_GUIDE.md).

## Getting Started

### Prerequisites
- Flutter SDK: v3.44.4 or above
- Dart SDK: v3.12.2 or above
- Ruby (for fastlane if applicable)
- Make (optional, but recommended for using shortcuts)

### Installation
Fetch dependencies for the main project and all local packages:
```bash
make pub-get
```

## Running the App

The project uses environment-specific configurations via `--dart-define-from-file`.

### Development (SIT)
```bash
# Using make
make dev

# Or using flutter command directly
flutter run --dart-define-from-file=env/sit.json --flavor sit
```

### UAT
```bash
make dev-uat
```

### Production
```bash
make dev-prd
```

## Development Tools

### Generating a New Feature
The project includes a script to scaffold a new feature following Clean Architecture.
```bash
make gen-feature
```

### Managing Assets
We use a custom script to manage and synchronize assets.

1. **Add assets** to `assets/` folder.
2. **Declare** them in `pubspec.yaml`.
3. **Generate constants** in `lib/constants/assets.dart`:
   ```bash
   make gen-assets
   ```
4. **Check for unused assets**:
   ```bash
   make check-assets
   ```

### Code Generation
For parts of the app using code generation (like `json_serializable` or `freezed`):
```bash
make gen
```

## App Flow & Screenshots

### Application Screenshots & Demo
To save space, you can scroll horizontally to view all screens.

| Demo & Screenshots | | | | | |
| :---: | :---: | :---: | :---: | :---: | :---: |
| <img src="https://github.com/user-attachments/assets/55155908-fd23-44b2-8c17-5ee602126143" width="280" /> | <img src="https://github.com/user-attachments/assets/3041783a-7090-48dd-99f1-572148236bb7" width="280" /> | <img src="https://github.com/user-attachments/assets/15369980-1669-46f7-a3bc-2edb85a514de" width="280" /> | <img src="https://github.com/user-attachments/assets/28f2ada9-6a77-467d-b247-e825d85b2b3e" width="280" /> | <img src="https://github.com/user-attachments/assets/2027cfa0-e761-4e33-9d6c-82c963c1ad3e" width="280" /> | <img src="https://github.com/user-attachments/assets/d05d533b-5b4e-4b96-a6f0-f6b56d06ac39" width="280" /> |
| App Demo | Splash | Home | Explore | Activity | Settings |

### Navigation Flow
```mermaid
graph LR
    Splash[Splash] -->|Auto Login Check| Login[Login]
    Login -->|Success| Main[Main Tab Scaffold]
    
    subgraph Main_Tabs [Main Navigation]
        Main --> Home[Home]
        Main --> Explore[Explore]
        Main --> Activity[Activity]
        Main --> Settings[Settings]
    end
    
    Settings --> Profile[Profile Details]
    Home --> Detail[Feature Details]
```

## Architecture Overview

```mermaid
graph TD
    subgraph Presentation_Layer [Presentation Layer]
        Page[Feature Page] --> Bloc[BLoC]
        Bloc --> Screen[Feature Screen]
    end

    subgraph Domain_Layer [Domain Layer]
        Bloc --> Interactor[Interactor / Use Case]
        Interactor --> Entity[Entities]
        Interactor --> RepoInterface[Repository Interface]
    end

    subgraph Data_Layer [Data Layer]
        RepoImpl[Repository Implementation] -- implements --> RepoInterface
        RepoImpl --> RemoteSource[Remote Data Source]
        RepoImpl --> LocalSource[Local Data Source]
    end

    subgraph Core_UI_Packages [Core & UI Packages]
        AppUI[packages/app_ui] -.-> Presentation_Layer
        AppCore[packages/app_core] -.-> Data_Layer
    end

    RemoteSource --> API[External API / Dio]
    LocalSource --> Storage[Secure Storage / DB]
```

---
