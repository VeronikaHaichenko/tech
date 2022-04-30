import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/countries.dart';
import '../providers/currentData.dart';
import 'country_code_line.dart';

class CodesList extends StatelessWidget {
  final TextEditingController controller;

  CodesList(this.controller);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Consumer<Countries>(
        builder: (ctx, value, _) => controller.text.isEmpty
            ? ListView.builder(
                itemCount: value.countries.length,
                itemBuilder: (ctx, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: GestureDetector(
                      onTap: () {
                        Provider.of<CurrentData>(context, listen: false)
                            .setCurrentCode(value.countries[index].code,
                                value.countries[index].flagUrl);
                        Navigator.of(context).pop();
                        controller.clear();
                      },
                      child: CountryCodeLine(
                        flag: value.countries[index].flagUrl,
                        code: value.countries[index].code,
                        countryName: value.countries[index].country,
                      ),
                    ),
                  );
                },
              )
            : value.searchResult!.isNotEmpty
                ? ListView.builder(
                    itemCount: value.searchResult!.length,
                    itemBuilder: (ctx, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 24),
                        child: GestureDetector(
                          onTap: () {
                            Provider.of<CurrentData>(context, listen: false)
                                .setCurrentCode(value.searchResult![index].code,
                                    value.searchResult![index].flagUrl);
                            Navigator.of(context).pop();
                            controller.clear();
                          },
                          child: CountryCodeLine(
                            flag: value.searchResult![index].flagUrl,
                            code: value.searchResult![index].code,
                            countryName: value.searchResult![index].country,
                          ),
                        ),
                      );
                    },
                  )
                : Text(
                    'No result',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
      ),
    );
  }
}
