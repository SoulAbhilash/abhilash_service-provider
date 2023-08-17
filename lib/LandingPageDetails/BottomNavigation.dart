import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class BottomNavigationScreen extends ConsumerStatefulWidget {
  const BottomNavigationScreen({super.key});

  @override
  ConsumerState<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends ConsumerState<BottomNavigationScreen> {

  String status = " ";

  late StreamSubscription subscription;

  int _selectedIndex = 0;
  String _currentPage = "Page1";
  List<String> pageKeys = ["Page1", "Page2", "Page3", "Page4", "Page5"];
  final Map<String, GlobalKey<NavigatorState>> _navigatorKeys = {
    "Page1": GlobalKey<NavigatorState>(),
    "Page2": GlobalKey<NavigatorState>(),
    "Page3": GlobalKey<NavigatorState>(),
    "Page4": GlobalKey<NavigatorState>(),
    "Page5": GlobalKey<NavigatorState>(),
  };

  void _selectTab(String tabItem, int index) {
    if (tabItem == _currentPage) {
      _navigatorKeys[tabItem]!.currentState!.popUntil((route) => route.isFirst);
    } else {
      setState(() {
        _currentPage = pageKeys[index];
        _selectedIndex = index;
      });
    }
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  final bottomNavProvider = ChangeNotifierProvider((ref) => bottomNavNotifier(1));

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        final isFirstRouteInCurrentTab =!await _navigatorKeys[_currentPage]!.currentState!.maybePop();
        if (isFirstRouteInCurrentTab) {
          if (_currentPage != "Page1") {
            _selectTab("Page1", 0);
            return false;
          }
        }
        return isFirstRouteInCurrentTab;
    },
        child: Consumer(
          builder: (BuildContext context, WidgetRef ref, Widget? child)
          {
            return Scaffold(
              bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.white,
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(
                        Icons.home_outlined,
                        size: 40,
                      ),
                  label: 'Home'
                  ),
                  BottomNavigationBarItem(
                      icon: Icon(
                        Icons.book_outlined,
                        size: 40,
                      ),
                      label: 'Bookings'
                  ),
                  BottomNavigationBarItem(
                      icon: Icon(
                        Icons.spa,
                        size: 40,
                      ),
                      label: 'CarSpa'
                  ),
                  BottomNavigationBarItem(
                      icon: Icon(
                        Icons.miscellaneous_services,
                        size: 40,
                      ),
                      label: 'Service'
                  )
                ],
                currentIndex: _selectedIndex,
                onTap: (int index){
                  _selectTab(pageKeys[index], index);
                },
                backgroundColor: Colors.green,
              ),
              body: Stack(
                children: [
                  _buildOffstageNavigator("Page1"),
                  _buildOffstageNavigator("Page2"),
                  _buildOffstageNavigator("Page3"),
                  _buildOffstageNavigator("Page4"),
                  //  _buildOffstageNavigator("Page5"),
                ],
              ),
            );
          },
        ),
    );
  }

  Widget _buildOffstageNavigator(String tabItem) {
    return Offstage(
      offstage: _currentPage !=tabItem,
      child: TabNavigator(
        navigatorKey: _navigatorKeys[tabItem]!,
        tabItem: tabItem,
      ),
    );
  }
}


class TabNavigator extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  final String tabItem;

  const TabNavigator(
      {Key? key, required this.navigatorKey, required this.tabItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget child = LandingScreen();

    if(tabItem=="Page1")
      child= LandingScreen();
    else if(tabItem=="Page2")
    child=NewScreen2();
    else if(tabItem=="Page3")
      child=NewScreen3();
    else if(tabItem=="Page4")
      child=NewScreen4();

    return Navigator(
      key: navigatorKey,
      onGenerateRoute: (routeSettings){
        return MaterialPageRoute(builder: (context) => child);
      },
    );

  }
}

class NewScreen4 extends StatelessWidget {
  const NewScreen4({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NEW SCREEN 4',style: GoogleFonts.vesperLibre()),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Text('PAGE 4',style: GoogleFonts.vesperLibre(
            fontSize: 30
        )),
      ),
    );
  }
}

class NewScreen3 extends StatelessWidget {
  const NewScreen3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NEW SCREEN 3',style: GoogleFonts.vesperLibre()),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Text('PAGE 3',style: GoogleFonts.vesperLibre(
            fontSize: 30
        )),
      ),
    );
  }
}

class NewScreen2 extends StatelessWidget {
  const NewScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NEW SCREEN 2',style: GoogleFonts.vesperLibre()),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Text('PAGE 2',style: GoogleFonts.vesperLibre(
            fontSize: 30
        )),
      ),
    );
  }
}

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LANDING PAGE',style: GoogleFonts.vesperLibre()),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Text('PAGE 1',style: GoogleFonts.vesperLibre(
            fontSize: 30
        )),
      ),
    );
  }
}


class bottomNavNotifier extends ChangeNotifier {
  bottomNavNotifier(int index) :_index = index;
  int _index = 0;
  int get index => _index;
  set setValue(int index) {
    _index = index;
    notifyListeners();
  }
}
