import 'package:conet_app/features/authentication/view_model/auth_viewmodel_provider.dart';
import 'package:conet_app/shared/button/gradient_elevated_button.dart';
import 'package:conet_app/util/constant/images.dart';
import 'package:conet_app/util/constant/sizes.dart';
import 'package:conet_app/util/constant/text_strings.dart';
import 'package:conet_app/util/helpers/helpers.dart';
import 'package:conet_app/util/validators/auth_validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  // global form key to identify the state changes in the form
  final _formKey = GlobalKey<FormState>();

  // text editing controllers
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // watch state
    final authState = ref.watch(authViewModelProvider);
    // listen error

    ref.listen(authViewModelProvider, (previous, next) {
      next.whenOrNull(
        data: (_) {
          context.goNamed('home'); // navigate to home
        },

        error: (error, stack) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(error.toString())));
        },
      );
    });
    // for dark mode switch
    final dark = AppHelpers.isDarkMode(context);
    return Scaffold(
      body: Form(
        key: _formKey,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 40,
              vertical: AppSize.defaultPadding,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 40),

                  /// Illustration
                  Image.asset(
                    dark ? Appimages.logonImgDark : Appimages.loginImg,
                  ),

                  const SizedBox(height: 40),

                  /// Email Field
                  TextFormField(
                    controller: emailController,
                    validator: AuthValidators.email,
                    decoration: InputDecoration(hintText: "Email"),
                  ),

                  const SizedBox(height: 20),

                  /// Password Field
                  TextFormField(
                    controller: passwordController,
                    validator: AuthValidators.password,
                    obscureText: true,
                    decoration: InputDecoration(hintText: "Password"),
                  ),

                  const SizedBox(height: 10),

                  /// Forgot password
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: const Text("forgot password?"),
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// Login Button..........
                  SizedBox(
                    width: 350,
                    child: GradientElevatedButton(
                      onPressed: authState.isLoading
                          ? null
                          : () async {
                              if (_formKey.currentState!.validate()) {
                                final email = emailController.text.trim();
                                final password = passwordController.text.trim();

                                await ref
                                    .read(authViewModelProvider.notifier)
                                    .login(email: email, password: password);
                              }
                            },

                      height: 65,
                      borderRadius: 20,

                      child: authState.isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : Text(
                              AppTexts.login,
                              style: Theme.of(context).textTheme.titleLarge!
                                  .copyWith(color: Colors.white),
                            ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  /// Signup redirect
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(AppTexts.loginQn),
                      GestureDetector(
                        onTap: () {
                          context.pushNamed('createAcc');
                        },
                        child: const Text(
                          " SignUp",
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
