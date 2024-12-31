import 'package:car_rent/core/common/widgets/loader.dart';
import 'package:car_rent/core/theme/app_pallete.dart';
import 'package:car_rent/core/utils/show_snackbar.dart';
import 'package:car_rent/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:car_rent/features/auth/presentation/pages/signup_page.dart';
import 'package:car_rent/features/auth/presentation/widgets/auth_field.dart';
import 'package:car_rent/features/auth/presentation/widgets/auth_gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogInPage extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const LogInPage(),
      );
  const LogInPage({Key? key}) : super(key: key);

  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    super.dispose();
  }

  bool _isObscured = true;

  void _toggleObscurity() {
    setState(() {
      _isObscured = !_isObscured;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/greenbg2.jpg'),
            fit: BoxFit.cover, // Ensures the image covers the entire background
            colorFilter: ColorFilter.mode(
              Colors.transparent, // Adds a greenish overlay
              BlendMode.darken, // Adjust the blend mode to suit the design
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthFailure) {
                showSnackbar(context, state.message);
              }
            },
            builder: (context, state) {
              if (state is AuthLoading) {
                return const FancyLoader();
              }
              return Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Sign In',
                      style: TextStyle(
                          fontSize: 39,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    const SizedBox(height: 30),
                    AuthField(
                      hintText: "Email",
                      controller: emailController,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    AuthField(
                      hintText: "Password",
                      controller: passwordController,
                      isObscureText: _isObscured,
                      suffixIcon: IconButton(
                          icon: Icon(
                            _isObscured
                                ? Icons.visibility_off
                                : Icons.visibility_sharp,
                            color: Colors.grey,
                          ),
                          onPressed: _toggleObscurity),
                    ),
                    const SizedBox(height: 20),
                    AuthGradientButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          context.read<AuthBloc>().add(
                                AuthSignIn(
                                    email: emailController.text.trim(),
                                    password: passwordController.text.trim()),
                              );
                        }
                      },
                      buttonText: 'Sign In',
                    ),
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, SignupPage.route());
                      },
                      child: RichText(
                        text: TextSpan(
                          text: 'Don\'t have an account? ',
                          style: Theme.of(context).textTheme.titleMedium,
                          children: [
                            TextSpan(
                              text: 'Sign Up',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    color: AppPalette.primaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
