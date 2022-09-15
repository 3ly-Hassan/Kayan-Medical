import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class OnBoardingContent extends StatelessWidget {
  const OnBoardingContent({
    Key? key,
    required this.imgPath,
    required this.header,
    required this.body,
  }) : super(key: key);
  final String imgPath;
  final String header;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const Spacer(),
      SvgPicture.asset(
        imgPath,
        height: 250,
      ),
      const Spacer(),
      Text(
        header,
        textDirection: TextDirection.rtl,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.headline5!.copyWith(
            fontWeight: FontWeight.w700,
            fontFamily: 'Cairo',
            color: Colors.lightGreen),
      ),
      Text(
        body,
        textDirection: TextDirection.rtl,
        textAlign: TextAlign.center,
        style: Theme.of(context)
            .textTheme
            .bodyText2!
            .copyWith(fontWeight: FontWeight.w500, fontFamily: 'Cairo'),
      ),
      const Spacer(),
    ]);
  }
}
