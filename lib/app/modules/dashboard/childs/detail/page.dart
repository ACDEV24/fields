import 'dart:ui';

import 'package:animated_widgets/widgets/translation_animated.dart';
import 'package:fields/app/models/field.dart';
import 'package:fields/app/modules/dashboard/childs/detail/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart'
    hide ModularWatchExtension;
import 'package:fields/app/utils/theme.dart';
import 'package:fields/app/widgets/network_image.dart';

class FieldDetailPage extends StatelessWidget {
  final Field field;
  const FieldDetailPage({
    Key? key,
    required this.field,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => Modular.get<FieldDetailBloc>(),
      child: Scaffold(
        body: Stack(
          children: [
            _Background(field: field),
            _Detail(field: field),
            const _BackArrow(),
          ],
        ),
      ),
    );
  }
}

class _BackArrow extends StatelessWidget {
  const _BackArrow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: BlocSelector<FieldDetailBloc, FieldDetailState, bool>(
        selector: (state) {
          return state.model.visible;
        },
        builder: (context, isVisible) {
          return TranslationAnimatedWidget(
            enabled: isVisible,
            values: const [
              Offset(0, -500),
              Offset(0, -250),
              Offset(0, 0),
            ],
            child: Container(
              margin: const EdgeInsets.only(top: 26.0, left: 16.0),
              decoration: const BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.all(Radius.circular(35.0)),
              ),
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                onPressed: () {
                  Modular.to.pop();
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

class _Background extends StatelessWidget {
  final Field field;
  const _Background({
    Key? key,
    required this.field,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //TODO: Uncomment

    // Future.delayed(
    //   const Duration(milliseconds: 500),
    //   () {
    //     context
    //         .read<FieldDetailBloc>()
    //         .add(const ChangeDetailVisibitilyEvent());
    //   },
    // );
    return GestureDetector(
      onTap: () {
        context
            .read<FieldDetailBloc>()
            .add(const ChangeDetailVisibitilyEvent());
      },
      child: BlocBuilder<FieldDetailBloc, FieldDetailState>(
        builder: (context, state) {
          final isVisible = state.model.visible;

          return Hero(
            tag: field.uuid,
            child: SizedBox(
              height: double.infinity,
              child: ImageFiltered(
                imageFilter: ImageFilter.blur(
                  sigmaX: isVisible ? 3.0 : 0,
                  sigmaY: isVisible ? 1.0 : 0,
                ),
                child: CachedImage(
                  url: field.image,
                  boxFit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _Detail extends StatelessWidget {
  final Field field;
  const _Detail({
    Key? key,
    required this.field,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FieldDetailBloc, FieldDetailState>(
      builder: (context, state) {
        return TranslationAnimatedWidget(
          enabled: state.model
              .visible, //update this boolean to forward/reverse the animation
          values: const [
            Offset(0, 500), // disabled value value
            Offset(0, 250), //intermediate value
            Offset(0, 0) //enabled value
          ],
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 300,
              margin: const EdgeInsets.all(16.0),
              padding: const EdgeInsets.all(26.0),
              decoration: const BoxDecoration(
                color: Colors.black45,
                borderRadius: BorderRadius.all(Radius.circular(35.0)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    field.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    field.description,
                    style: const TextStyle(
                      fontSize: 16.0,
                      color: Colors.white,
                    ),
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Precio',
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 4.0),
                          Text(
                            '\$${field.price}',
                            style: const TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Modular.to.pushNamed(
                            '/dashboard/field/reservation',
                            arguments: field,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(25.0),
                            ),
                          ),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20.0,
                            vertical: 12.0,
                          ),
                          child: Text(
                            'Reservar',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
