import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      iconTheme: const IconThemeData(color: Colors.black),
      backgroundColor: const Color.fromRGBO(239, 238, 251, 1),
      title: Image.asset('assets/bar.png'),
      actions: const [Icon(Icons.notifications_none)],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
