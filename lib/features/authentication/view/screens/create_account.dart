import 'package:conet_app/features/authentication/view_model/auth_viewmodel_provider.dart';
import 'package:conet_app/common/gradient_elevated_button.dart';
import 'package:conet_app/util/constant/images.dart';
import 'package:conet_app/util/constant/sizes.dart';
import 'package:conet_app/util/constant/text_strings.dart';
import 'package:conet_app/util/helpers/helpers.dart';
import 'package:conet_app/util/validators/auth_validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CreateAccount extends ConsumerStatefulWidget {
  const CreateAccount({super.key});

  @override
  ConsumerState<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends ConsumerState<CreateAccount> {
  // global form key to identify the state changes in the form
  final _formKey = GlobalKey<FormState>();
  // text editing controllers
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final TextEditingController nameController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    nameController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();

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
          context.goNamed('interest'); // navigate to onboarding
        },

        error: (error, stack) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(error.toString())));
        },
      );
    });
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
                    dark ? Appimages.createAccImgDark : Appimages.createAccImg,
                    width: 300,
                  ),

                  const SizedBox(height: 40),

                  /// name Field
                  TextFormField(
                    controller: nameController,
                    validator: AuthValidators.name,
                    decoration: InputDecoration(hintText: "Name"),
                  ),
                  const SizedBox(height: 20),

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

                  const SizedBox(height: 20),

                  /// create acc Button
                  SizedBox(
                    width: 350,
                    child: GradientElevatedButton(
                      onPressed: authState.isLoading
                          ? null
                          : () async {
                              if (_formKey.currentState!.validate()) {
                                final name = nameController.text.trim();
                                final email = emailController.text.trim();
                                final password = passwordController.text.trim();

                                await ref
                                    .read(authViewModelProvider.notifier)
                                    .signup(
                                      email: email,
                                      password: password,
                                      name: name,
                                      interests: [],
                                      skillsToTeach: [],
                                      skillsToLearn: [],
                                    );
                              }
                            },

                      height: 65,
                      borderRadius: 20,
                      child: authState.isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : Text(
                              AppTexts.createAcc,
                              style: Theme.of(context).textTheme.titleLarge!
                                  .copyWith(color: Colors.white),
                            ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  /// login redirect
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(AppTexts.accountQn),
                      GestureDetector(
                        onTap: () {
                          context.pushNamed('login');
                        },
                        child: const Text(
                          " Login",
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
