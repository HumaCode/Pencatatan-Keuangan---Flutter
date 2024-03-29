import 'package:course_money_record/config/app_color.dart';
import 'package:course_money_record/config/session.dart';
import 'package:course_money_record/data/model/user.dart';
import 'package:course_money_record/presentation/page/auth/login_page.dart';
import 'package:course_money_record/presentation/page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initializeDateFormatting('id_ID').then((value) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 640),
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData.light().copyWith(
            primaryColor: AppColor.primary,
            colorScheme: const ColorScheme.light(
              primary: AppColor.primary,
              secondary: AppColor.secondary,
            ),
            appBarTheme: const AppBarTheme(
              backgroundColor: AppColor.primary,
              foregroundColor: Colors.white,
            ),
          ),
          home: FutureBuilder(
            // cek session
            future: Session.getUser(),
            builder: (context, AsyncSnapshot<User> snapshot) {
              if (snapshot.data != null && snapshot.data!.idUser != null) {
                // jika ada maka akan di arahkan ke halaman home
                return const HomePage();
              } else {
                return const LoginPage();
                // jika tidak ada maka akan diaragkan ke halaman login
              }
            },
          ),
        );
      },
    );
  }
}
