import 'dart:convert';

import 'package:llm_chatbot/data/models/message_model.dart';
import 'package:http/http.dart' as http;

import '../../core/app_strings.dart';
import '../../core/urls/urls_model.dart';

class MessageService {
  Future<String> assistentReplay(List<MessageModel> messages) async {
    print('Sending request to : $text_url');
    print('[Chat] model : ${AppStrings.model}');
    print('[Chat] messages : ${messages.length}');
    final response = await http
        .post(
          Uri.parse(text_url),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${AppStrings.apiKey}',
          },
          body: jsonEncode({
            'model': AppStrings.model,
            'max_tokens': 1024,
            'messages': [
              {'role': 'system', 'content': AppStrings.systemPrompt},
              ...messages.map((message) => message.toApiMap()),
            ],
          }),
        )
        .timeout(Duration(seconds: 30));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return (data['choices'][0]['message']['content']).trim();
    } else {
      throw Exception('Failed to get response ${response.statusCode}');
    }
  }
}
