import 'package:flutter/material.dart';
import 'package:flutter_diplom_money_tracker/src/ui/category_view/category_view.dart';
import 'package:flutter_diplom_money_tracker/src/ui/home/costs_view.dart';
import 'package:flutter_diplom_money_tracker/src/ui/home/costs_pie_chart.dart';
import 'package:flutter_diplom_money_tracker/src/ui/modals/add_category_modal.dart';
import 'package:flutter_diplom_money_tracker/src/ui/not_found_view/not_found_view.dart';
import 'package:flutter_diplom_money_tracker/src/ui/profile/profile_view.dart';
import 'package:flutter_diplom_money_tracker/src/ui/utils/month_parser.dart';

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
    return Navigator(
      initialRoute: MonthView.routeName,
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case CategoryView.routeName:
            return MaterialPageRoute(
              builder: (_) => const CategoryView(),
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

class MonthView extends StatefulWidget {
  const MonthView({super.key});
  static const routeName = 'monthView';

  @override
  State<MonthView> createState() => _MonthViewState();
}

class _MonthViewState extends State<MonthView> {
  String? chosenMonth;
  @override
  void initState() {
    super.initState();

    chosenMonth = parseMonth(DateTime.now().month);
  }

  void openAddModal() {
    showDialog(
      context: context,
      builder: (context) {
        return const AddCategoryModal();
      },
    );
  }

  void openDateModal() async {
    final chosenDate = await showDatePicker(
        initialDatePickerMode: DatePickerMode.year,
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime.now());

    if (chosenDate != null) {
      setState(() {
        chosenMonth = parseMonth(chosenDate.month);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xFF9053EB),
        titleSpacing: 0,
        title: TextButton(
            onPressed: openDateModal,
            child: Text(
              chosenMonth ?? 'Месяц не выбран',
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w700),
            )),
        actions: [
          IconButton(
              onPressed: () {
                openAddModal();
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget>[
          Expanded(flex: 4, child: CostsPieChart()),
          Expanded(flex: 5, child: CostsView())
        ],
      ),
    );
  }
}
