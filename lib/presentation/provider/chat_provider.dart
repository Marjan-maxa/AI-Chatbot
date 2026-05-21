import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';

import '../../core/app_strings.dart';
import '../../data/models/message_model.dart';
import '../../data/services/message_service.dart';

class ChatProvider extends ChangeNotifier {
  ChatProvider({MessageService? messageService})
    : _messageService = messageService ?? MessageService();
  final MessageService _messageService;
  final List<MessageModel> _messages = [];
  List<MessageModel> get messages => _messages;
  String? _errorMessage;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  Future<void> sendMessage(String text) async {
    if (text.isEmpty) return null;
    _messages.add(MessageModel(role: 'user', text: text, time: DateTime.now()));
    _errorMessage = null;
    _isLoading = true;
    notifyListeners();
    try {
      final response = await _messageService.assistentReplay(_messages);
      _messages.add(
        MessageModel(role: 'assistant', text: response, time: DateTime.now()),
      );
      _isLoading = false;
      notifyListeners();
    } on TimeoutException catch (e) {
      _errorMessage = AppStrings.errorTimeout;
    } on SocketException catch (e) {
      _errorMessage = AppStrings.errorNoInternet;
    } catch (e) {
      _errorMessage = AppStrings.errorGeneral;
    } finally {
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
