import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class CustomListView extends StatelessWidget {
  final IndexedWidgetBuilder itemBuilder;
  final IndexedWidgetBuilder? separatorBuilder;
  final int itemCount;

  final VoidCallback? onLoadMore;
  final bool isLoadingMore;

  final Axis scrollDirection;
  final bool reverse;
  final ScrollController? controller;
  final bool? primary;
  final ScrollPhysics? physics;
  final bool shrinkWrap;
  final EdgeInsetsGeometry? padding;
  final Clip clipBehavior;
  final bool addAutomaticKeepAlives;
  final bool addRepaintBoundaries;
  final bool addSemanticIndexes;
  final DragStartBehavior dragStartBehavior;
  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;

  const CustomListView({
    super.key,
    required this.itemBuilder,
    required this.itemCount,
    this.separatorBuilder,
    this.onLoadMore,
    this.isLoadingMore = false,
    this.scrollDirection = Axis.vertical,
    this.reverse = false,
    this.controller,
    this.primary,
    this.physics,
    this.shrinkWrap = false,
    this.padding,
    this.clipBehavior = Clip.hardEdge,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    this.dragStartBehavior = DragStartBehavior.start,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
  });

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollCtrl = controller ?? ScrollController();

    scrollCtrl.addListener(() {
      if (onLoadMore != null &&
          scrollCtrl.position.pixels >= scrollCtrl.position.maxScrollExtent * 0.8 &&
          !isLoadingMore) {
        onLoadMore?.call();
      }
    });

    final listView = (separatorBuilder != null)
        ? ListView.separated(
      controller: scrollCtrl,
      scrollDirection: scrollDirection,
      reverse: reverse,
      primary: primary,
      physics: physics,
      shrinkWrap: shrinkWrap,
      padding: padding,
      clipBehavior: clipBehavior,
      addAutomaticKeepAlives: addAutomaticKeepAlives,
      addRepaintBoundaries: addRepaintBoundaries,
      addSemanticIndexes: addSemanticIndexes,
      dragStartBehavior: dragStartBehavior,
      keyboardDismissBehavior: keyboardDismissBehavior,
      separatorBuilder: separatorBuilder!,
      itemBuilder: itemBuilder,
      itemCount: itemCount,
    )
        : ListView.builder(
      controller: scrollCtrl,
      scrollDirection: scrollDirection,
      reverse: reverse,
      primary: primary,
      physics: physics,
      shrinkWrap: shrinkWrap,
      padding: padding,
      clipBehavior: clipBehavior,
      addAutomaticKeepAlives: addAutomaticKeepAlives,
      addRepaintBoundaries: addRepaintBoundaries,
      addSemanticIndexes: addSemanticIndexes,
      dragStartBehavior: dragStartBehavior,
      keyboardDismissBehavior: keyboardDismissBehavior,
      itemBuilder: itemBuilder,
      itemCount: itemCount,
    );

    return Column(
      children: [
        Expanded(child: listView),
        if (isLoadingMore)
          const Padding(
            padding: EdgeInsets.all(12),
            child: CircularProgressIndicator(),
          )
      ],
    );
  }
}
