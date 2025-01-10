// lib/features/shop/screens/chat/chat_bot.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/common/widgets/chatbot/chatmessage.dart';
import 'package:t_store/features/personalization/controllers/chatbot_controller.dart';
import 'package:t_store/features/shop/models/product_model.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/features/shop/screens/product_details/product_details.dart';

class ChatBot extends StatelessWidget {
  const ChatBot({Key? key}) : super(key: key);

  @override 
  Widget build(BuildContext context) {
    final controller = Get.find<ChatBotController>();
    
    return Obx(() => Stack(
      children: [
        // Nút chat - Thêm hiệu ứng và icon đẹp hơn
        Positioned(
          right: TSizes.defaultSpace,
          bottom: TSizes.defaultSpace,
          child: FloatingActionButton(
            backgroundColor: TColors.primary,
            elevation: 5,
            child: const Icon(Icons.chat_bubble_outline, size: 28),
            onPressed: () => controller.toggleChat(),
          ),
        ),

        // Hộp thoại chat
        if(controller.isChatOpen.value)
          Positioned(
            right: TSizes.defaultSpace,
            bottom: 80,
            child: Container(
              width: 320,
              height: 500, 
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(TSizes.borderRadiusLg),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 20,
                    spreadRadius: 5,
                  )
                ]
              ),
              child: Column(
                children: [
                  // Header được làm đẹp hơn
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace, vertical: TSizes.sm),
                    decoration: BoxDecoration(
                      color: TColors.primary,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(TSizes.borderRadiusLg),
                        topRight: Radius.circular(TSizes.borderRadiusLg),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                        )
                      ]
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.support_agent, color: Colors.white, size: 24),
                            const SizedBox(width: 8),
                            const Text(
                              'Trợ lý T-Store',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16
                              ),
                            ),
                          ],
                        ),
                        IconButton(
                          icon: const Icon(Icons.close, color: Colors.white),
                          onPressed: () => controller.toggleChat(),
                        )
                      ],
                    ),
                  ),

                  // Messages với scroll behavior được cải thiện
                  Expanded(
                    child: Obx(() => ListView.builder(
                      padding: const EdgeInsets.all(TSizes.defaultSpace),
                      itemCount: controller.messages.length,
                      physics: const BouncingScrollPhysics(),
                      reverse: false, // Tin nhắn mới nhất ở dưới
                      itemBuilder: (context, index) {
                        final message = controller.messages[index];
                        return ChatMessage(message: message);
                      },
                    )),
                  ),

                  // Input được làm đẹp hơn
                  Container(
                    padding: const EdgeInsets.all(TSizes.sm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(top: BorderSide(color: Colors.grey.shade200)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, -5),
                        )
                      ]
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: controller.textController,
                            style: const TextStyle(color: Colors.black), // Text màu đen
                            decoration: InputDecoration(
                              hintText: 'Nhập câu hỏi của bạn...',
                              hintStyle: TextStyle(color: Colors.grey.shade600),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: BorderSide(color: Colors.grey.shade300),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: BorderSide(color: Colors.grey.shade300),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: const BorderSide(color: TColors.primary),
                              ),
                              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                              filled: true,
                              fillColor: Colors.grey.shade50,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: TColors.primary,
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.send_rounded, color: Colors.white),
                            onPressed: () => controller.sendMessage(),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
      ],
    ));
  }
}