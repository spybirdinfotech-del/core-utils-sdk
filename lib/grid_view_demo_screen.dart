import 'package:smartui_components/grid_view_handler/custom_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:smartui_components/grid_view_handler/grid_type.dart';

class GridViewDemoScreen extends StatelessWidget {
  const GridViewDemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Grid View Demo")),
      /* body: GridViewHandler(
        type: GridType.simple,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 3,
          mainAxisSpacing: 3,
        ),
        children: List.generate(20, (index) {
          return Container(color: Colors.red.shade100,child: Center(child: Text('${index}')));
        },),
      ),*/
      /* body: GridViewHandler(
        type: GridType.count,
        crossAxisCount: 2,
        crossAxisSpacing: 4,
        mainAxisSpacing: 4,
        children: List.generate(20, (index) {
          return Container(color: Colors.red.shade100,child: Center(child: Text('${index}')));
        },),
      ),*/
      /* body: GridViewHandler(
        type: GridType.extent,
        crossAxisCount: 2,
        crossAxisSpacing: 4,
        mainAxisSpacing: 4,
        maxCrossAxisExtent: 100,
        children: List.generate(20, (index) {
          return Container(color: Colors.red.shade100,child: Center(child: Text('${index}')));
        },),
      ),*/
      body: GridViewHandler(
        type: GridType.custom,
        data: List.generate(20, (i) => i),
        itemBuilder: (context, index) => Container(
          color: Colors.red.shade100,
          child: Center(child: Text('$index')),
        ),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 4,
          mainAxisSpacing: 4,
        ),
      ),
      /*body: GridViewHandler(
        type: GridType.builder,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        data: List.generate(20, (i) => i),
        itemBuilder: (context, index) {
          return Card(
            child: Center(child: Text("Item $index")),
          );
        },
      ),*/
    );
  }
}
