// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_task_vh/providers/countries.dart';

import 'code_main.dart';
import 'codes_list.dart';

class Codes extends StatefulWidget {
  @override
  State<Codes> createState() => _CodesState();
}

class _CodesState extends State<Codes> {
  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();

    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          isScrollControlled: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24.0),
          ),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          context: context,
          builder: (BuildContext ctx) {
            return Container(
              height: MediaQuery.of(context).size.height - 65,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.topRight,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Country code',
                              style: Theme.of(context).textTheme.headline1,
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            height: 20,
                            width: 20,
                            decoration: const BoxDecoration(
                              color: Color.fromRGBO(244, 245, 255, 0.4),
                              borderRadius: BorderRadius.all(
                                Radius.circular(6),
                              ),
                            ),
                            child: const Image(
                              image: AssetImage('assets/icons/Union.png'),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 48,
                      decoration: const BoxDecoration(
                        color: Color.fromRGBO(244, 245, 255, 0.4),
                        borderRadius: BorderRadius.all(
                          Radius.circular(16),
                        ),
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                top: 17, left: 17, bottom: 17, right: 13.52),
                            child: Image(
                              image: AssetImage('assets/icons/Search.png'),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: TextField(
                              controller: controller,
                              textCapitalization: TextCapitalization.words,
                              keyboardType: TextInputType.text,
                              style: Theme.of(context).textTheme.bodyText2,
                              decoration: InputDecoration(
                                hintText: 'Search',
                                hintStyle:
                                    Theme.of(context).textTheme.bodyText2,
                                border: InputBorder.none,
                              ),
                              onChanged: (value) {
                                Provider.of<Countries>(context, listen: false)
                                    .search(value);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    CodesList(controller),
                  ],
                ),
              ),
            );
          },
        );
      },
      child: CodeMain(),
    );
  }
}
