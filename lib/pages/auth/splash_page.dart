part of '../pages.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final splashDelay = 1;

  @override
  void initState() {
    super.initState();

    _loadWidget();
  }

  _loadWidget() async {
    var duration = Duration(seconds: splashDelay);
    return Timer(duration, () => Get.offAndToNamed('/login'));
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          SizedBox(
            height: 500,
            child: FlutterLogo(size: 150),
          ),
          CircularProgressIndicator(),
        ],
      ),
    );
  }
}
