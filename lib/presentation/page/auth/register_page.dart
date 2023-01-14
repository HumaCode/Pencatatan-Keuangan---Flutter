import 'package:course_money_record/config/app_asset.dart';
import 'package:course_money_record/config/app_color.dart';
import 'package:course_money_record/config/constants.dart';
import 'package:course_money_record/data/source/source_user.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final controllerNama = TextEditingController();
  final controllerEmail = TextEditingController();
  final controllerPassword = TextEditingController();
  final formKey = GlobalKey<FormState>();

  // function login
  register() async {
    // validasi
    if (formKey.currentState!.validate()) {
      await SourceUser.register(
        controllerNama.text,
        controllerEmail.text,
        controllerPassword.text,
      );
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

                          // nama
                          TextFormField(
                            controller: controllerNama,
                            validator: (value) =>
                                value == '' ? 'Nama harus diisi.!!' : null,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            style: regular.copyWith(color: Colors.white),
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              fillColor: AppColor.primary.withOpacity(0.5),
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.r),
                                borderSide: BorderSide.none,
                              ),
                              hintText: 'Nama',
                              hintStyle: regular.copyWith(color: Colors.white),
                              isDense: true,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 20.w,
                                vertical: 16.h,
                              ),
                            ),
                          ),

                          DView.spaceHeight(),

                          // email
                          TextFormField(
                            controller: controllerEmail,
                            validator: (value) =>
                                value == '' ? 'Email harus diisi.!!' : null,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            style: regular.copyWith(color: Colors.white),
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
                            style: regular.copyWith(color: Colors.white),
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
                                onTap: () => register(),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 32.w, vertical: 16.h),
                                  child: Center(
                                    child: Text(
                                      'REGISTER',
                                      style: bold.copyWith(
                                        color: Colors.white,
                                        fontSize: 18.sp,
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
                          'Sudah punya akun..?',
                          style: regular.copyWith(
                            color: Colors.black45,
                          ),
                        ),
                        DView.spaceWidth(4.w),
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Text(
                            'Login',
                            style: bold.copyWith(
                              color: AppColor.primary.withOpacity(0.8),
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
