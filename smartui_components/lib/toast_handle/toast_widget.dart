import 'package:flutter/material.dart';
import 'toast_state.dart';

class ToastWidget extends StatelessWidget {
  final ToastState data;

  const ToastWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: data.alignment,
      child: Container(
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: data.backgroundColor ?? Colors.black87,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (data.title != null)
              Text(
                data.title!,
                style: data.titleStyle ??
                    const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
              ),
            if (data.message != null)
              Text(
                data.message!,
                style: data.messageStyle ??
                    const TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
              ),
          ],
        ),
      ),
    );
  }
}
