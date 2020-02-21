import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:auto_size_text/auto_size_text.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height*0.5,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/login/login_bg.png'),
                  fit: BoxFit.fill,
                )
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height*0.5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height*0.05,
                    child: AutoSizeText(
                      'Login / Register',
                      presetFontSizes: [40, 20, 14],
                      style: TextStyle(color:Colors.black,fontWeight: FontWeight.bold,fontSize: 17.0),
                    ),
                  ),
                  GestureDetector(
                    onTap: ()=>Navigator.pushReplacementNamed(context, '/mainscreen'),
                    child: Container(
                      height: MediaQuery.of(context).size.height*0.10,
                      child: Stack(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(left:60.0,right: 17.0),
                            height: MediaQuery.of(context).size.height*0.10,
                            decoration: BoxDecoration(
                              color: Color(0xfff7f7f7),
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(8.0),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                  color: Color(0xff29000000),
                                  blurRadius: 10.0,
                                  offset:Offset(0.0,5.0),
                                )
                              ]
                            ),
                            child: Container(
                              alignment: Alignment.centerRight,
                              padding: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.05),
                              child: AutoSizeText(
                                'Login with Facebook',
                                maxLines: 1,
                                presetFontSizes: [40, 20, 14],
                                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16.0,color: Color(0xff265390)),
                              )
                            ),
                          ),
                          new Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: 16.0
                            ),
                            alignment: FractionalOffset.centerLeft,
                            child: Image(
                              image: AssetImage('assets/images/login/facebook.png'),
                              height: MediaQuery.of(context).size.height*0.10,
                            ),
                          ),
                        ],
                      )
                    ),
                  ),
                  GestureDetector(
                    onTap: ()=>print('login google'),
                    child: Container(
                      height: MediaQuery.of(context).size.height*0.10,
                      child: Stack(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(left:60.0,right: 17.0),
                            height: MediaQuery.of(context).size.height*0.10,
                            decoration: BoxDecoration(
                              color: Color(0xfff7f7f7),
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(8.0),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                  color: Color(0xff29000000),
                                  blurRadius: 10.0,
                                  offset:Offset(0.0,5.0),
                                )
                              ]
                            ),
                            child: Container(
                              alignment: Alignment.centerRight,
                              padding: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.05),
                              child: AutoSizeText(
                                'Login with Google Account',
                                maxLines: 1,
                                presetFontSizes: [40, 20, 14],
                                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16.0,color: Color(0xffc91a1a)),
                              )
                            ),
                          ),
                          new Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: 16.0
                            ),
                            alignment: FractionalOffset.centerLeft,
                            child: Image(
                              image: AssetImage('assets/images/login/google.png'),
                              height: MediaQuery.of(context).size.height*0.10,
                            ),
                          ),
                        ],
                      )
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height*0.1,
                    child: Center(
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'by registering, you agree to the ',
                              style: TextStyle(color:Color(0xffa7a7a7)),
                            ),
                            new TextSpan(
                              text: 'terms of service',
                              style: new TextStyle(color: Color(0xffde7939),decoration: TextDecoration.underline),
                              recognizer: new TapGestureRecognizer()
                                ..onTap = () { launch('https://docs.flutter.io/flutter/services/UrlLauncher-class.html');
                              },
                            ),
                            TextSpan(
                              text: ' \nand ',
                              style: TextStyle(color:Color(0xffa7a7a7)),
                            ),
                            new TextSpan(
                              text: 'privacy policy',
                              style: new TextStyle(color: Color(0xffde7939),decoration: TextDecoration.underline),
                              recognizer: new TapGestureRecognizer()
                                ..onTap = () { launch('https://docs.flutter.io/flutter/services/UrlLauncher-class.html');
                              },
                            ),
                          ]
                        ) 
                      ),
                    )
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}