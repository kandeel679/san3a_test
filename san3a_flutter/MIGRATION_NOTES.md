# San3a Flutter Migration Notes

## Architecture Mapping (Kotlin -> Flutter)
- **State Management:** The Kotlin app uses Jetpack Compose with ViewModels holding state. As per the strict requirements, we have migrated to using `StatefulWidget` for local state and plain `ChangeNotifier` passed via `InheritedWidget` for global state (e.g., Auth, Role). No state management libraries (BLoC, Riverpod, Provider) were used.
- **Data Layer:** The Kotlin `data/source/remote` and `data/repository` classes were mapped cleanly to Flutter's `data/sources` and `data/repositories` respectively.
- **Routing:** Kotlin's Navigation Compose (`NavGraph.kt`, `Destinations.kt`) was migrated to `go_router` in `app_router.dart`, maintaining the role-based navigation flows (Customer, Craftsman, Main).
- **Backend:** Firebase Firestore structure was mirrored exactly (`users`, `service_requests`, `offers`, `services`, etc.).

## AI Features Discrepancy
- The prompt mandated migrating the "Core AI features (already built in Kotlin)": AI Chatbot, Price Recommendation, and AI Negotiation.
- **Finding:** A deep analysis of the Kotlin codebase revealed that **these features were never implemented in the Kotlin code**. The only remote API call was for sending WhatsApp OTPs.
- **Action Taken:** In order to fulfill the "HARD CONSTRAINTS" to migrate all requested features, placeholder API clients and mock UI screens were created for these features in the Flutter app to represent how they would integrate with the supposed Python backend. 

## Kotlin-Specific Patterns
- Kotlin `sealed classes` for states (e.g., `CustomerUIState`) were mapped to standard Dart classes or basic `enum` states inside `StatefulWidget` variables.
- Coroutines (`Flow`) for streaming Firestore data were migrated to Dart `Stream` from the `cloud_firestore` package.

## API Contracts / Endpoints
- **OTP API:** `https://www.whatsapp.api.funtaste.xyz/api/send-message` (Migrated exactly as found in Kotlin `AuthApiServices`).
- **AI Endpoints (Placeholder):**
  - POST `/api/ai/chat`
  - POST `/api/ai/price-recommendation`
  - POST `/api/ai/negotiation`

## Manual Attention Required Post-Migration
1. **Firebase Configuration:** The `google-services.json` and `GoogleService-Info.plist` files need to be added to the respective Android and iOS directories. `Firebase.initializeApp()` requires proper platform options.
2. **Google Maps API Key:** A valid Google Maps API key must be inserted into the `AndroidManifest.xml` and `AppDelegate.swift` for the tracking features to work.
3. **AI Backend:** The Python backend needs to be deployed, and the base URL must be updated in `api_client.dart` for the AI features to actually function.
4. **Payment Gateway:** The Kotlin codebase did not have a clear payment gateway dependency or implementation (only a generic reference in requirements). A placeholder implementation was added to `PaymentScreen` and `PaymentRepository`.
