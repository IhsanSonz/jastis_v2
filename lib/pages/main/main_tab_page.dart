part of '../pages.dart';

class MainTabPage extends StatefulWidget {
  const MainTabPage({super.key});

  @override
  State<MainTabPage> createState() => _MainTabPageState();
}

class _MainTabPageState extends State<MainTabPage> {
  final MenuController _menuc = MenuController.to;
  final LectureController _lecturec = LectureController.to;

  Widget _widgetOptions(BuildContext context) {
    return Obx(() {
      switch (_menuc.mainTabIndex) {
        case 0:
          return const HomePage();
        case 1:
          return const ListPage();
        default:
          return Container();
      }
    });
  }

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () async {
      _getLectures();
    });
  }

  Future _getLectures() async {
    _lecturec.getLectures(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _menuc.scaffoldKey,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(
            Icons.menu,
            color: Colors.black,
          ),
          onPressed: () => _menuc.scaffoldKey.currentState!.openDrawer(),
        ),
        title: Text(
          'Jastis',
          style: Theme.of(context).textTheme.headline5,
        ),
      ),
      drawer: SideMenu(),
      body: _widgetOptions(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _joinMBS(context);
        },
        heroTag: 'main-tab',
        tooltip: 'Create',
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list_alt),
              label: 'List',
            ),
          ],
          currentIndex: _menuc.mainTabIndex,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
          onTap: (index) => _menuc.onTabTapped(index),
        ),
      ),
    );
  }

  void _joinMBS(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
      ),
      builder: (builder) {
        return const MBSPage();
      },
    );
  }
}
