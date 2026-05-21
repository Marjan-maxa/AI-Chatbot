# Provider Creation Guidelines

To maintain consistency in the LLM Chatbot project, follow these rules and patterns when creating a new Provider.

## 1. Class Structure
- All providers must extend `ChangeNotifier` from `package:flutter/material.dart` or `package:flutter/foundation.dart`.
- The class name should follow the feature name + `Provider` suffix (e.g., `ChatProvider`).

## 2. State Variables
Always include the following private state variables with their respective public getters:
- **Loading State**: `bool _inProgress = false;` (e.g., `bool _getMessagesProgress = false;`)
- **Error Message**: `String? _errorMessage;`
- **Data Model**: The specific model or list of models (e.g., `List<MessageModel> _messages = [];`).

## 3. Service Interaction
- Import service classes from `lib/data/services/`.
- Use injected service instances to perform operations.
- Endpoints must be retrieved from the `Urls` constants in `lib/core/urls/urls_model.dart`.

## 4. Method Implementation Pattern
Every data-fetching method should follow this structure:
1. **Initialize Success Flag**: `bool isSuccess = false;`
2. **Set Loading State**: Set the progress boolean to `true` and call `notifyListeners()`.
3. **Service Call**: Perform the operation (e.g., `await _messageService.assistentReplay(...)`).
4. **Handle Response**:
    - **If Success**:
        - Update the data model with the returned data.
        - Clear any existing error message.
        - Set `isSuccess = true`.
    - **If Failure**:
        - Catch exceptions and set the `_errorMessage` (e.g., from `AppStrings`).
5. **Finalize**: Set the progress boolean to `false`, call `notifyListeners()`, and return `isSuccess`.

## 5. Example Template
```dart
class FeatureProvider extends ChangeNotifier {
  FeatureProvider({FeatureService? featureService})
    : _featureService = featureService ?? FeatureService();

  final FeatureService _featureService;

  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  FeatureModel? _data;
  FeatureModel? get data => _data;

  Future<bool> getFeatureData() async {
    bool isSuccess = false;
    _inProgress = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final result = await _featureService.fetchData();
      _data = result;
      _errorMessage = null;
      isSuccess = true;
    } catch (e) {
      _errorMessage = "An error occurred";
    } finally {
      _inProgress = false;
      notifyListeners();
    }
    return isSuccess;
  }
}
```

## 6. Directory Structure
Place providers in their respective presentation folders:
`lib/presentation/provider/`
