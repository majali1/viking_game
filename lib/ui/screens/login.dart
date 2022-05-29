import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:viking_game/dtos/login.dto.dart';
import 'package:viking_game/models/vuser.dart';
import 'package:viking_game/providers/appdata.dart';
import 'package:viking_game/services/user.service.dart';
import 'package:viking_game/ui/widgets/bordered-passwordfield.dart';
import 'package:viking_game/ui/widgets/bordered-textfield.dart';
import 'package:viking_game/ui/widgets/filled_button.dart';
import 'package:viking_game/ui/widgets/progress_dialog.dart';
import 'package:viking_game/utilities/constants.dart';
import 'package:viking_game/utilities/custom_exception.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _usernameController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  bool showCustomError = false;
  late String customErrorMessage = '';

  bool showPassword = false;
  bool showConfirmPassword = false;

  void _togglePassword() {
    setState(() {
      showPassword = !showPassword;
    });
  }

  void _validateAndSubmit() async {
    if (_formKey.currentState!.validate()) {
      try {
        LoginDTO dto = LoginDTO(
            username: _usernameController.text,
            password: _passwordController.text);
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return ProgressDialog(message: 'Authenticating ...');
            });
        VUser user = await UserService.loginUser(dto);
        Navigator.of(context);
        Provider.of<AppData>(context, listen: false).updateUserInfo(user);
        Navigator.pushNamedAndRemoveUntil(
            context, PageRoutes.setupScreen, (route) => false);
      } on CustomException catch (e) {
        setState(() {
          showCustomError = true;
          customErrorMessage = e.message;
        });
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double keyBoardOpen = MediaQuery.of(context).viewInsets.bottom;
    return Scaffold(
      body: Sizer(builder: (context, orientation, deviceType) {
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Image.asset(
                            'assets/images/bg.png',
                            fit: BoxFit.fill,
                            height: orientation == Orientation.portrait
                                ? 100.h
                                : null,
                          ),
                          Positioned.fill(
                              child: Align(
                            alignment: Alignment.center,
                            child: SvgPicture.asset('assets/images/logo.svg'),
                          ))
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 9.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "LOGIN",
                            style: TextStyle(
                                fontFamily: FontFamily.BaiJamjureeSemiBold,
                                fontSize: 32,
                                color: kPrimaryColor),
                          ),
                          SizedBox(
                            height: 41,
                          ),
                          SizedBox(
                            width: keyBoardOpen == 0 ? 30.w : 55.w,
                            child: BorderedTextField(
                              textEditingController: _usernameController,
                              prefixIcon: Icons.person_outline,
                              labelText: 'Username',
                              hintText: 'Fill username',
                              showCustomError: showCustomError,
                              textInputAction: TextInputAction.next,
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          SizedBox(
                            width: keyBoardOpen == 0 ? 30.w : 55.w,
                            child: BorderedPasswordField(
                              prefixIcon: Icons.lock,
                              toggleText: _togglePassword,
                              showText: showPassword,
                              textEditingController: _passwordController,
                              textInputAction: TextInputAction.go,
                              onSubmitted: () => _validateAndSubmit(),
                              hintText: 'Enter Password',
                              labelText: 'Password',
                            ),
                          ),
                          SizedBox(
                            height: 28,
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () => {},
                              child: Text(
                                'Forgot or Reset Password?',
                                style: TextStyle(
                                    fontFamily: FontFamily.BaiJamjureeMedium,
                                    fontSize: 5.5.sp,
                                    color: Colors.black),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 57,
                          ),
                          SizedBox(
                            width: 30.w,
                            child: FilledButton(
                                text: 'Login',
                                onPressed: () => _validateAndSubmit()),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
