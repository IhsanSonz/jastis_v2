part of '../pages.dart';

class MBSPage extends StatefulWidget {
  const MBSPage({super.key});

  @override
  State<MBSPage> createState() => _MBSPageState();
}

class _MBSPageState extends State<MBSPage> {
  final LectureController _lecturec = LectureController.to;

  final _formKey = GlobalKey<FormState>();
  int prevView = 0;
  int currentView = 0;
  late List<Map> listOptions;

  Future _join(context) async {
    if (_formKey.currentState!.validate()) {
      ResponseModel response = await _lecturec.joinLecture(context);
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
  }

  @override
  void initState() {
    listOptions = [
      {
        'label': 'Join Lecture',
        'icon': Icons.developer_mode_outlined,
      },
      {
        'label': 'Create Lecture',
        'icon': Icons.adb,
      },
    ];

    super.initState();
  }

  Widget _widgetOptions(BuildContext context, index) {
    switch (index) {
      case 0:
        return _mbsOptions(context);
      case 1:
        return _joinLecture(context);
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      duration: const Duration(milliseconds: 200),
      firstChild: _widgetOptions(context, prevView),
      secondChild: _widgetOptions(context, currentView),
      crossFadeState: CrossFadeState.showSecond,
    );
  }

  Widget _mbsOptions(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Join Lecture',
                  style: Theme.of(context).textTheme.headline5,
                ),
                IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ...List.generate(
              listOptions.length,
              (index) => ListMBSOption(
                icon: listOptions[index]['icon'],
                label: listOptions[index]['label'],
                onPressed: () {
                  setState(() {
                    prevView = currentView;
                    currentView = index + 1;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _joinLecture(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(30),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Join Lecture',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              const SizedBox(height: 41),
              Center(
                child: Image.asset(
                  'assets/img/join_img.png',
                  width: 200,
                  height: 200,
                ),
              ),
              const SizedBox(height: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Lecture Code',
                    style: Theme.of(context).textTheme.caption,
                  ),
                  TextFormField(
                    controller: _lecturec.codeController,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                      filled: true,
                      fillColor: Color(0xFFE5E5E5),
                    ),
                    style: Theme.of(context).textTheme.caption,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Code can\'t be empty';
                      }
                      return null;
                    },
                  ),
                  Obx(() {
                    return _lecturec.valMsg.isNotEmpty
                        ? Column(
                            children: [
                              const SizedBox(height: 8),
                              Obx(() {
                                return Text(
                                  _lecturec.valMsg,
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption
                                      ?.copyWith(
                                          color: Colors.red, fontSize: 12),
                                );
                              })
                            ],
                          )
                        : Container();
                  }),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text(
                      'Cancel',
                      style: Theme.of(context).textTheme.caption?.copyWith(
                            color: const Color(0xFF7E7D7D),
                            fontSize: 12,
                          ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      _join(context);
                    },
                    child: Text(
                      'Join',
                      style: Theme.of(context).textTheme.caption?.copyWith(
                            color: Constants.kPrimaryColor,
                            fontSize: 12,
                          ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ListMBSOption extends StatelessWidget {
  const ListMBSOption({
    Key? key,
    required this.icon,
    required this.label,
    required this.onPressed,
  }) : super(key: key);

  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 12,
        ),
        child: Row(
          children: [
            Icon(icon),
            const SizedBox(width: 24),
            Text(
              label,
              style: Theme.of(context).textTheme.headline6,
            ),
          ],
        ),
      ),
    );
  }
}
