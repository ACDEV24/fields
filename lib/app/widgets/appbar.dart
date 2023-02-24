import 'package:flutter/material.dart';

class WalletMessagesAppBar extends StatelessWidget with PreferredSizeWidget {
  final Widget? title;
  const WalletMessagesAppBar({
    Key? key,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      title: title,
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
