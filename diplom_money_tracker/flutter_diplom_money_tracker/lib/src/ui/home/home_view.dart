import 'package:flutter/material.dart';
import 'package:flutter_diplom_money_tracker/src/ui/category_view/category_view.dart';
import 'package:flutter_diplom_money_tracker/src/ui/home/month_view.dart';

import 'package:flutter_diplom_money_tracker/src/ui/not_found_view/not_found_view.dart';
import 'package:flutter_diplom_money_tracker/src/ui/profile/profile_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key, required this.title});

  final String title;

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late PageController _pageController;

  int _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentPageIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: PageView(
          controller: _pageController,
          children: const [
            HomeViewBody(),
            ProfileView(),
          ],
          onPageChanged: (index) {
            setState(() {
              _currentPageIndex = index;
            });
          },
        ),
        bottomNavigationBar: BottomNavigationBar(
            onTap: (index) {
              setState(() {
                _currentPageIndex = index;
                _pageController.animateToPage(_currentPageIndex,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.linear);
              });
            },
            currentIndex: _currentPageIndex,
            selectedItemColor: const Color(0xFF9053EB),
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.credit_card,
                  ),
                  label: 'Расходы'),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.person,
                  ),
                  label: 'Профиль'),
            ]),
      ),
    );
  }
}

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: MonthView.routeName,
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case CategoryView.routeName:
            final args = settings.arguments as Map<String, dynamic>;
            if (args.containsKey('categoryName')) {
              return MaterialPageRoute(
                builder: (_) => CategoryView(
                    categoryName: args['categoryName'],
                    categoryColor: args['categoryColor']),
              );
            }
            return MaterialPageRoute(
              builder: (_) => const NotFoundView(),
            );
          case MonthView.routeName:
            return MaterialPageRoute(
              builder: (_) => const MonthView(),
            );

          default:
            return MaterialPageRoute(
              builder: (_) => const NotFoundView(),
            );
        }
      },
    );
  }
}
