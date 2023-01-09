part of '../pages.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final MenuController _menuc = MenuController.to;
  DateFormat dateFormat = DateFormat('MMM yyyy');
  late String currentDateString;

  DateTime now = DateTime.now();
  List<int> thisWeekday = [];
  var days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
  var daysFull = [
    '',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];

  @override
  void initState() {
    super.initState();

    int currentDay = _menuc.currentDate.weekday;
    DateTime sunday = currentDay != 7
        ? _menuc.currentDate.subtract(Duration(days: currentDay))
        : _menuc.currentDate;

    for (int i = 0; i <= 6; i++) {
      thisWeekday.add(sunday.add(Duration(days: i)).day);
    }
    currentDateString = dateFormat.format(_menuc.currentDate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _homeListView(),
    );
  }

  ListView _homeListView() {
    DateFormat dateFormat = DateFormat('E');
    String today = dateFormat.format(now);

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        _daysListView(today),
        ..._todayTasks(),
      ],
    );
  }

  SizedBox _daysListView(String today) {
    return SizedBox(
      height: 80,
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        children: [
          ...List.generate(
            days.length,
            (index) {
              return Obx(
                () {
                  bool current =
                      days[index] == DateFormat('E').format(_menuc.currentDate);
                  return GestureDetector(
                    onTap: () {
                      _menuc.setCurrentDate(_menuc.currentDate.add(
                        Duration(
                            days: thisWeekday[index] - _menuc.currentDate.day),
                      ));
                    },
                    child: SizedBox(
                      width: 55,
                      child: Card(
                        color: current
                            ? const Color(0xFFD1C5F1).withOpacity(.3)
                            : Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Center(
                          child: Text('${days[index]}\n${thisWeekday[index]}',
                              textAlign: TextAlign.center,
                              style:
                                  Theme.of(context).textTheme.caption?.copyWith(
                                        color: current
                                            ? Constants.kPrimaryColor
                                            : Colors.grey,
                                      )),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  List _todayTasks() {
    return [
      Obx(
        () => ListTile(
          dense: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: 6),
          title: Text(
            now.isSameDate(_menuc.currentDate)
                ? 'Today\'s Task'
                : '${daysFull[_menuc.currentDate.weekday]}\'s Task',
            style: Theme.of(context).textTheme.headline2,
          ),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () {
            /// TODO Home Task Tab tapped
          },
        ),
      ),
      // _todayTasksListView(),
    ];
  }
}
