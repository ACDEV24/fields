import 'package:fields/app/models/field.dart';
import 'package:fields/app/widgets/network_image.dart';
import 'package:flutter/material.dart';

class FieldWidget extends StatelessWidget {
  final Field field;
  final void Function() onFieldTap;
  const FieldWidget({
    Key? key,
    required this.field,
    required this.onFieldTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onFieldTap,
      borderRadius: BorderRadius.circular(12.0),
      child: Container(
        height: 180.0,
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.0).copyWith(
                topRight: Radius.zero,
                bottomRight: Radius.zero,
              ),
              child: Hero(
                tag: field.uuid,
                child: CachedImage(
                  url: field.image,
                  width: 150,
                  height: double.infinity,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          field.name,
                          style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          field.description,
                          style: const TextStyle(
                            fontSize: 12.0,
                          ),
                        ),
                        const SizedBox(height: 12.0),
                        RichText(
                          text: TextSpan(
                            text: 'Numero de reservas: ',
                            style: const TextStyle(
                              fontSize: 10.0,
                              color: Colors.black,
                            ),
                            children: [
                              TextSpan(
                                text: '${field.numReservations}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                    RichText(
                      text: TextSpan(
                        text: 'Precio: ',
                        style: const TextStyle(
                          fontSize: 14.0,
                          color: Colors.black,
                        ),
                        children: [
                          TextSpan(
                            text: '\$${field.price}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.green[800],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
