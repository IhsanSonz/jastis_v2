part of '../pages.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final store = GetStorage();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  final AuthController _authc = AuthController.to;

  bool _passwordVisible = false;

  Future _register(context) async {
    if (_formKey.currentState!.validate()) {
      ResponseModel<UserModel> response = await _authc.register(context);
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
            FlutterLogo(size: MediaQuery.of(context).size.height / 3),
            const SizedBox(height: 40),
            Form(
              key: _formKey,
              child: AutofillGroup(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: _authc.nameController,
                      keyboardType: TextInputType.name,
                      autofillHints: const [AutofillHints.newUsername],
                      decoration: const InputDecoration(
                        labelText: 'Username',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                        filled: true,
                        fillColor: Color(0xFFE5E5E5),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Username can\'t be empty';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: Constants.kDefaultPadding - 2),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          controller: _authc.emailController,
                          keyboardType: TextInputType.emailAddress,
                          autofillHints: const [AutofillHints.email],
                          decoration: const InputDecoration(
                            labelText: 'Email',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                            ),
                            filled: true,
                            fillColor: Color(0xFFE5E5E5),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Email can\'t be empty';
                            } else if (!value.isEmail) {
                              return 'Please input a valid email format';
                            }
                            return null;
                          },
                        )
                      ],
                    ),
                    const SizedBox(height: Constants.kDefaultPadding - 2),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          controller: _authc.passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          autofillHints: const [AutofillHints.newPassword],
                          decoration: InputDecoration(
                            labelText: 'Password',
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
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
                                              fontSize: 12,
                                            ),
                                      );
                                    }),
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
                _register(context);
              },
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  vertical: Constants.kDefaultPadding,
                ),
                backgroundColor: Constants.kPrimaryColor,
              ),
              child: const Text(
                'Register',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: Constants.kDefaultPadding),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Already have an account?'),
                  const SizedBox(width: 4),
                  GestureDetector(
                    onTap: () => Get.toNamed('/login'),
                    child: const Text(
                      'Login',
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
