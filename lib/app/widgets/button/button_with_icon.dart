import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fields/app/config/config.dart';
import 'package:fields/app/utils/theme.dart';

class WalletMessagesButtonWithIcon extends StatelessWidget {
  final String text;
  final String icon;
  final double iconSize;
  final Color? backgroundColor;
  final VoidCallback? onPressed;
  const WalletMessagesButtonWithIcon({
    Key? key,
    required this.text,
    required this.icon,
    required this.iconSize,
    required this.onPressed,
    this.backgroundColor = AppColors.primary,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConfigBloc, ConfigState>(
      bloc: Modular.get<ConfigBloc>(),
      builder: (context, state) {
        return ElevatedButton(
          style: ButtonStyle(
            backgroundColor: onPressed == null
                ? null
                : MaterialStateProperty.all(
                    backgroundColor,
                  ),
            elevation: MaterialStateProperty.all(0.0),
            padding: MaterialStateProperty.all(
              const EdgeInsets.symmetric(
                vertical: 24.0,
                horizontal: 32.0,
              ),
            ),
            shape: MaterialStateProperty.all(
              const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12.0)),
              ),
            ),
          ),
          onPressed: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon.contains('svg')
                  ? SvgPicture.asset(
                      icon,
                      height: iconSize,
                      width: iconSize,
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
                      icon,
                      height: iconSize,
                      width: iconSize,
                      fit: BoxFit.cover,
                    ),
              const SizedBox(width: 12.0),
              Text(
                text,
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                  color: AppColors.darkGray,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
