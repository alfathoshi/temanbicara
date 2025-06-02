import 'package:flutter/material.dart';
import 'package:temanbicara/app/themes/colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget title;
  final double height;
  final Widget? leading;
  final List<Widget>? actions;
  final PreferredSizeWidget? bottom;
  final bool? backLeading;

  const CustomAppBar({
    super.key,
    required this.title,
    this.height = 85,
    this.leading,
    this.actions,
    this.bottom,
    this.backLeading,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0,
      toolbarHeight: height,
      backgroundColor: whiteColor,
      centerTitle: true,
      elevation: 0,
      title: title,
      leading: leading,
      automaticallyImplyLeading: backLeading == null ? true : false,
      actions: actions,
      bottom: bottom ??
          PreferredSize(
            preferredSize: const Size.fromHeight(1),
            child: Container(
              color: grey4Color,
              height: 0.5,
            ),
          ),
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(height + (bottom?.preferredSize.height ?? 1));
}
