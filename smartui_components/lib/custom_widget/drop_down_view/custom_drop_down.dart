import 'package:smartui_components/custom_widget/drop_down_view/drop_down_cubit.dart';
import 'package:smartui_components/custom_widget/drop_down_view/drop_down_state.dart';
import 'package:smartui_components/custom_widget/drop_down_view/drop_down_theme_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum DropdownMode { single, multi, searchable }

class CustomDropDown<T> extends StatefulWidget {
  final String? label;
  final List<T> items;
  final T? selectedItem;
  final List<T>? selectedItems;
  final DropdownMode mode;

  final Function(T?)? onSingleSelect;
  final Function(List<T>)? onMultiSelect;

  final String Function(T item)? displayText;

  // UI
  final double height;
  final double borderRadius;
  final Color borderColor;
  final EdgeInsets padding;
  final TextStyle? menuTextStyle;
  final TextStyle? labelTextStyle;
  final TextStyle? selectedTextStyle;
  final List<BoxShadow>? dropDownBoxShadow;
  final List<BoxShadow>? menuItemBoxShadow;

  const CustomDropDown({
    super.key,
    this.label,
    required this.items,
    this.selectedItem,
    this.selectedItems,
    this.mode = DropdownMode.single,
    this.onSingleSelect,
    this.onMultiSelect,
    this.displayText,
    this.height = 50,
    this.borderRadius = 12,
    this.borderColor = Colors.grey,
    this.padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    this.menuTextStyle,
    this.labelTextStyle,
    this.selectedTextStyle,
    this.dropDownBoxShadow,
    this.menuItemBoxShadow,
  });

  @override
  State<CustomDropDown<T>> createState() => _CustomDropDownState<T>();
}

class _CustomDropDownState<T> extends State<CustomDropDown<T>> {
  final LayerLink layerLink = LayerLink();
  late DropdownCubit<T> cubit;

  @override
  void initState() {
    super.initState();
    cubit = DropdownCubit<T>(
      allItems: widget.items,
      displayText: widget.displayText!,
      selectedItems: widget.selectedItems,
    );
  }

  @override
  void dispose() {
    cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = DropDownThemeConfig.theme;

    return BlocProvider.value(
      value: cubit,
      child: BlocBuilder<DropdownCubit<T>, DropdownState<T>>(
        builder: (context, state) {
          return CompositedTransformTarget(
            link: layerLink,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (widget.label != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Text(
                      widget.label!,
                      style: theme.labelTextStyle ??
                          widget.labelTextStyle ??
                          const TextStyle(fontSize: 15),
                    ),
                  ),

                GestureDetector(
                  onTap: cubit.toggle,
                  child: Container(
                    height: widget.height,
                    padding: widget.padding,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: theme.dropDownBoxBorderColor ??
                              widget.borderColor),
                      borderRadius: BorderRadius.circular(widget.borderRadius),
                      color: theme.dropDownBoxColor ?? Colors.white,
                      boxShadow: theme.dropDownBoxShadow ?? widget.dropDownBoxShadow,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            widget.mode == DropdownMode.single
                                ? (widget.selectedItem != null
                                ? widget.displayText!(widget.selectedItem as T)
                                : "Select…")
                                : (state.multiList.isEmpty
                                ? "Select…"
                                : state.multiList
                                .map((e) => widget.displayText!(e))
                                .join(", ")),
                            style: theme.selectedTextStyle ??
                                widget.selectedTextStyle ??
                                const TextStyle(
                                    color: Colors.black, fontSize: 14),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Icon(
                          state.isOpen
                              ? Icons.keyboard_arrow_up
                              : Icons.keyboard_arrow_down,
                        ),
                      ],
                    ),
                  ),
                ),

                if (state.isOpen)
                  _buildOverlay(state, theme),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildOverlay(
      DropdownState<T> state,
      dynamic theme,
      ) {
    RenderBox box = context.findRenderObject() as RenderBox;
    final size = box.size;
    final position = box.localToGlobal(Offset.zero);

    return Positioned(
      left: position.dx,
      top: position.dy + size.height + 5,
      width: size.width,
      child: CompositedTransformFollower(
        offset: Offset(0, size.height + 5),
        link: layerLink,
        child: Material(
          elevation: 4,
          borderRadius: BorderRadius.circular(widget.borderRadius),
          child: Container(
            constraints: const BoxConstraints(maxHeight: 250),
            decoration: BoxDecoration(
              color: theme.menuItemBoxColor ?? Colors.white,
              borderRadius: theme.menuItemBoxRadius ?? BorderRadius.circular(10),
              border: Border.all(
                color: theme.menuItemBoxBorderColor ?? Colors.white,
              ),
              boxShadow: theme.menuItemBoxShadow ?? widget.menuItemBoxShadow
            ),
            child: Column(
              children: [
                if (widget.mode == DropdownMode.searchable ||
                    widget.mode == DropdownMode.multi)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.search),
                        hintText: "Search...",
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: theme.themeColor ?? Colors.black),
                        ),
                      ),
                      onChanged: cubit.search,
                    ),
                  ),

                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: state.filteredItems.length,
                    itemBuilder: (_, i) {
                      final item = state.filteredItems[i];
                      final isSelected = state.multiList.contains(item);

                      return InkWell(
                        onTap: () {
                          if (widget.mode == DropdownMode.single) {
                            widget.onSingleSelect?.call(item);
                            cubit.closeDropdown();
                          } else {
                            cubit.toggleMultiSelection(item);
                            widget.onMultiSelect?.call(cubit.state.multiList);
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            children: [
                              if (widget.mode == DropdownMode.multi)
                                Icon(
                                  isSelected
                                      ? Icons.check_box
                                      : Icons.check_box_outline_blank,
                                  color: theme.themeColor ?? Colors.green,
                                ),
                              if (widget.mode == DropdownMode.multi)
                                const SizedBox(width: 10),

                              Expanded(
                                child: Text(
                                  widget.displayText!(item),
                                  style: theme.menuTextStyle ??
                                      widget.menuTextStyle ??
                                      const TextStyle(fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

