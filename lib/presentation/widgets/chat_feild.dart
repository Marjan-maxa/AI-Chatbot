import 'package:flutter/material.dart';

class ChatFeild extends StatefulWidget {
  const ChatFeild({
    super.key,
    this.onSubmitted,
    required this.isLoading,
    this.hinttext,
    this.sendIcon,
  });

  final void Function(String)? onSubmitted;
  final bool isLoading;
  final String? hinttext;
  final IconData? sendIcon;

  @override
  State<ChatFeild> createState() => _ChatFeildState();
}

class _ChatFeildState extends State<ChatFeild> {
  // ইউজারের টেক্সট ইনপুট কন্ট্রোল করার জন্য
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleSubmitted() {
    final text = _controller.text.trim();
    if (text.isNotEmpty && !widget.isLoading) {
      widget.onSubmitted?.call(text); // প্রোভাইডারের কাছে ডাটা পাঠানো
      _controller.clear(); // মেসেজ সেন্ড হওয়ার পর ফিল্ড খালি করা
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: TextField(
        controller: _controller,
        enabled: !widget.isLoading, // লোডিং অবস্থায় টেক্সট ফিল্ড ডিসেবল থাকবে
        textInputAction: TextInputAction.send,
        onSubmitted: (_) => _handleSubmitted(), // কীবোর্ডের সেন্ড বাটনে চাপলে কাজ করবে
        decoration: InputDecoration(
          hintText: widget.hinttext ?? 'Type a message...',
          hintStyle: const TextStyle(color: Colors.grey),
          filled: true,
          fillColor: Colors.grey[200], // স্ক্রিনশটের মতো হালকা ধূসর ব্যাকগ্রাউন্ড
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30), // চারপাশ গোল করার জন্য
            borderSide: BorderSide.none, // কোনো বর্ডার লাইন থাকবে না
          ),


          suffixIcon: Padding(
            padding: const EdgeInsets.all(4.0),
            child: CircleAvatar(
              backgroundColor: widget.isLoading ? Colors.grey : const Color(0xFF7C3AED), // লোডিং হলে কালার গ্রে হয়ে যাবে
              child: widget.isLoading
                  ? const Padding(
                padding: EdgeInsets.all(10.0),
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2.5,
                ),
              )
                  : IconButton(
                icon: Icon(widget.sendIcon ?? Icons.send, color: Colors.white, size: 20),
                onPressed: _handleSubmitted,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// 1:20 minute after start