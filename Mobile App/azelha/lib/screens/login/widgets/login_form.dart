import 'package:azelha/contsants/colors.dart';
import 'package:azelha/screens/home/home_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'custom_button.dart';
import 'custom_input_field.dart';
import 'fade_slide_transition.dart';

class LoginForm extends StatelessWidget {
  final Animation<double> animation;

  const LoginForm({
    @required this.animation,
  }) : assert(animation != null);

  @override
  Widget build(BuildContext context) {
    var height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    var space = height > 650 ? kSpaceM : kSpaceS;
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kPaddingL),
          child: Column(
            children: <Widget>[
              FadeSlideTransition(
                animation: animation,
                additionalOffset: 0.0,
                child: CustomInputField(
                  label: 'Username or Email',
                  prefixIcon: Icons.person,
                  obscureText: true,
                ),
              ),
              SizedBox(height: space),
              FadeSlideTransition(
                animation: animation,
                additionalOffset: space,
                child: CustomInputField(
                  label: 'Password',
                  prefixIcon: Icons.lock,
                  obscureText: true,
                ),
              ),
              SizedBox(height: space),
              FadeSlideTransition(
                animation: animation,
                additionalOffset: 2 * space,
                child: CustomButton(
                  color: primaryColor,
                  textColor: primaryTextColor,
                  text: 'Login to continue',
                  onPressed: () {
                    Navigator.push(
                      context,
                      new MaterialPageRoute(
                        builder: (context) => HomeScreen(),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 2 * space),
              FadeSlideTransition(
                animation: animation,
                additionalOffset: 3 * space,
                child: CustomButton(
                  color: primaryDarkColor,
                  textColor: primaryTextColor.withOpacity(0.5),
                  text: 'Continue with Google',
                  image: Image(
                    image: AssetImage(kGoogleLogoPath),
                    height: 48.0,
                  ),
                  onPressed: () {},
                ),
              ),
              SizedBox(height: space),
              FadeSlideTransition(
                animation: animation,
                additionalOffset: 4 * space,
                child: CustomButton(
                  color: primaryDarkColor,
                  textColor: primaryTextColor,
                  text: 'Create Account',
                  onPressed: () {},
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

Widget roundedRectButton(String title, bool isEndIconVisible) {
  return Builder(builder: (BuildContext mContext) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: Stack(
        alignment: Alignment(1.0, 0.0),
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            width: MediaQuery.of(mContext).size.width / 1.7,
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0)),
            ),
            child: Text(
              title,
            ),
            padding: EdgeInsets.only(top: 16, bottom: 16),
          ),
          Visibility(
            visible: isEndIconVisible,
            child: Padding(
                padding: EdgeInsets.only(right: 10),
                child: ImageIcon(
                  AssetImage("assets/ic_forward.png"),
                  size: 30,
                  color: Colors.white,
                )),
          ),
        ],
      ),
    );
  });
}
