import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/utils/extensions.dart';
import '../../../core/widgets/network_avatar.dart';
import '../controllers/chat_detail_controller.dart';

class ChatDetailView extends GetView<ChatDetailController> {
  const ChatDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        titleSpacing: 0,
        title: Row(
          children: [
            NetworkAvatar(seed: controller.thread.avatarSeed, radius: 18, isOnline: controller.thread.isOnline),
            const SizedBox(width: AppSizes.xs),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(controller.thread.name, style: AppTextStyles.labelLarge),
                Text(
                  controller.thread.isOnline ? 'Online' : 'Offline',
                  style: AppTextStyles.caption.copyWith(color: controller.thread.isOnline ? AppColors.online : AppColors.textHint),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(
              () => ListView.builder(
                controller: controller.scrollController,
                padding: const EdgeInsets.all(AppSizes.lg),
                itemCount: controller.messages.length,
                itemBuilder: (context, index) {
                  final message = controller.messages[index];
                  return Align(
                    alignment: message.isMe ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.only(bottom: AppSizes.sm),
                      padding: const EdgeInsets.symmetric(horizontal: AppSizes.sm, vertical: AppSizes.xs),
                      constraints: BoxConstraints(maxWidth: MediaQuery.sizeOf(context).width * 0.72),
                      decoration: BoxDecoration(
                        color: message.isMe ? AppColors.primary : AppColors.surface,
                        borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(AppSizes.radiusMd),
                          topRight: const Radius.circular(AppSizes.radiusMd),
                          bottomLeft: Radius.circular(message.isMe ? AppSizes.radiusMd : 2),
                          bottomRight: Radius.circular(message.isMe ? 2 : AppSizes.radiusMd),
                        ),
                        boxShadow: [BoxShadow(color: AppColors.shadow, blurRadius: 8, offset: const Offset(0, 3))],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            message.text,
                            style: AppTextStyles.bodyMedium.copyWith(color: message.isMe ? Colors.white : AppColors.textPrimary),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            message.time.toTime,
                            style: AppTextStyles.bodySmall.copyWith(
                              color: message.isMe ? Colors.white.withValues(alpha: 0.75) : AppColors.textHint,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(AppSizes.md, AppSizes.xs, AppSizes.md, AppSizes.xs),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: AppSizes.md),
                      decoration: BoxDecoration(color: AppColors.surfaceAlt, borderRadius: BorderRadius.circular(AppSizes.radiusPill)),
                      child: TextField(
                        controller: controller.inputController,
                        decoration: const InputDecoration(border: InputBorder.none, hintText: 'Type a message...', isDense: true),
                        textInputAction: TextInputAction.send,
                        onSubmitted: (_) => controller.send(),
                        minLines: 1,
                        maxLines: 4,
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSizes.xs),
                  GestureDetector(
                    onTap: controller.send,
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
                      child: const Icon(Icons.send_rounded, color: Colors.white, size: 18),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
