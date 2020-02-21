import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prototype_ws_momoka/resources/route.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();
  //screen khusus portrait 
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_){
    //setup router momoka
    RouteMomoka.setupRouter();
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Splash(),
      onGenerateRoute: RouteMomoka.router.generator,
    );
  }
}

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override 
  void initState(){
    super.initState();
    Timer(Duration(seconds: 4), ()=> Navigator.pushReplacementNamed(context, '/login'));
  }
  @override
  void dispose(){
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[
              Color(0xff4394ff),
              Color(0xff224a80),
            ]
          ),

        ),
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment(0, -0.8),
              child: Container(
                width: width*0.5,
                height: (height >= 1000 && width >= 650 ) ? height*0.08 : height*0.05,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/text.png'),
                    fit: BoxFit.fill
                  )
                ),
              ), 
            ),
            Align(
              alignment: Alignment(0.0, 1.0),
              child: Container(
                width: width,
                height: height,
                decoration: new BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/screen_splashscreen.png'),
                    fit: BoxFit.fill
                ),
                ),
              )
              //Image.asset('assets/images/capit-screen.png',width: 1000,height: 1000,),
            ),
          ],
        )
      )
    );
  }
}
