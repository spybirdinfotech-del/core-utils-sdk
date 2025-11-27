import 'package:flutter/material.dart';
import 'package:smartui_components/remote/util/common.dart';

class ShimmerScreen extends StatelessWidget {
  const ShimmerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Common().commonShimmer(
          child: Container(
            height: 100,
            width: 100,
            color: Colors.black38,
          ),
        ),
      ),
    );
  }
}
