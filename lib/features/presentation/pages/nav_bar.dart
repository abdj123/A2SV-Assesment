import 'package:flutter/material.dart';
import 'package:groceries_app/features/presentation/pages/home_page.dart';
import 'package:groceries_app/features/presentation/pages/mycarts_page.dart';

class LandingPage extends StatefulWidget {
  static const String routes = '/landing_page';
  // final bool isLogedIn;
  const LandingPage({
    super.key,
  });

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  int currentTab = 0;

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = const HomePage();

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      const HomePage(),
      const MyCArtsPage(),
    ];
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).colorScheme.tertiary,
      body: PageStorage(
        bucket: bucket,
        child: screens[currentTab],
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 10,
        color: Colors.white,
        shape: const CircularNotchedRectangle(),
        child: SizedBox(
          height: 50.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  setState(() {
                    currentTab = 0;
                  });
                },
                child: currentTab == 0
                    ? Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color(0xFF494950),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(10),
                          child: Icon(
                            Icons.home_rounded,
                            color: Colors.white,
                          ),
                        ),
                      )
                    : Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.transparent,
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Icon(
                            Icons.home_rounded,
                            // color: Colors.white,
                          ),
                        ),
                      ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    currentTab = 1;
                  });
                },
                child: currentTab == 1
                    ? Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xFF494950),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(10),
                          child: Icon(
                            Icons.shopping_bag_outlined,
                            color: Colors.white,
                          ),
                        ),
                      )
                    : Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.transparent),
                        child: const Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Icon(
                            Icons.shopping_bag_outlined,
                          ),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
