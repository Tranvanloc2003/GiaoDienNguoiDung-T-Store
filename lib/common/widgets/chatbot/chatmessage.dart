// lib/features/shop/screens/chat/widgets/chat_message.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/features/personalization/models/message_model.dart';
import 'package:t_store/common/widgets/products/product_cards/product_cards_vertical.dart'; // Thêm import
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';

class ChatMessage extends StatelessWidget {
  final ChatMessageModel message;

  const ChatMessage({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: message.isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          // Message bubble
          Row(
            mainAxisAlignment: message.isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              if (!message.isUser) 
                Container(
                  margin: const EdgeInsets.only(right: 8),
                  child: const CircleAvatar(
                    backgroundColor: TColors.primary,
                    radius: 15,
                    child: Icon(Icons.support_agent, color: Colors.white, size: 18),
                  ),
                ),
              Flexible(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: message.isUser ? TColors.primary : Colors.grey.shade100,
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(16),
                      topRight: const Radius.circular(16),
                      bottomLeft: Radius.circular(message.isUser ? 16 : 4),
                      bottomRight: Radius.circular(message.isUser ? 4 : 16),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      )
                    ]
                  ),
                  child: Text(
                    message.text,
                    style: TextStyle(
                      color: message.isUser ? Colors.white : Colors.black87,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Product list
          if (message.products != null && message.products!.isNotEmpty)
            Container(
              height: 220, // Điều chỉnh chiều cao để phù hợp với TProductCardVertical
              margin: const EdgeInsets.only(top: 12),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: message.products!.length,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(vertical: TSizes.sm),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: TSizes.sm),
                    child: Expanded(
                      child: SizedBox(
                        width: 160, // Điều chỉnh chiều rộng phù hợp
                        height: 350, // Điều chỉnh chiều cao phù hợp
                        child: TProductCardVertical(product: message.products![index]),
                      ),
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}