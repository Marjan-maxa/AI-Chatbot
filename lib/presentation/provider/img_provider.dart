import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:llm_chatbot/domin/entities/image_entities.dart';

import '../../core/app_strings.dart';
import '../../data/services/img_api_service.dart';

class ImgProvider extends ChangeNotifier {
  ImgProvider({ImgApiService? imgService})
    : _imgService = imgService ?? ImgApiService();
  final ImgApiService _imgService;
  List<ImageMessage> _messages = [];
  String? _errorMessage;
  bool _isLoading = false;
  List<ImageMessage> get messages => List.unmodifiable(_messages);
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  Future<void> generateImage(String prompt) async {
    if (prompt.trim().isEmpty) return null;
    _messages.add(
      ImageMessage(role: 'user', prompt: prompt, time: DateTime.now()),
    );
    _errorMessage = null;
    _isLoading = true;
    notifyListeners();
    try {
      final imageMessage = await _imgService.generateImage(prompt);
      _messages.add(imageMessage);
    } on TimeoutException catch (e) {
      _errorMessage = AppStrings.errorTimeout;
    } on SocketException catch (e) {
      _errorMessage = AppStrings.errorNoInternet;
    } catch (e, stackTrace) {
      _errorMessage = AppStrings.errorGeneral;
      print('Stack Trace : $stackTrace');
      print('UnExpected Error : $e');
    }finally{
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearMessages() {
    _messages.clear();
    _errorMessage = null;
    notifyListeners();
  }
}
