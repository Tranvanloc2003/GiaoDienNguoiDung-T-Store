// lib/features/shop/controllers/chat/chat_bot_controller.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/data/repositories/product/product_repository.dart';
import 'package:t_store/features/personalization/models/message_model.dart';
import 'package:t_store/features/shop/models/product_model.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class ChatBotController extends GetxController {
  static ChatBotController get instance => Get.find<ChatBotController>();
  
  // Đảm bảo chỉ có một instance
  static final ChatBotController _instance = ChatBotController._internal();
  factory ChatBotController() => _instance;
  ChatBotController._internal();

  final isChatOpen = false.obs;
  final messages = <ChatMessageModel>[].obs;
  final textController = TextEditingController();
  final productRepository = ProductRepository.instance;

  final model = GenerativeModel(
    model: 'gemini-pro',
    apiKey: 'AIzaSyAKGiKXBu-_Kd9E7VPzjT0J-E5KoCFBvw4', // Thay bằng API key của bạn
  );
  
  // Sửa lại phần khởi tạo ChatSession
  ChatSession? chat;
  
  @override
  void onInit() {
    super.onInit();
    // Khởi tạo chat session khi controller được init
    startNewChat();
  }

  void startNewChat() {
    chat = model.startChat(
      history: [
        Content.text('Xin chào, tôi là trợ lý bán hàng. Tôi có thể giúp gì cho bạn?'),
      ],
    );
  }

  void toggleChat() {
    isChatOpen.value = !isChatOpen.value;
    update(); // Thêm update để đảm bảo UI cập nhật
  }

  Future<void> sendMessage() async {
    if (textController.text.trim().isEmpty) return;

    final userMessage = textController.text;
    messages.add(ChatMessageModel(
      text: userMessage,
      isUser: true,
    ));

    textController.clear();

    try {
      // Tìm kiếm sản phẩm
      final products = await searchProducts(userMessage);
      
      // Tạo prompt với thông tin về sản phẩm
      final prompt = '''
      Trả lời với vai trò là trợ lý bán hàng. Câu hỏi: $userMessage
      ${products.isNotEmpty ? 'Có các sản phẩm liên quan: ${products.map((p) => p.tenSanPham).join(", ")}' : 'Không tìm thấy sản phẩm liên quan trực tiếp.'}
      ''';

      // Sử dụng chat session để duy trì cuộc hội thoại
      final response = await chat?.sendMessage(Content.text(prompt));
      final botResponse = response?.text ?? 'Xin lỗi, tôi không thể xử lý yêu cầu này.';

      messages.add(ChatMessageModel(
        text: botResponse,
        isUser: false,
        products: products.isNotEmpty ? products : null,
      ));

    } catch (e) {
      messages.add(ChatMessageModel(
        text: 'Xin lỗi, đã có lỗi xảy ra khi xử lý câu hỏi của bạn.',
        isUser: false,
      ));
      print('Error: $e');
    }
  }

  Future<List<SanPhamModel>> searchProducts(String query) async {
    try {
      // Tối ưu tìm kiếm bằng cách tách từ khóa và tìm kiếm linh hoạt hơn
      final keywords = query.toLowerCase().split(' ');
      
      final querySnapshot = await FirebaseFirestore.instance
          .collection('SanPham')
          .get();

      return querySnapshot.docs
          .map((doc) => SanPhamModel.fromSnapshot(doc))
          .where((product) {
            final productName = product.tenSanPham.toLowerCase();
            return keywords.any((keyword) => productName.contains(keyword));
          })
          .toList();
    } catch (e) {
      print('Error searching products: $e');
      return [];
    }
  }

  @override
  void onClose() {
    textController.dispose();
    super.onClose();
  }
}