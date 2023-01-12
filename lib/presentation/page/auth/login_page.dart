import 'package:course_money_record/config/app_asset.dart';
import 'package:course_money_record/config/app_color.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final controllerEmail = TextEditingController();
  final controllerPassword = TextEditingController();
  final formKey = GlobalKey<FormState>();

  // function login
  login() {
    // validasi
    if (formKey.currentState!.validate()) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bg,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DView.nothing(),

                  // form
                  Form(
                    key: formKey,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Column(
                        children: [
                          Image.asset(AppAsset.logo),
                          DView.spaceHeight(40),

                          // email
                          TextFormField(
                            controller: controllerEmail,
                            validator: (value) =>
                                value == '' ? 'Email harus diisi.!!' : null,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              fillColor: AppColor.primary.withOpacity(0.5),
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide.none,
                              ),
                              hintText: 'Email',
                              hintStyle: const TextStyle(color: Colors.white),
                              isDense: true,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 16,
                              ),
                            ),
                          ),

                          DView.spaceHeight(),

                          // password
                          TextFormField(
                            controller: controllerPassword,
                            validator: (value) =>
                                value == '' ? 'Password harus diisi.!!' : null,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                            keyboardType: TextInputType.text,
                            obscureText: true,
                            decoration: InputDecoration(
                              fillColor: AppColor.primary.withOpacity(0.5),
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide.none,
                              ),
                              hintText: 'Password',
                              isDense: true,
                              hintStyle: const TextStyle(color: Colors.white),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 16,
                              ),
                            ),
                          ),

                          DView.spaceHeight(30),

                          // Tombol Login
                          SizedBox(
                            width: double.infinity,
                            child: Material(
                              color: AppColor.primary,
                              borderRadius: BorderRadius.circular(30),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(30),
                                onTap: () => login(),
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 32, vertical: 16),
                                  child: Center(
                                    child: Text(
                                      'LOGIN',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Belum punya akun..?',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        DView.spaceWidth(4),
                        GestureDetector(
                          onTap: () {},
                          child: const Text(
                            'Register',
                            style: TextStyle(
                              color: AppColor.primary,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
