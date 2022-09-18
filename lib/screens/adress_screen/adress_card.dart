import 'package:flutter/material.dart';
import 'package:kayan/models/adress_model.dart';

class AdressCard extends StatelessWidget {
  const AdressCard({Key? key, required this.adressModel, this.onTap})
      : super(key: key);
  final AdressModel adressModel;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        SizedBox(
          width: double.maxFinite,
          child: InkWell(
            onTap: () {
              onTap != null ? onTap!() : null;
            },
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${adressModel.buildNo} ${adressModel.streetName}',
                      style: Theme.of(context).textTheme.headline5!.copyWith(
                          fontFamily: 'Cairo',
                          fontWeight: FontWeight.w700,
                          height: 1),
                    ),
                    Text(
                      '${adressModel.city}, ${adressModel.state}',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontFamily: 'Cairo'),
                    ),
                    Text(
                      'الطابق  ${adressModel.floor}',
                      style: Theme.of(context).textTheme.caption!.copyWith(
                          color: Colors.black, fontFamily: 'Cairo', height: 1),
                    ),
                    Text(
                      adressModel.details ?? '',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontFamily: 'Cairo', fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
