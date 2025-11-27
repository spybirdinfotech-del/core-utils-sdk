import 'package:smartui_components/grid_view_handler/grid_type.dart';
import 'package:smartui_components/grid_view_handler/grid_view_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'grid_view_cubit.dart';
import 'package:flutter/gestures.dart';

class GridViewHandler extends StatelessWidget {
  final GridType type;
  final List<dynamic>? data;
  final List<Widget>? children;
  final IndexedWidgetBuilder? itemBuilder;
  final SliverGridDelegate? gridDelegate;
  final int? crossAxisCount;
  final double? maxCrossAxisExtent;
  final bool shrinkWrap;
  final EdgeInsetsGeometry? padding;
  final Axis scrollDirection;
  final bool reverse;
  final ScrollController? controller;
  final bool? primary;
  final ScrollPhysics? physics;
  final double? cacheExtent;
  final int? semanticChildCount;
  final DragStartBehavior dragStartBehavior;
  final Clip clipBehavior;
  final ScrollViewKeyboardDismissBehavior? keyboardDismissBehavior;
  final String? restorationId;
  final double? mainAxisSpacing;
  final double? crossAxisSpacing;

  const GridViewHandler({
    super.key,
    required this.type,
    this.data,
    this.children,
    this.itemBuilder,
    this.gridDelegate,
    this.crossAxisCount,
    this.maxCrossAxisExtent,
    this.shrinkWrap = false,
    this.padding,
    this.scrollDirection = Axis.vertical,
    this.reverse = false,
    this.controller,
    this.primary,
    this.physics,
    this.cacheExtent,
    this.semanticChildCount,
    this.dragStartBehavior = DragStartBehavior.start,
    this.clipBehavior = Clip.hardEdge,
    this.keyboardDismissBehavior,
    this.restorationId,
    this.mainAxisSpacing,
    this.crossAxisSpacing,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final cubit = GridViewCubit();
        if (data != null) cubit.loadItems(data!);
        return cubit;
      },
      child: BlocBuilder<GridViewCubit, GridViewState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.error != null) {
            return Center(child: Text("Error: ${state.error}"));
          }

          final items = state.items;

          switch (type) {
            // SIMPLE GRID
            case GridType.simple:
              return GridView(
                padding: padding,
                controller: controller,
                physics: physics,
                primary: primary,
                reverse: reverse,
                scrollDirection: scrollDirection,
                shrinkWrap: shrinkWrap,
                gridDelegate: gridDelegate!,
                children: children!,
              );

            // BUILDER
            case GridType.builder:
              return GridView.builder(
                padding: padding,
                controller: controller,
                physics: physics,
                primary: primary,
                reverse: reverse,
                scrollDirection: scrollDirection,
                shrinkWrap: shrinkWrap,
                gridDelegate: gridDelegate!,
                itemCount: items.length,
                itemBuilder: itemBuilder!,
              );

            // COUNT
            case GridType.count:
              return GridView.count(
                padding: padding,
                controller: controller,
                physics: physics,
                primary: primary,
                reverse: reverse,
                scrollDirection: scrollDirection,
                shrinkWrap: shrinkWrap,
                crossAxisCount: crossAxisCount!,
                mainAxisSpacing: mainAxisSpacing!,
                crossAxisSpacing: crossAxisSpacing!,
                children: children!,
              );

            // EXTENT
            case GridType.extent:
              return GridView.extent(
                controller: controller,
                physics: physics,
                padding: padding,
                primary: primary,
                reverse: reverse,
                scrollDirection: scrollDirection,
                shrinkWrap: shrinkWrap,
                maxCrossAxisExtent: maxCrossAxisExtent!,
                mainAxisSpacing: mainAxisSpacing!,
                crossAxisSpacing: crossAxisSpacing!,
                children: children!,
              );

            // CUSTOM
            case GridType.custom:
              return GridView.custom(
                controller: controller,
                physics: physics,
                padding: padding,
                primary: primary,
                reverse: reverse,
                scrollDirection: scrollDirection,
                shrinkWrap: shrinkWrap,
                gridDelegate: gridDelegate!,
                childrenDelegate: SliverChildBuilderDelegate(
                  (context, index) => itemBuilder!(context, index),
                  childCount: items.length,
                ),
              );
          }
        },
      ),
    );
  }
}
