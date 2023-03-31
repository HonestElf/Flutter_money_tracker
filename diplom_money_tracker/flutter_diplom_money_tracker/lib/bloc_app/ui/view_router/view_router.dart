import 'package:flutter/material.dart';
import 'package:flutter_diplom_money_tracker/bloc_app/ui/details_view/details_view.dart';
import 'package:flutter_diplom_money_tracker/bloc_app/ui/home_view/home_view.dart';
import 'package:flutter_diplom_money_tracker/bloc_app/ui/not_found_view/not_found_view.dart';
import 'package:flutter_diplom_money_tracker/bloc_app/ui/profile_view/profile_view.dart';

class ViewRouter extends StatefulWidget {
  const ViewRouter({
    super.key,
  });

  @override
  State<ViewRouter> createState() => _ViewRouterState();
}

class _ViewRouterState extends State<ViewRouter> {
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
        body: _pageView(),
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

  Widget _pageView() {
    return PageView(
      controller: _pageController,
      children: const [
        ViewRouterBody(),
        ProfileView(),
      ],
      onPageChanged: (index) {
        setState(() {
          _currentPageIndex = index;
        });
      },
    );
  }
}

class ViewRouterBody extends StatelessWidget {
  const ViewRouterBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: HomeView.routeName,
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case HomeView.routeName:
            return MaterialPageRoute(
              builder: (_) => const HomeView(),
            );

          case DetailsView.routeName:
            final args = settings.arguments as Map<String, dynamic>;
            if (args.containsKey('categoryName')) {
              return MaterialPageRoute(
                builder: (_) => const DetailsView(
                    // chosenMonth: args['chosenMonth'],
                    // chosenYear: args['chosenYear'],
                    // categoryName: args['categoryName'],
                    // categoryColor: args['categoryColor'],
                    ),
              );
            }
            return MaterialPageRoute(
              builder: (_) => const NotFoundView(),
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
