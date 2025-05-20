/*import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textController = TextEditingController();
  final List<String> _messages = []; // Danh sách các tin nhắn

  // Hàm này sẽ được gọi khi người dùng gửi tin nhắn
  void _handleSubmitted(String text) {
    _textController.clear();
    setState(() {
      _messages.insert(0, "User: $text"); // Thêm tin nhắn của người dùng vào đầu danh sách
    });
    // TODO: Gửi tin nhắn đến API AI và nhận phản hồi
    _getAIResponse(text);
  }

  // Hàm này sẽ gọi API AI (cần cài đặt thêm logic)
  void _getAIResponse(String userMessage) async {
    // Đây là nơi bạn sẽ gọi API AI của dịch vụ bạn chọn
    // Ví dụ sử dụng một phản hồi giả định:
    await Future.delayed(const Duration(seconds: 1)); // Giả lập thời gian phản hồi của AI
    String aiResponse = "AI: Đây là phản hồi từ AI cho tin nhắn của bạn: '$userMessage'"; // Thay bằng phản hồi thực tế từ API

    setState(() {
      _messages.insert(0, aiResponse); // Thêm phản hồi của AI vào đầu danh sách
    });
  }

  Widget _buildTextComposer() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          Flexible(
            child: TextField(
              controller: _textController,
              onSubmitted: _handleSubmitted,
              decoration: const InputDecoration.collapsed(
                hintText: 'Nhập tin nhắn...',
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: () => _handleSubmitted(_textController.text),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trò chuyện với AI'),
      ),
      body: Column(
        children: [
          Flexible(
            child: ListView.builder(
              padding: const EdgeInsets.all(8.0),
              reverse: true, // Hiển thị tin nhắn mới nhất ở dưới cùng
              itemCount: _messages.length,
              itemBuilder: (_, int index) => _buildMessage(_messages[index]),
            ),
          ),
          const Divider(height: 1.0),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
            ),
            child: _buildTextComposer(),
          ),
        ],
      ),
    );
  }

  Widget _buildMessage(String message) {
    // Bạn có thể tùy chỉnh hiển thị tin nhắn của người dùng và AI ở đây
    bool isUserMessage = message.startsWith("User:");
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: isUserMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          CircleAvatar(
            child: Text(isUserMessage ? 'Me' : 'AI'),
          ),
          const SizedBox(width: 8.0),
          Column(
            crossAxisAlignment: isUserMessage ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Text(
                isUserMessage ? 'Bạn' : 'AI',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Container(
                margin: const EdgeInsets.only(top: 5.0),
                child: Text(message.replaceFirst(isUserMessage ? "User:" : "AI:", "").trim()),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}*/