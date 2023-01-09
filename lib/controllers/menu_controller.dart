part of 'controllers.dart';

class MenuController extends GetxController {
  final _scaffoldKey = GlobalKey<ScaffoldState>().obs;
  static MenuController to = Get.find();

  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey.value;

  final _mainTabIndex = 0.obs;
  final _listPageTabIndex = 0.obs;
  final _currentDate = DateTime.now().obs;

  int get mainTabIndex => _mainTabIndex.value;
  int get listPageTabIndex => _listPageTabIndex.value;
  DateTime get currentDate => _currentDate.value;

  void onTabTapped(int index) {
    _mainTabIndex.value = index;
  }

  void onListPageTabTapped(int index) {
    _listPageTabIndex.value = index;
  }

  void setCurrentDate(DateTime newDate) {
    _currentDate.value = newDate;
  }
}
