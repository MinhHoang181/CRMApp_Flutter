import 'package:flutter/material.dart';
import 'package:cntt2_crm/constants/colors.dart' as Colors;
import 'package:cntt2_crm/constants/images.dart' as Images;
import 'package:flutter_login/flutter_login.dart';

//Screens
import 'package:cntt2_crm/screens/home.screen.dart';

const users = const {
  'admin': 'admin',
};

class LoginScreen extends StatelessWidget {
  Duration get loginTime => Duration(milliseconds: 0);

  Future<String> _authUser(LoginData data) {
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(data.name)) {
        return 'Tên đăng nhập không tồn tại';
      }
      if (users[data.name] != data.password) {
        return 'Mật khẩu không chính xác';
      }
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
    );
  }
}
