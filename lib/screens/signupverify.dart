import 'package:ecommerce/constant/colors.dart';
import 'package:ecommerce/constant/images.dart';
import 'package:ecommerce/size_config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/constant/strings.dart';
import 'package:flutter/widgets.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpVerify extends StatefulWidget {
  String mobNo;
  SignUpVerify(this.mobNo);
  @override
  _SignUpVerifyState createState() => _SignUpVerifyState();
}

class _SignUpVerifyState extends State<SignUpVerify> {
  final otpController = TextEditingController();
  bool _validateOTP = false;
  FocusNode nodeOTP = FocusNode();
  bool isLoading = false;
  String otpCode;

  final kHintTextStyle = TextStyle(
    color: Colors.grey,
    fontFamily: 'OpenSans',
  );

  final kLabelStyle = TextStyle(
    color: Colors.grey,
    fontWeight: FontWeight.bold,
    fontFamily: 'OpenSans',
  );

  final kBoxDecorationStyle = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(30.0),
    boxShadow: [
      BoxShadow(
        color: Colors.black12,
        blurRadius: 4.0,
        offset: Offset(0, 2),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    Widget _buildMobileTF() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            //decoration: kBoxDecorationStyle,
            height: 60.0,
            child: PinInputTextField(
              pinLength: 6,
              decoration:
                  UnderlineDecoration(gapSpace: 20, color: Colors.grey[800]),
              controller: otpController,
              focusNode: nodeOTP,
              textInputAction: TextInputAction.go,
              enabled: true,
              keyboardType: TextInputType.number,
              onSubmit: (pin) async {
                debugPrint('submit pin:$pin');
                setState(() {
                  otpCode = pin;
                });
                setState(() {
                  otpController.text.length == 6
                      ? _validateOTP = false
                      : _validateOTP = true;
                });

                if (_validateOTP) {
                  FocusScope.of(context).requestFocus(nodeOTP);
                } else if (!_validateOTP) {
                  FirebaseAuth auth = FirebaseAuth.instance;
                  otpCode = otpController.text.trim();
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  String verificationId = prefs
                      .getString("registerFirebaseVerificationId")
                      .toString();

                  AuthCredential _credential = PhoneAuthProvider.credential(
                      verificationId: verificationId, smsCode: otpCode);
                  auth.signInWithCredential(_credential).then((result) {
                    if (result.user != null) {
                      print("Success OTP Authentication");
                    } else {
                      print("OTP Authentication Faild!");
                    }
                  }).catchError((e) {
                    print(e);
                  });
                  //customerForgotPassword(mobnoController.text);
                } else {
                  print("Somthing Worng");
                }
              },
              onChanged: (pin) {
                debugPrint('onChanged execute. pin:$pin');
                otpCode = pin;
              },
              enableInteractiveSelection: true,
            ),
          ),
          _validateOTP
              ? Container(
                  margin: EdgeInsets.only(top: 8, left: 6),
                  child: Text(
                    "Please enter 6 digit OTP!",
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.red,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
              : Container()
        ],
      );
    }

    Widget _buildContinueBtn() {
      return Container(
        margin: EdgeInsets.only(top: 20),
        width: MediaQuery.of(context).size.width,
        child: RaisedButton(
          disabledColor: ThemeColors.yellowColor,
          disabledElevation: 3.0,
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(30.0)),
          padding: EdgeInsets.symmetric(vertical: 18.0),
          onPressed: isLoading
              ? null
              : () async {
                  setState(() {
                    otpController.text.length == 6
                        ? _validateOTP = false
                        : _validateOTP = true;
                  });

                  if (_validateOTP) {
                    FocusScope.of(context).requestFocus(nodeOTP);
                  } else if (!_validateOTP) {
                    FirebaseAuth auth = FirebaseAuth.instance;
                    otpCode = otpController.text.trim();
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    String verificationId = prefs
                        .getString("registerFirebaseVerificationId")
                        .toString();
                    AuthCredential _credential = PhoneAuthProvider.credential(
                        verificationId: verificationId, smsCode: otpCode);
                    auth
                        .signInWithCredential(_credential)
                        .then((UserCredential result) {
                      if (result.user != null) {
                        print("Success OTP Authentication");
                      } else {
                        print("OTP Authentication Faild!");
                      }
                    }).catchError((e) {
                      print(e);
                    });
                    //customerForgotPassword(mobnoController.text);
                  } else {
                    print("Somthing Worng");
                  }
                },
          color: ThemeColors.yellowColor,
          textColor: Colors.black,
          child: isLoading
              ? SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(),
                )
              : Text(
                  Strings.SignUpVerifBtn,
                  style: TextStyle(
                    fontSize: 17.0,
                  ),
                ),
        ),
      );
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 30, left: 30, right: 30, bottom: 15),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            //mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Image.asset(
                  Images.screensBgWatermarkLogo,
                ),
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(bottom: 10),
                child: Text(
                  "OTP has been sent to +91" + widget.mobNo,
                  style: TextStyle(
                    fontSize: 2.8 * SizeConfig.textMultiplier,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(bottom: 10),
                child: Text(
                  Strings.SignUpVerifOTPMessage,
                  style: TextStyle(
                    fontSize: 2.7 * SizeConfig.textMultiplier,
                  ),
                ),
              ),
              _buildMobileTF(),
              _buildContinueBtn(),
            ],
          ),
        ),
      ),
    );
  }
}
