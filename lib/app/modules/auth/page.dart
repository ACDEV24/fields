import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart' show Modular;
import 'package:fields/app/modules/auth/bloc/bloc.dart';
import 'package:fields/app/utils/loading.dart';
import 'package:fields/app/widgets/button/button.dart';
import 'package:fields/app/widgets/input.dart';
import 'package:fields/app/widgets/logo.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: Modular.get<AuthBloc>(),
      child: BlocListener<AuthBloc, AuthState>(
        listener: listener,
        child: const _Body(),
      ),
    );
  }

  void listener(BuildContext context, AuthState state) {
    if (state is LoginWithGoogleState || state is SendingCodeState) {
      Loading.show(context);
    }

    if (state is ErrorLoginWithGoogleState ||
        state is LoggedWithGoogleState ||
        state is ErrorSendingCodeState) {
      Navigator.pop(context);
    }

    if (state is SendedCodeState) {
      Navigator.pop(context);
      Modular.to.pushNamed('/auth/code');
    }

    if (state is LoggedWithGoogleState) {
      Navigator.pop(context);
      Modular.to.pushNamed('/auth/choose');
    }
  }
}

class _Body extends StatelessWidget {
  const _Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: const [
                  WalletMessagesLogo(),
                  SizedBox(height: 72.0),
                  _PhoneInput(),
                  SizedBox(height: 16.0),
                  _LoginButton(),
                  SizedBox(height: 16.0),
                  _Divider(),
                  SizedBox(height: 16.0),
                  // _LinearDivider(),
                  // SizedBox(height: 16.0),
                  // _SignUpButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _LoginButton extends StatelessWidget {
  const _LoginButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AuthBloc, AuthState, bool>(
      selector: (state) {
        return state.model.isPhoneValid;
      },
      builder: (context, isPhoneValid) {
        return WalletMessagesButton(
          text: 'Iniciar sesión',
          onPressed: !isPhoneValid
              ? null
              : () {
                  context.read<AuthBloc>().add(const SendCodeEvent());
                },
        );
      },
    );
  }
}

class _PhoneInput extends StatelessWidget {
  const _PhoneInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Iniciar sesión',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12.0),
        WalletMessagesInput(
          hintText: 'Número de teléfono',
          onChanged: (value) {
            context.read<AuthBloc>().add(ChangePhoneEvent(value));
          },
          maxLength: 10,
          keyboardType: TextInputType.phone,
          justNumbers: true,
        ),
      ],
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Expanded(
          child: Divider(
            color: Colors.black,
            thickness: .20,
          ),
        ),
        SizedBox(width: 10.0),
        Text(
          'O',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w200,
          ),
        ),
        SizedBox(width: 10.0),
        Expanded(
          child: Divider(
            color: Colors.black,
            thickness: .20,
          ),
        ),
      ],
    );
  }
}

// class _LinearDivider extends StatelessWidget {
//   const _LinearDivider({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return const Divider(
//       color: Colors.black,
//       thickness: .20,
//     );
//   }
// }

// class _SignUpButton extends StatelessWidget {
//   const _SignUpButton({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: TextButton(
//         style: TextButton.styleFrom(
//           primary: AppTheme.primary,
//         ),
//         child: const Text(
//           'Crear cuenta',
//           style: TextStyle(
//             fontSize: 16.0,
//             fontWeight: FontWeight.w500,
//             color: AppTheme.primary,
//           ),
//         ),
//         onPressed: () {},
//       ),
//     );
//   }
// }
