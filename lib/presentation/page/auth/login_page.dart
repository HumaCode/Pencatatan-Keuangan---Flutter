import 'package:course_money_record/config/app_asset.dart';
import 'package:course_money_record/config/app_color.dart';
import 'package:course_money_record/config/constants.dart';
import 'package:course_money_record/data/source/source_user.dart';
import 'package:course_money_record/presentation/page/auth/register_page.dart';
import 'package:course_money_record/presentation/page/home_page.dart';
import 'package:d_info/d_info.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
  login() async {
    // validasi
    if (formKey.currentState!.validate()) {
      bool success = await SourceUser.login(
        controllerEmail.text,
        controllerPassword.text,
      );

      // tampilkan dialog
      if (success) {
        // ignore: use_build_context_synchronously
        DInfo.dialogSuccess('Berhasil login..');
        // ignore: use_build_context_synchronously
        DInfo.closeDialog(actionAfterClose: () {
          Get.off(() => const HomePage());
        });
      } else {
        // ignore: use_build_context_synchronously
        DInfo.dialogError('Gagal login..');
        // ignore: use_build_context_synchronously
        DInfo.closeDialog();
      }
    }
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
                      padding: EdgeInsets.symmetric(horizontal: 30.w),
                      child: Column(
                        children: [
                          Image.asset(AppAsset.logo),
                          DView.spaceHeight(40.h),

                          // email
                          TextFormField(
                            controller: controllerEmail,
                            validator: (value) =>
                                value == '' ? 'Email harus diisi.!!' : null,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: Colors.white,
                            ),
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              fillColor: AppColor.primary.withOpacity(0.5),
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.r),
                                borderSide: BorderSide.none,
                              ),
                              hintText: 'Email',
                              hintStyle: regular.copyWith(color: Colors.white),
                              isDense: true,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 20.w,
                                vertical: 16.h,
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
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: Colors.white,
                            ),
                            keyboardType: TextInputType.text,
                            obscureText: true,
                            decoration: InputDecoration(
                              fillColor: AppColor.primary.withOpacity(0.5),
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.r),
                                borderSide: BorderSide.none,
                              ),
                              hintText: 'Password',
                              isDense: true,
                              hintStyle: regular.copyWith(color: Colors.white),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 20.w,
                                vertical: 16.h,
                              ),
                            ),
                          ),

                          DView.spaceHeight(30.h),

                          // Tombol Login
                          SizedBox(
                            width: double.infinity,
                            child: Material(
                              color: AppColor.primary,
                              borderRadius: BorderRadius.circular(30.r),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(30.r),
                                onTap: () => login(),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 32.w, vertical: 16.h),
                                  child: Center(
                                    child: Text(
                                      'LOGIN',
                                      style: bold.copyWith(
                                        color: Colors.white,
                                        fontSize: 20.sp,
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
                        Text(
                          'Belum punya akun..?',
                          style: regular.copyWith(
                            color: Colors.black45,
                          ),
                        ),
                        DView.spaceWidth(4.w),
                        GestureDetector(
                          onTap: () {
                            Get.to(() => const RegisterPage());
                          },
                          child: Text(
                            'Register',
                            style: bold.copyWith(
                              color: AppColor.primary.withOpacity(0.8),
                              fontWeight: FontWeight.bold,
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
