part of 'components.dart';

class SideMenu extends StatelessWidget {
  SideMenu({Key? key}) : super(key: key);
  final AuthController _authc = AuthController.to;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            child: FlutterLogo(size: 100),
          ),
          DrawerListTile(
            press: () async {
              await _authc.logout(context);
              Get.offAllNamed('/login');
            },
            svgSrc: Icons.logout,
            title: 'Logout',
          ),
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    required this.title,
    required this.svgSrc,
    required this.press,
  }) : super(key: key);

  final String title;
  final IconData svgSrc;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0,
      leading: Icon(
        svgSrc,
        size: 16,
        color: Colors.black,
      ),
      title: Text(
        title,
        style: const TextStyle(color: Colors.black),
      ),
    );
  }
}
