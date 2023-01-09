part of '../pages.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final MenuController _menuc = MenuController.to;
  final LectureController _lecturec = LectureController.to;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_handleTabSelection);
    _tabController.index = _menuc.listPageTabIndex;

    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      _menuc.onListPageTabTapped(_tabController.index);
    }
  }

  Future _leave(context, lecture) async {
    ResponseModel response = await _lecturec.leaveLecture(context, lecture);
    if (response.success) {
      Get.back();

      Get.snackbar(
        'Success',
        'Success on joinLecture',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
      );
    }
  }

  void _onLectureAction(String action, LectureModel lecture) async {
    switch (action) {
      case 'Edit':

        /// TODO LectureAction Edit
        break;
      case 'Leave':
        _leave(context, lecture);
        break;
      case 'Delete':

        /// TODO LectureAction Delete
        break;
      default:
    }
  }

  Set<String> _getLectureAction(LectureModel lecture) {
    if (lecture.role == 'student') {
      return {'Leave'};
    } else {
      return {'Edit', 'Leave', 'Delete'};
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.only(
          bottom: 30,
          left: 30,
          right: 30,
        ),
        children: [
          _buildTabBar(context),
        ],
      ),
    );
  }

  Widget _buildTabBar(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: TabBar(
            controller: _tabController,
            isScrollable: true,
            labelColor: Constants.kPrimaryColor,
            unselectedLabelColor: const Color(0xFFCDCDCD),
            indicatorColor: Constants.kPrimaryColor,
            labelStyle: Theme.of(context).textTheme.subtitle1,
            indicatorSize: TabBarIndicatorSize.label,
            tabs: const [
              Tab(text: 'Lecturing'),
              Tab(text: 'Studying'),
              Tab(text: 'Tasks'),
            ],
          ),
        ),
        Obx(() {
          return Container(
            padding: const EdgeInsets.only(top: 20),
            child: [
              _listTeachingTab(context),
              _listStudyingTab(context),
              Container(),
              // _listTasksTab(context),
            ][_menuc.listPageTabIndex],
          );
        }),
      ],
    );
  }

  Widget _listTeachingTab(BuildContext context) {
    return Obx(() {
      if (_lecturec.isLoadingLecture) {
        return const Center(child: CircularProgressIndicator());
      }
      return _lecturec.teachingLectures.isEmpty
          ? SizedBox(
              height: 36,
              child: Center(
                child: Text(
                  'You don\'t have any class yet',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ))
          : ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: _lecturec.teachingLectures.length,
              itemBuilder: (context, index) {
                return listTileKelas(
                    context, _lecturec.teachingLectures[index]);
              });
    });
  }

  Widget _listStudyingTab(BuildContext context) {
    return Obx(() {
      if (_lecturec.isLoadingLecture) {
        return const Center(child: CircularProgressIndicator());
      }
      return _lecturec.learningLectures.isEmpty
          ? SizedBox(
              height: 36,
              child: Center(
                child: Text(
                  'You haven\'t join any class yet',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ))
          : ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: _lecturec.learningLectures.length,
              itemBuilder: (context, index) {
                return listTileKelas(
                    context, _lecturec.learningLectures[index]);
              });
    });
  }

  Widget listTileKelas(BuildContext context, LectureModel lecture) {
    return GestureDetector(
      onTap: () {
        /// TODO listTileKelas action
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Card(
          elevation: 3,
          child: Container(
            width: 3,
            padding: const EdgeInsets.only(left: 10),
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(
                  color: Color(int.parse('0xFF${lecture.color}')),
                  width: 3,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      lecture.name,
                      style: Theme.of(context)
                          .textTheme
                          .caption
                          ?.copyWith(fontSize: 12),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      /// TODO penanggung jawab
                      lecture.lecturer,
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ],
                ),
                PopupMenuButton<String>(
                  padding: EdgeInsets.zero,
                  onSelected: (String action) {
                    _onLectureAction(action, lecture);
                  },
                  icon: const Icon(
                    Icons.more_vert,
                    color: Colors.black,
                  ),
                  itemBuilder: (BuildContext context) {
                    return _getLectureAction(lecture).map((String choice) {
                      return PopupMenuItem(
                        value: choice,
                        child: Text(
                          choice,
                          style: Theme.of(context).textTheme.caption,
                        ),
                      );
                    }).toList();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
