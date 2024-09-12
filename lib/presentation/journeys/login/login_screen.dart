import 'package:flutter/material.dart';
import 'package:movieapp/common/constants/size_constants.dart';
import 'package:movieapp/common/extensions/size_extensions.dart';
import 'package:movieapp/presentation/widgets/logo.dart';

import 'login_form.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: Sizes.dimen_32.h),
              child: Logo(
                key: const ValueKey('logo_key'),
                height: Sizes.dimen_12.h,
              ),
            ),
            const Expanded(
              child: LoginForm(
                key: ValueKey('login_form_key'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}