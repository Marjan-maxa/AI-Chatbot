import 'package:flutter/material.dart';
import '../../data/models/message_model.dart';

class MessageBubble extends StatelessWidget {
  final MessageModel message;

  const MessageBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    bool isUser = message.role == 'user';
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: Row(
        mainAxisAlignment:
            isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isUser) ...[
            CircleAvatar(
              radius: 16,
              backgroundColor: Colors.deepPurple.withOpacity(0.8),
              child: const Icon(Icons.auto_awesome, color: Colors.white, size: 16),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                gradient: isUser
                    ? const LinearGradient(
                        colors: [Color(0xFF8B5CF6), Color(0xFF6D28D9)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      )
                    : LinearGradient(
                        colors: [Colors.grey[900]!, Colors.grey[850]!],
                      ),
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(20),
                  topRight: const Radius.circular(20),
                  bottomLeft: isUser ? const Radius.circular(20) : Radius.zero,
                  bottomRight: isUser ? Radius.zero : const Radius.circular(20),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment:
                    isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    message.text,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.3,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    _formatTime(message.time),
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (isUser) const SizedBox(width: 32), // Padding for alignment
        ],
      ),
    );
  }

  String _formatTime(DateTime time) {
    int hour = time.hour;
    String amPm = hour >= 12 ? 'PM' : 'AM';
    hour = hour % 12;
    hour = hour == 0 ? 12 : hour;
    String minute = time.minute.toString().padLeft(2, '0');
    return "$hour:$minute $amPm";
  }
}
