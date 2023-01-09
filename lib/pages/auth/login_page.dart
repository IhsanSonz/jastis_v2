part of '../pages.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  final AuthController _authc = AuthController.to;

  bool _passwordVisible = false;

  Future _login(context) async {
    if (_formKey.currentState!.validate()) {
      ResponseModel<UserModel> response = await _authc.login(context);
      if (response.success) {
        Get.toNamed('/home');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 38),
          children: [
            const SizedBox(height: 80),
            FlutterLogo(size: 173),
            const SizedBox(height: 40),
            Form(
              key: _formKey,
              child: AutofillGroup(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: _authc.emailController,
                      autofillHints: const [AutofillHints.email],
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        filled: true,
                        fillColor: Color(0xFFE5E5E5),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Email can\'t be empty';
                        } else if (!value.isEmail) {
                          return 'Please input a valid email address';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: Constants.kDefaultPadding - 2),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          controller: _authc.passwordController,
                          autofillHints: const [AutofillHints.password],
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            filled: true,
                            fillColor: const Color(0xFFE5E5E5),
                            suffixIcon: IconButton(
                              icon: _passwordVisible
                                  ? const Icon(Icons.visibility)
                                  : const Icon(Icons.visibility_off),
                              iconSize: 24,
                              onPressed: () {
                                setState(() {
                                  _passwordVisible = !_passwordVisible;
                                });
                              },
                            ),
                          ),
                          obscureText: !_passwordVisible,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Password can\'t be empty';
                            }
                            return null;
                          },
                        ),
                        Obx(() {
                          return _authc.valMsg.value.isNotEmpty
                              ? Column(
                                  children: [
                                    const SizedBox(height: 8),
                                    Obx(() {
                                      return Text(
                                        _authc.valMsg.value,
                                        style: Theme.of(context)
                                            .textTheme
                                            .caption
                                            ?.copyWith(
                                                color: Colors.red,
                                                fontSize: 12),
                                      );
                                    })
                                  ],
                                )
                              : Container();
                        }),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: Constants.kDefaultPadding * 2),
            OutlinedButton(
              onPressed: () {
                FocusScope.of(context).requestFocus(FocusNode());
                _login(context);
              },
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  vertical: Constants.kDefaultPadding,
                ),
                backgroundColor: Constants.kPrimaryColor,
              ),
              child: const Text(
                'Login',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: Constants.kDefaultPadding - 2),
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  vertical: Constants.kDefaultPadding,
                ),
                side: const BorderSide(color: Colors.black, width: 1),
              ),
              child: const Text(
                'Sign in with Google',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: Constants.kDefaultPadding),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Don\'t have an account?'),
                  const SizedBox(width: 4),
                  GestureDetector(
                    onTap: () => Get.toNamed('/register'),
                    child: const Text(
                      'Register',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: Constants.kDefaultPadding),
          ],
        ),
      ),
    );
  }
}
