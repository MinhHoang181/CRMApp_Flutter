import 'package:cntt2_crm/models/Azsales/AzsalesData.dart';
import 'package:flutter/material.dart';
import 'package:cntt2_crm/constants/images.dart' as Images;
import 'package:flutter_login/flutter_login.dart';

import 'package:cntt2_crm/providers/azsales_api/auth_service.dart';

//Screens
import 'package:cntt2_crm/screens/home.screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Future<String> _authUser(LoginData data) {
    return login(data).then((user) {
      if (user == null) {
        return 'Tên đăng nhập hoặc mật khẩu sai';
      }
      AzsalesData.instance.updateAzsalesAccount(user);
      AzsalesData.instance.azsalesAccessToken = user.accessToken;
      AzsalesData.instance.fetchData();
      return null;
    });
  }

  final Function(String) _usernameValidator = (String username) {
    if (username.isEmpty) {
      return 'Chưa nhập tên đăng nhập';
    }
    return null;
  };

  final Function(String) _passwordValidator = (String password) {
    if (password.isEmpty) {
      return 'Chưa nhập mật khẩu';
    }
    return null;
  };

  final LoginMessages _loginMessages = LoginMessages(
    usernameHint: 'Tên Đăng nhập',
    passwordHint: 'Mật khẩu',
    forgotPasswordButton: 'Quên mật khẩu',
    loginButton: 'Đăng nhập',
    signupButton: 'Đăng ký',
    confirmPasswordError: 'Mật khẩu không khớp',
    recoverPasswordButton: 'Khôi phục',
    goBackButton: 'Trở lại',
  );

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      logo: Images.AZSALES,
      title: 'AZSales',
      onLogin: _authUser,
      onSignup: (_) => Future(null),
      onRecoverPassword: (_) => Future(null),
      emailValidator: _usernameValidator,
      passwordValidator: _passwordValidator,
      messages: _loginMessages,
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => Home(),
        ));
      },
      theme: _loginTheme(context),
    );
  }

  LoginTheme _loginTheme(BuildContext context) {
    return LoginTheme(
      primaryColor: Theme.of(context).primaryColor,
      accentColor: Colors.white,
    );
  }
}
