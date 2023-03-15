import 'package:flutter/material.dart';
import 'package:flutter_diplom_money_tracker/src/ui/home/costs_view.dart';
import 'package:flutter_diplom_money_tracker/src/ui/home/month_view.dart';
import 'package:flutter_diplom_money_tracker/src/ui/modals/add_category_modal.dart';
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

  void openModalWindow() {
    showDialog(
      context: context,
      builder: (context) {
        return const AddCategoryModal();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          backgroundColor: const Color(0xFF9053EB),
          actions: [
            IconButton(
                onPressed: () {
                  openModalWindow();
                },
                icon: const Icon(Icons.add))
          ],
        ),
        body: PageView(
          controller: _pageController,
          children: const [HomeViewBody(), ProfileView()],
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
                  label: 'Профиль')
            ]),
      ),
    );
  }
}

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const <Widget>[
        Expanded(flex: 4, child: MonthView()),
        Expanded(flex: 5, child: CostsView())
      ],
    );
  }
}
