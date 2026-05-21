import '../../domin/entities/message_entity.dart';

class MessageModel extends MessageEntity {
  MessageModel({required super.role, required super.text, required super.time});

  Map<String, String> toApiMap() {
    return {
      'role': role,
      'content': text,
    };
  }
}
