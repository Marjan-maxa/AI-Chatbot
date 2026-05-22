


import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppStrings {
  static const String appName = 'AI Chat Bot';
  static const String inputHint = 'Type a message...';
  static const String imageGenInputHint = 'Describe an image...';
  static const String emptyChat =
      'Start a conversation!\nSend a message below.';

  static const String errorNoInternet =
      'No internet connection. Please check and try again.';
  static const String errorTimeout = 'Request timed out. Please try again.';
  static const String errorGeneral = 'Something went wrong. Please try again.';

  // Chat API
  static  String apiKey = dotenv.env['API_KEY'] ?? '';


  static const String model = 'nvidia/nemotron-3-super-120b-a12b:free';
  static const String systemPrompt =
      'You are a helpful and friendly AI assistant.';

  // Image Generation API
  static  String get imageGenApiKey =>dotenv.env['API_KEY'] ?? '';
  static const String imageGenBaseUrl = 'https://openrouter.ai/api/v1';

  static const String imageGenModel = 'sourceful/riverflow-v2-standard-preview';
}