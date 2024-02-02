import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String screen;
  const CustomAppBar({
    super.key,
    required this.title,
    required this.screen,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      leading: Padding(
        padding: const EdgeInsets.all(16),
        child: GestureDetector(
          onTap: () {
            if (screen == 'GMap') {
              Navigator.pop(context);
            }
          },
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(5)),
            child: const Icon(
              Icons.arrow_back_ios_new,
              size: 15,
            ),
          ),
        ),
      ),
      title: Text(
        title,
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
