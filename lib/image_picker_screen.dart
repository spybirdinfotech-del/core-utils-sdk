import 'dart:io';
import 'package:smartui_components/custom_widget/custom_image.dart';
import 'package:smartui_components/image_picker_service/image_picker_cubit.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ImagePickerScreen extends StatefulWidget {
  const ImagePickerScreen({super.key});

  @override
  State<ImagePickerScreen> createState() => _ImagePickerScreenState();
}

class _ImagePickerScreenState extends State<ImagePickerScreen> {
  File? selectedImage;
  File? selectedVideo;
  VideoPlayerController? videoController;

  @override
  void dispose() {
    videoController?.dispose();
    super.dispose();
  }

  Future<void> loadVideo(File file) async {
    videoController = VideoPlayerController.file(file);
    await videoController!.initialize();
    setState(() {});
    videoController!.play();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Image/Video Picker")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () async {
                final file = await ImagePickerCubit().pickImageOnGallery();

                if (file != null) {
                  setState(() {
                    selectedImage = file;
                    selectedVideo = null;
                  });
                }
              },
              child: const Text('Pick Image from Gallery'),
            ),

            ElevatedButton(
              onPressed: () async {
                final file = await ImagePickerCubit().pickImageOnCamera();

                if (file != null) {
                  setState(() {
                    selectedImage = file;
                    selectedVideo = null;
                  });
                }
              },
              child: const Text('Pick Image from Camera'),
            ),

            const SizedBox(height: 10),

            ElevatedButton(
              onPressed: () async {
                final file = await ImagePickerCubit().pickVideoOnGallery();

                if (file != null) {
                  setState(() {
                    selectedVideo = file;
                    selectedImage = null;
                  });

                  await loadVideo(file);
                }
              },
              child: const Text('Pick Video from Gallery'),
            ),

            ElevatedButton(
              onPressed: () async {
                final file = await ImagePickerCubit().pickVideoOnCamera();

                if (file != null) {
                  setState(() {
                    selectedVideo = file;
                    selectedImage = null;
                  });

                  await loadVideo(file);
                }
              },
              child: const Text('Pick Video from Camera'),
            ),

            const SizedBox(height: 10),

            /// ---------------- SELECTED IMAGE ----------------
            if (selectedImage != null)
              Padding(
                padding: const EdgeInsets.all(10),
                child: CustomImageWidget(
                  selectedImage!,
                  300,
                  300,
                ),
              ),

            /// ---------------- SELECTED VIDEO ----------------
            if (videoController != null && videoController!.value.isInitialized)
              Container(
                height: 250,
                width: double.infinity,
                margin: const EdgeInsets.all(10),
                child: VideoPlayer(videoController!),
              ),
          ],
        ),
      ),
    );
  }
}
