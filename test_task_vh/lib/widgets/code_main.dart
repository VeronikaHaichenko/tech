import 'package:flutter/material.dart';
import 'package:jovial_svg/jovial_svg.dart';
import 'package:provider/provider.dart';

import '../providers/currentData.dart';

class CodeMain extends StatelessWidget {
  const CodeMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
      ),
      height: 48,
      constraints: const BoxConstraints(
        minWidth: 71,
        maxWidth: 150,
      ),
      decoration: const BoxDecoration(
        color: Color.fromRGBO(244, 245, 255, 0.4),
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 20,
            width: 20,
            child: ScalableImageWidget.fromSISource(
              si: ScalableImageSource.fromSvgHttpUrl(
                Uri.parse(Provider.of<CurrentData>(context).flagUrl),
              ),
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          Text(Provider.of<CurrentData>(context).currentCode),
        ],
      ),
    );
  }
}
