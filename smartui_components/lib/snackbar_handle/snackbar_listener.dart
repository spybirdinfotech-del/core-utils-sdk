import 'package:smartui_components/snackbar_handle/snackbar_state.dart';
import 'package:smartui_components/snackbar_handle/snackbar_theme_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'snackbar_cubit.dart';

class SnackbarListener extends StatelessWidget {
  final Widget child;

  const SnackbarListener({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SnackbarCubit, SnackbarState?>(
      listener: (context, state) {
        final theme = SnackbarThemeConfig.theme;
        if (state != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              behavior: SnackBarBehavior.floating,
              backgroundColor: state.bgColor,
              duration: state.duration ?? Duration(seconds: 3),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(theme.borderRadius)),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (state.title != null) Text(state.title!, style: theme.titleStyle),

                  if (state.content != null) Text(state.content!, style: theme.contentStyle),

                  if (state.buttons != null && state.buttons!.isNotEmpty)
                    Row(mainAxisAlignment: MainAxisAlignment.end,
                      children: state.buttons!
                          .map(
                            (btn) => TextButton(
                              onPressed: () {
                                btn.onPressed();
                                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                              },
                              child: Text(btn.name,style: theme.buttonStyle,),
                            ),
                          )
                          .toList(),
                    ),
                ],
              ),
            ),
          );
          context.read<SnackbarCubit>().clear();
        }

        /*   if (state != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              behavior: SnackBarBehavior.floating,
              backgroundColor: state.bgColor ?? Colors.white,
              duration: state.duration ?? Duration(seconds: 3),
              shape: state.shape ?? RoundedRectangleBorder(),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (state.title != null)
                    Text(
                      state.title!,
                      style: state.titleStyle ??
                          const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 16),
                    ),
                  if (state.content != null)
                    Text(
                      state.content!,
                      style: state.contentStyle ??
                          const TextStyle(color: Colors.black87, fontSize: 14),
                    ),
                  if (state.buttons != null && state.buttons!.isNotEmpty)
                    Row(
                      children: state.buttons!
                          .map(
                            (btn) => TextButton(
                          onPressed: () {
                            btn.onPressed();
                            ScaffoldMessenger.of(context)
                                .hideCurrentSnackBar();
                          },
                          style: btn.style,
                          child: Text(btn.name),
                        ),
                      )
                          .toList(),
                    )
                ],
              ),
            ),
          );
          context.read<SnackbarCubit>().clear();
        }*/
      },
      child: child,
    );
  }
}
