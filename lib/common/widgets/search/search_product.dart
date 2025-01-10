import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/features/shop/controllers/product/product_controller.dart';

class SearchProductWidgets extends StatelessWidget {
  const SearchProductWidgets({
    super.key,
    required this.textEditingController,
    required this.controller, required this.hintText,
  });

  final TextEditingController textEditingController;
  final ProductController controller;
  final String hintText;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      decoration: InputDecoration(
        hintText: hintText,
        border: const OutlineInputBorder(),
        prefixIcon: const Icon(Icons.search),
        suffixIcon: Obx(
          () => controller.truyXuatTimKiem.value.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    textEditingController.clear(); 
                    controller.truyXuatTimKiem.value =
                        ''; 
                  },
                )
              : const SizedBox.shrink(),
        ),
      ),
      onChanged: (value) {
        controller.truyXuatTimKiem.value = value;
      },
    );
  }
}