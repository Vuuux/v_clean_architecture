🏛 Architecture & Data Flow
This project implements Clean Architecture combined with BLoC (Business Logic Component) for State Management.

The core objective of this architecture is a clear Separation of Concerns, making the codebase highly maintainable, testable, and scalable. However, the project also embraces a Pragmatic mindset: balancing the strictness of Clean Architecture with development speed (e.g., allowing BLoC to handle specific ApiExceptions directly to reduce unnecessary boilerplate code).

🧩 Layer Breakdown
The system is divided into 3 main layers, communicating unidirectionally (from the outside in):

1. Presentation Layer
   Screens / UI: Listens to States from the BLoC to render the UI, show loading indicators, display error dialogs, or handle routing.

BLoC: Acts as the "Conductor". It receives Events from the user, calls Use Cases/Interactors in the Domain layer, and emits the corresponding States (Loading, Success, Failure).

2. Domain Layer (Core Business Logic)
   Interactors (Use Cases): Encapsulates the Business Logic. For example, the password encryption process (encryptWithPublicKey) is executed here before being pushed down to the Data layer.

Entities: Objects that model the core data of the application.

Repository Interfaces: Defines the contracts for data fetching/saving, keeping the Domain layer completely independent of external libraries or frameworks.

3. Data Layer
   Repository Implementations: Executes the Domain layer's interfaces. A key highlight here is that the Repository acts as the "Warehouse Keeper" — it automatically handles side-effects like saving Access/Refresh Tokens to Local Storage upon a successful API call, relieving the Domain and Presentation layers from worrying about this.

Remote Data Source: Handles HTTP Requests (APIs), OAuth (Google, Line, Apple), and JSON parsing.

Local Data Source: Manages reading/writing data to local device storage.

🔄 Practical Execution Flow (Example: Login Flow)
To easily visualize this, here is how data flows through the layers when a user performs the Login function:

Code snippet
sequenceDiagram
participant UI as LoginScreen (UI)
participant BLoC as LoginBloc
participant Domain as AuthInteractor
participant Repo as AuthRepository
participant Remote as RemoteSource / API
participant Local as LocalStorage

    UI->>BLoC: 1. Add Event: LoginStarted(user, pass)
    BLoC->>BLoC: 2. Emit State: LoginInProgress (Show Loader)
    BLoC->>Domain: 3. Call signIn(user, pass)
    
    rect rgb(240, 248, 255)
        Note over Domain: Business Logic
        Domain->>Repo: 4. Request PublicKey
        Repo-->>Domain: Return PublicKey
        Domain->>Domain: 5. Encrypt Password
    end

    Domain->>Repo: 6. Call signIn(user, encryptedPass)
    Repo->>Remote: 7. POST /v1/auth/login
    Remote-->>Repo: 8. Return AuthResult (Tokens)

    rect rgb(240, 255, 240)
        Note over Repo: Side-effect Handling
        Repo->>Local: 9. Auto-save Tokens locally
        Repo->>Repo: 10. Trigger Session update event (if any)
    end
    
    Repo-->>Domain: 11. Return AuthResult
    Domain-->>BLoC: 12. Return Success
    BLoC->>BLoC: 13. Emit State: LoginSuccess
    BLoC-->>UI: 14. Hide Loader, Navigate to Home
✨ Technical Highlights
Automated Token Management: The BLoC doesn't need to know the structure of the Access Token or how to store it. AuthRepositoryImpl automatically intercepts the API response and saves it to Local Storage (_handleUpdateAuthTokens).

Security in Domain Layer: Sensitive logic, such as fetching the Public Key from the server to encrypt the user's password, is neatly encapsulated inside AuthInteractorImpl.

Pragmatic Error Handling: Instead of creating countless States for every type of HTTP error, the BLoC directly checks the error code from the ApiException (e.g., err_login_locked) to orchestrate the UI promptly. This keeps the codebase thin and approachable.