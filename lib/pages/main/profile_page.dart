part of '../pages.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final AuthController _authc = AuthController.to;

  String _getInitials(String bankAccountName) => bankAccountName.isNotEmpty
      ? bankAccountName
          .trim()
          .split(RegExp(' +'))
          .map((s) => s[0])
          .take(2)
          .join()
      : '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            child: CircleAvatar(
              backgroundColor: Colors.grey.shade800,
              minRadius: 50,
              maxRadius: 75,
              child: Text(
                _getInitials(_authc.user!.name).toUpperCase(),
                style: const TextStyle(fontSize: 42),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
