import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fields/app/config/config.dart';
import 'package:fields/app/utils/theme.dart';

class WalletMessagesButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  const WalletMessagesButton({
    Key? key,
    required this.text,
    required this.onPressed,
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
                : MaterialStateProperty.all(AppColors.primary),
            padding: MaterialStateProperty.all(
              const EdgeInsets.symmetric(
                vertical: 18.0,
                horizontal: 24.0,
              ),
            ),
            shape: MaterialStateProperty.all(
              const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12.0)),
              ),
            ),
          ),
          onPressed: onPressed,
          child: Text(text),
        );
      },
    );
  }
}
