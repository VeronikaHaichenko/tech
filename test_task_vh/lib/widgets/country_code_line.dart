// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:jovial_svg/jovial_svg.dart';

class CountryCodeLine extends StatelessWidget {
  final String flag;
  final String code;
  String countryName;

  CountryCodeLine(
      {required this.flag, required this.code, required this.countryName});

  @override
  Widget build(BuildContext context) {
    countryName = countryName.replaceAll('', '');
    return Row(
      children: [
        Container(
          height: 20,
          width: 20,
          child: ScalableImageWidget.fromSISource(
            si: ScalableImageSource.fromSvgHttpUrl(
              Uri.parse(flag),
            ),
          ),
        ),
        const SizedBox(
          width: 12,
        ),
        Container(
          width: 55,
          child: Text(
            code,
            style: Theme.of(context).textTheme.bodyText2,
          ),
        ),
        Text(
          countryName.length > 25
              ? '${countryName.substring(0, 25)}...'
              : countryName,
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ],
    );
  }
}
