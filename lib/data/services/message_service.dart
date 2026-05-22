import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:llm_chatbot/data/models/message_model.dart';
import '../../core/app_strings.dart';
import '../../core/urls/urls_model.dart';

class MessageService {
  Future<String> assistentReplay(List<MessageModel> messages) async {
    try {
      print('Sending request to : $text_url');
      print('[Chat] model : ${AppStrings.model}');
      print('[Chat] messages : ${messages.length}');

      final response = await http
          .post(
        Uri.parse(text_url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${AppStrings.apiKey}', // .env থেকে আসছে
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
          .timeout(const Duration(seconds: 60));


      print('Chat API Status Code: ${response.statusCode}');
      print('Chat API Response: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return (data['choices'][0]['message']['content']).trim();
      } else {
        throw Exception('Failed to get response ${response.statusCode}');
      }
    } catch (e) {
      print('--- MY ERROR IS: $e ---');
      rethrow;
    }
  }
}