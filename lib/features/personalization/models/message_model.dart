// lib/features/shop/models/chat_message.dart

import 'package:t_store/features/shop/models/product_model.dart';

class ChatMessageModel {
  final String text;
  final bool isUser;
  final List<SanPhamModel>? products;

  ChatMessageModel({
    required this.text,
    required this.isUser,
    this.products,
  });
}