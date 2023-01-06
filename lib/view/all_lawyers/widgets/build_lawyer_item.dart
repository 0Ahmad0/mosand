import 'package:flutter/material.dart';
import 'package:mosand/view/resourse/assets_manager.dart';
import 'package:mosand/view/resourse/values_manager.dart';

class BuildLawyerItem extends StatelessWidget {
  final String? IMG;
  final String lawyerName;
  final String lawyerSpesification;
  final VoidCallback? onTap;

  const BuildLawyerItem(
      {super.key,
      this.IMG = AssetsManager.logoIMG,
      required this.lawyerName,
      required this.lawyerSpesification,
        required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Transform.scale(
          scale: 1.45,
          child: CircleAvatar(
            backgroundImage: AssetImage(IMG!),
          )),
      title: Padding(
        padding: const EdgeInsets.only(bottom: AppPadding.p8),
        child: Text(lawyerName),
      ),
      subtitle: Text(lawyerSpesification),
    );
  }
}
