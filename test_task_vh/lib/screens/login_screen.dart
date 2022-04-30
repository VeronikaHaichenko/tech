// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import 'package:test_task_vh/providers/countries.dart';
import 'package:test_task_vh/widgets/codes_bottom_sheet.dart';

import '../providers/currentData.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _controller = TextEditingController();
  var _isLoading = false;
  var phoneNumber = '';
  var maskFormatter = MaskTextInputFormatter(
    mask: '(###) ###-####',
    type: MaskAutoCompletionType.lazy,
  );

  @override
  void initState() {
    setState(() {
      _isLoading = true;
    });
    Future.delayed(Duration.zero, (() {
      Provider.of<Countries>(context, listen: false)
          .fetchAndSetCountries()
          .then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }));
    super.initState();
  }

  void showNumber(String phoneNumber) {
    showDialog(
      context: context,
      builder: (ctx) => SimpleDialog(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(16),
          ),
        ),
        title: Text(
          'Your phone number is:',
          style: Theme.of(context).textTheme.bodyText1,
          textAlign: TextAlign.center,
        ),
        children: [
          Text(
            phoneNumber,
            style: Theme.of(context).textTheme.bodyText1,
            textAlign: TextAlign.center,
          ),
          FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              'Ok',
              style: Theme.of(context).textTheme.bodyText2,
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 48),
          child: _isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Get Started',
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    const SizedBox(
                      height: 160,
                    ),
                    Row(
                      children: [
                        Codes(),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: Container(
                            height: 48,
                            decoration: const BoxDecoration(
                              color: Color.fromRGBO(244, 245, 255, 0.4),
                              borderRadius: BorderRadius.all(
                                Radius.circular(16),
                              ),
                            ),
                            child: Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              child: TextField(
                                style: Theme.of(context).textTheme.bodyText2,
                                inputFormatters: [maskFormatter],
                                controller: _controller,
                                keyboardType: TextInputType.phone,
                                // maxLength: 10,
                                decoration: const InputDecoration(
                                  hintText: '(123) 123-1234',
                                  hintStyle: TextStyle(
                                    color: Color(0xff7886B8),
                                  ),
                                  border: InputBorder.none,
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    phoneNumber = value;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Container(),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (phoneNumber.length == 14) {
                              phoneNumber = Provider.of<CurrentData>(context,
                                          listen: false)
                                      .currentCode +
                                  phoneNumber;
                              showNumber(phoneNumber);
                              Provider.of<CurrentData>(context, listen: false)
                                  .setCurrentCode(
                                      Provider.of<Countries>(context,
                                              listen: false)
                                          .defCode,
                                      Provider.of<Countries>(context,
                                              listen: false)
                                          .defFlag);
                              FocusScope.of(context).unfocus();
                              phoneNumber = '';
                              _controller.clear();
                            } else {
                              null;
                            }
                          },
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                height: 48,
                                width: 48,
                                decoration: BoxDecoration(
                                  color: phoneNumber.length == 14
                                      ? Colors.white
                                      : Color.fromRGBO(244, 245, 255, 0.4),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(16),
                                  ),
                                ),
                              ),
                              Image(
                                image: phoneNumber.length == 14
                                    ? AssetImage('assets/icons/NextDark.png')
                                    : AssetImage('assets/icons/NextLight.png'),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    )
                  ],
                ),
        ),
      ),
    );
  }
}
