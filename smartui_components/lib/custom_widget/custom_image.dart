import 'dart:io';
import 'dart:typed_data';

import 'package:smartui_components/remote/api/api_constant.dart';
import 'package:smartui_components/remote/util/assets_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomImageWidget extends StatelessWidget {
  final dynamic imagePath;
  final double width;
  final double? height;
  final Color? color;
  final BoxFit? boxFit;
  final File? file;
  final String? packageName;

  const CustomImageWidget(this.imagePath, this.width, this.height,
      {this.color, this.file, this.boxFit = BoxFit.fill,this.packageName, super.key});

  @override
  Widget build(BuildContext context) {

    if (imagePath == null || imagePath.toString().isEmpty) {
      return Image.asset(
        AssetsIcons.imgNoAvailable,
        width: width,
        height: height,
        fit: BoxFit.fill,
        // package: packageName,
      );
    }
    if (imagePath is File) {
      return Image.file(
        imagePath,
        width: width,
        height: height,
        fit:  boxFit ?? BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => Image.asset(
          AssetsIcons.imgNoAvailable,
          width: width,
          height: height,
          fit: BoxFit.fill,
          // package: packageName,
        ),
      );
    } else if (imagePath is Uint8List) {
      return Image.memory(
        imagePath,
        width: width,
        height: height,
        fit:  boxFit ?? BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => Image.asset(
          AssetsIcons.imgNoAvailable,
          width: width,
          height: height,
          fit: BoxFit.fill,
          // package: packageName,
        ),
      );
    } else if (imagePath is String) {
      if (imagePath.contains("svg")) {
        if (imagePath.contains("http")) {
          return SvgPicture.network(
            imagePath,
            width: width,
            height: height,
            fit:  boxFit ?? BoxFit.fill,
            colorFilter: color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
            errorBuilder: (context, error, stackTrace) {
              return Image.asset(
                AssetsIcons.imgNoAvailable,
                width: width,
                height: height,
                fit: BoxFit.fill,
                // package: packageName,
              );
            },
            placeholderBuilder: (context) {
              return Image.asset(
                AssetsIcons.imgNoAvailable,
                width: width,
                height: height,
                fit: BoxFit.fill,
                // package: packageName,
              );
            },
          );
        } else {
          return SvgPicture.asset(
            imagePath,
            width: width,
            height: height,
            fit: boxFit ?? BoxFit.fill,
            // package: packageName,
            colorFilter: color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
            errorBuilder: (context, error, stackTrace) {
              return Image.asset(
                AssetsIcons.imgNoAvailable,
                width: width,
                height: height,
                fit: BoxFit.fill,
                // package: packageName,
              );
            },
            placeholderBuilder: (context) {
              return Image.asset(
                AssetsIcons.imgNoAvailable,
                width: width,
                height: height,
                fit: BoxFit.fill,
                // package: packageName,
              );
            },
          );
        }
      } else {
        if (imagePath.contains("http")) {
          return Image.network(
            imagePath,
            width: width,
            height: height,
            fit: boxFit ?? BoxFit.fill,
            color: color,
            loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
              if (loadingProgress == null) {
                return child;
              }
              return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                        : null,
                  ));
            },
            errorBuilder: (context, error, stackTrace) => Image.asset(
              AssetsIcons.imgNoAvailable,
              width: width,
              height: height,
              fit: BoxFit.fill,
              // package: packageName,
            ),
          );
        } else {
          return Image.asset(
            imagePath,
            width: width,
            height: height,
            fit: boxFit,
            color: color,
            // package: packageName,
            alignment: FractionalOffset.center,
            errorBuilder: (context, error, stackTrace) => Image.asset(
              AssetsIcons.imgNoAvailable,
              width: width,
              height: height,
              fit: BoxFit.fill,
              // package: packageName,
            ),
          );
        }
      }
    } else {
      return const CircularProgressIndicator();
    }
  }
}
