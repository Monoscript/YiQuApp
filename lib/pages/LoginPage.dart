import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:yiqu/data/AppConfig.dart';
import 'package:yiqu/data/User.dart';
import 'package:yiqu/pages/HomePage.dart';
import 'package:yiqu/widgets/PromptWidgetDialog.dart';
import 'package:yiqu/widgets/TextInputWidget.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  final _loginFormKey = GlobalKey<FormState>();
  String _account, _password;
  bool _loginFailed;

  @override
  void initState() {
    super.initState();
    _loginFailed = false;
  }

  void submitLoginForm() {
    //保存当前状态的值，即前面 onSaved 里执行的内容
    if (_loginFormKey.currentState.validate()) {
      _loginFormKey.currentState.save();
      // TODO:提交给数据库验证
      if (_account == myself.getAccount && _password == myself.getPassword) {
        _loginFailed = true;
      }
      showDialog(
          context: context,
          builder: (context) {
            return PromptWidgetDialog(
              contents: _loginFailed ? "账号或密码错误\n请重新登录!" : "正在登录验证\n请稍等...",
              child: _loginFailed
                  ? Icon(Icons.close, size: 54.0, color: AppTheme.mainRed)
                  : CircularProgressIndicator(),
            );
          });
      Future.delayed(Duration(milliseconds: 2000), () {
        Navigator.pop(context);
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (_) => HomePage(),
        ));
      });
    } else {
      // Scaffold.of(context).showSnackBar(SnackBar(
      //   content: Text("正在登陆..."),
      //   duration: Duration(seconds: 2),
      // ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(left: 32.0, right: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(vertical: 40.0),
                child: CircleAvatar(
                  minRadius: 30.0,
                  maxRadius: 40.0,
                  backgroundColor: AppTheme.blueButtonShadow,
                  backgroundImage: User.boyUser.headImage.image,
                ),
              ),

              // 输入表单
              Form(
                key: _loginFormKey,
                child: Column(
                  children: <Widget>[
                    // 输入账号文本框
                    TextInputWidget(
                      hintText: "输入账号",
                      errorText: "账号不能为空",
                      maxLength: 22,
                      icon:
                          Icon(Icons.account_circle, color: AppTheme.inactive),
                    ),

                    // 间隔
                    SizedBox(height: 8.0),

                    // 输入密码文本框
                    TextInputWidget(
                      icon: Icon(Icons.lock, color: AppTheme.inactive),
                      hintText: "输入密码",
                      errorText: "密码不能为空",
                      maxLength: 16,
                      format: EInputFormat.Passward,
                    ),

                    // 注册新用户和忘记密码
                    Padding(
                      padding: EdgeInsets.only(top: 16.0, bottom: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          InkWell(
                            child: Text(
                              "注册成为新用户",
                              style: AppTheme.titleTextStyle.copyWith(
                                color: AppTheme.mainBlue,
                              ),
                            ),

                            // 进入注册页面
                            onTap: () {
                              // Navigator.push(context, MaterialPageRoute(
                              //   builder: (BuildContext context) => RegisterPage();
                              // ));
                            },
                          ),
                          InkWell(
                            child: Text(
                              "忘记密码?",
                              style: AppTheme.titleTextStyle.copyWith(
                                color: AppTheme.mainBlue,
                              ),
                            ),

                            // 进入忘记密码页面
                            onTap: () {
                              // Navigator.push(context, MaterialPageRoute(
                              //   builder: (BuildContext context) => ForgetPassword();
                              // ));
                            },
                          ),
                        ],
                      ),
                    ),

                    // 登录按钮
                    Container(
                      width: double.infinity,
                      height: 50.0,
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        color: Theme.of(context).accentColor,
                        child: Text(
                          '登录',
                          style: AppTheme.titleTextStyle.copyWith(
                            color: AppTheme.mainBackground,
                          ),
                        ),
                        onPressed: submitLoginForm,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.0),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0.0, 8.0),
                            blurRadius: 14.0,
                            color: AppTheme.blueButtonShadow.withOpacity(0.7),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // 其它方式登录
              Padding(
                padding: EdgeInsets.only(top: 80.0, bottom: 20.0),
                child: Text(
                  "—  其它方式登录  —",
                  style: AppTheme.inactiveTextStyle.copyWith(fontSize: 14.0),
                ),
              ),

              // 其它方式登录的图标
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  InkWell(
                    child: Image(
                      image: AssetImage("assets/images/login_by_alipay.png"),
                      width: 42.0,
                    ),
                  ),
                  InkWell(
                    child: Image(
                      image: AssetImage("assets/images/login_by_qq.png"),
                      width: 36.0,
                    ),
                  ),
                  InkWell(
                    child: Image(
                      image: AssetImage("assets/images/login_by_wechat.png"),
                      width: 46.0,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
