import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:llm_chatbot/core/app_strings.dart';


import '../../domin/entities/image_entities.dart';

class ImgApiService {
  Future<ImageMessage> generateImage(String prompt) async {
    print('[ImageGen] Sending request to: ${AppStrings.imageGenBaseUrl}/chat/completions',
    );
    print('[Image] model : ${AppStrings.imageGenModel}');
    print('[Image] prompt : ${prompt.length}');
    final response = await http
        .post(
      Uri.parse('${AppStrings.imageGenBaseUrl}/chat/completions'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${AppStrings.imageGenApiKey}',
          },
          body: jsonEncode({
            'model': AppStrings.imageGenModel,
            'max_tokens': 1024,
            'messages': [
              {'role': 'user', 'content': prompt},
            ],
            'modalities': ['image', ],
          }),
        )
        .timeout(Duration(seconds: 30));
    print(['ImageGen status code : ${response.statusCode}']);
    print(['ImageGen response body: ${response.body}']);
    if (response.statusCode != 200) {
      throw Exception('Failed to get response ${response.statusCode}');
    }
    final message = jsonDecode(response.body)['choices'][0]['message'];
    final content = message['content'];
    final images = message['images'];
    if (images == null || images.isEmpty) {
      throw Exception('No images found in the response');
    }
    return ImageMessage(
      role: 'assistant',
      prompt: prompt,
      imageUrl: images[0]['image_url']['url'] as String,
      textContent: content is String && content.trim().isNotEmpty? content.trim() : null,
      time: DateTime.now(),
    );
  }
}
