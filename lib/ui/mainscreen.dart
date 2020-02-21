import 'package:flutter/material.dart';
import 'package:prototype_ws_momoka/ui/home.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  

  final pages = [
    Home(),
    Home(),
    Home(),
    Home(),
    Home(),
  ];

  int selectedIndex = 0;

  void onTap(int index){
    setState(()=>selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //membuat objek dari kelas BottomNavigationBar
      bottomNavigationBar: BottomNavigationBar(
        elevation: 10.0,
        items: <BottomNavigationBarItem> [
          BottomNavigationBarItem(
            icon: Image.asset(
              (selectedIndex == 0) ? 'assets/images/active_icon/home.png' : 'assets/images/non_active_icon/home.png',
              width: MediaQuery.of(context).size.width/16,
            ),
            title: Text('Home',style: TextStyle(fontSize: 12.0),)
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              (selectedIndex == 1) ? 'assets/images/active_icon/games.png' : 'assets/images/non_active_icon/games.png',
              width: MediaQuery.of(context).size.width/17,
            ),
            title: Text('Game',style: TextStyle(fontSize: 12.0),)
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              (selectedIndex == 2) ? 'assets/images/active_icon/leaderboard.png' : 'assets/images/non_active_icon/leaderboard.png',
              width: MediaQuery.of(context).size.width/17,
            ),
            title: Text('Leaderboard',style: TextStyle(fontSize: 12.0),)
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              (selectedIndex == 3) ? 'assets/images/active_icon/reward.png' : 'assets/images/non_active_icon/reward.png',
              width: MediaQuery.of(context).size.width/19,
            ),
            title: Text('Reward',style: TextStyle(fontSize: 12.0),)
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              (selectedIndex == 4) ? 'assets/images/active_icon/account.png' : 'assets/images/non_active_icon/account.png',
              width: MediaQuery.of(context).size.width/17.5,
            ),
            title: Text('Account',style: TextStyle(fontSize: 12.0),)
          ),
        ],
        currentIndex: selectedIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Color(0xff3c84e4),
        onTap: onTap,
        backgroundColor: Color(0xfff5f5f5),
      ),
      //membuat objek dari kelas TabBarView
      body: pages.elementAt(selectedIndex),
    );
  }
}