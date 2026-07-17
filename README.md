# v_clean_architecture

A Flutter project implementing Clean Architecture with a modular structure and BLoC for state management.

## Project Architecture

This project follows Clean Architecture principles, separating the application into three main layers:
1. **Data Layer**: Repositories implementations and Data Sources.
2. **Domain Layer**: Entities, Repository Interfaces, and Interactors (Use Cases).
3. **Presentation Layer**: BLoCs and UI Features.

For a detailed breakdown of the structure, see [CLEAN_ARCHITECTURE_TEMPLATE.md](./CLEAN_ARCHITECTURE_TEMPLATE.md).

## Getting Started

### Prerequisites
- Flutter SDK (latest stable version)
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
This will prompt for a feature name and create the necessary BLoC, Page, Screen, Interactor, and Repository files.

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

## App Flow & Architecture Diagrams

### Application Flow
![App Flow]

<img width="540" height="1200" alt="video (1)" src="https://github.com/user-attachments/assets/55155908-fd23-44b2-8c17-5ee602126143" />
<img width="540" height="1200" alt="Screenshot_20260718_002922" src="https://github.com/user-attachments/assets/3041783a-7090-48dd-99f1-572148236bb7" />
<img width="540" height="1200" alt="Screenshot_20260718_002852" src="https://github.com/user-attachments/assets/15369980-1669-46f7-a3bc-2edb85a514de" />
<img width="540" height="1200" alt="Screenshot_20260718_002902" src="https://github.com/user-attachments/assets/28f2ada9-6a77-467d-b247-e825d85b2b3e" />
<img width="540" height="1200" alt="Screenshot_20260718_002909" src="https://github.com/user-attachments/assets/2027cfa0-e761-4e33-9d6c-82c963c1ad3e" />
<img width="540" height="1200" alt="Screenshot_20260718_002914" src="https://github.com/user-attachments/assets/d05d533b-5b4e-4b96-a6f0-f6b56d06ac39" />


### Architecture Overview
<!-- Replace the placeholder below with your architecture diagram -->
![Architecture Diagram]

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

### Architecture Overview

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

## Dependency Injection
We use `get_it` for Dependency Injection. For more details on how to register and use dependencies, refer to the [DEPENDENCY_INJECTION_GUIDE.md](./DEPENDENCY_INJECTION_GUIDE.md).
