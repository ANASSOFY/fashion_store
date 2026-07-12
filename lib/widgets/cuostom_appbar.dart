import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  final String leadingIcon;
  final String actionIcon;
  final VoidCallback? onLeadingPressed;
  final VoidCallback? onActionPressed;
  

  const CustomAppBar({
    super.key,
    required this.title,
    required this.leadingIcon,
    required this.actionIcon,
    this.onLeadingPressed,
    this.onActionPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      elevation: 0,
      centerTitle: true,

      // القائمة على الشمال
      leading: IconButton(
        onPressed: onLeadingPressed,
        icon: SvgPicture.asset(
          leadingIcon,
          width: 24,
          height: 24,
        ),
      ),

      // العنوان في المنتصف
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),

      // الجرس على اليمين
      actions: [
        IconButton(
          onPressed: onActionPressed,
          icon: SvgPicture.asset(
            actionIcon,
            width: 24,
            height: 24,
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}