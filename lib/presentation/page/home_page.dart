import 'package:course_money_record/config/app_asset.dart';
import 'package:course_money_record/config/app_color.dart';
import 'package:course_money_record/config/app_format.dart';
import 'package:course_money_record/config/constants.dart';
import 'package:course_money_record/config/session.dart';
import 'package:course_money_record/presentation/controller/c_home.dart';
import 'package:course_money_record/presentation/controller/c_user.dart';
import 'package:course_money_record/presentation/page/auth/login_page.dart';
import 'package:course_money_record/presentation/page/history/add_history_page.dart';
import 'package:course_money_record/presentation/page/history/detail_history_page.dart';
import 'package:course_money_record/presentation/page/history/history_page.dart';
import 'package:course_money_record/presentation/page/history/income_outcome_page.dart';
import 'package:d_chart/d_chart.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // inisialisasi controller
  final cUser = Get.put(CUser());
  final cHome = Get.put(CHome());

  @override
  void initState() {
    cHome.getAnalisis(cUser.data.idUser!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer
      endDrawer: drawer(),

      // body
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 50, 20, 30),
            child: Row(
              children: [
                Image.asset(AppAsset.profile),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hi,',
                        style: bold.copyWith(
                          fontSize: 20.sp,
                        ),
                      ),
                      Obx(
                        () {
                          return Text(
                            cUser.data.name ?? '',
                            style: bold.copyWith(
                              fontSize: 18.sp,
                              color: Colors.black54,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),

                // tombol
                Builder(
                  builder: (ctx) {
                    return Material(
                      color: AppColor.chart,
                      borderRadius: BorderRadius.circular(4.r),
                      child: InkWell(
                        onTap: () {
                          Scaffold.of(ctx).openEndDrawer();
                        },
                        borderRadius: BorderRadius.circular(4.r),
                        child: Padding(
                          padding: EdgeInsets.all(10.w),
                          child: const Icon(
                            Icons.menu,
                            color: AppColor.primary,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                cHome.getAnalisis(cUser.data.idUser!);
              },
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
                children: [
                  Text(
                    "Pengeluaran hari ini",
                    style: bold.copyWith(
                      fontSize: 20.sp,
                    ),
                  ),
                  DView.spaceHeight(),

                  // card pengeluaran hari ini
                  cardToday(context),

                  DView.spaceHeight(25.h),
                  // divider
                  Center(
                    child: Container(
                      height: 5.h,
                      width: 80.w,
                      decoration: BoxDecoration(
                        color: AppColor.bg,
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                    ),
                  ),

                  DView.spaceHeight(25.h),

                  Text(
                    "Pengeluaran minggu ini",
                    style: bold.copyWith(
                      fontSize: 20.sp,
                    ),
                  ),
                  DView.spaceHeight(),

                  // chart pengeluaran minggu ini
                  weekly(),

                  DView.spaceHeight(30.h),

                  Text(
                    "Perbandingan bulan ini",
                    style: bold.copyWith(
                      fontSize: 20.sp,
                    ),
                  ),
                  DView.spaceHeight(),

                  monthly(context),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Drawer drawer() {
    return Drawer(
      child: ListView(
        children: [
          // header
          DrawerHeader(
            margin: const EdgeInsets.only(bottom: 0),
            padding: const EdgeInsets.fromLTRB(20, 16, 16, 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Image.asset(AppAsset.profile),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hi,',
                            style: bold.copyWith(
                              fontSize: 20,
                            ),
                          ),
                          Obx(
                            () {
                              return Text(
                                cUser.data.email ?? '',
                                style: bold.copyWith(
                                  fontSize: 18,
                                  color: Colors.black54,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                // tombol logout
                Material(
                  color: AppColor.primary,
                  borderRadius: BorderRadius.circular(30.r),
                  child: InkWell(
                    onTap: () {
                      // hapus session /logout
                      Session.clearUser();

                      // arahkan ke login page
                      Get.off(() => const LoginPage());
                    },
                    borderRadius: BorderRadius.circular(30.r),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
                      child: Text(
                        "Logout",
                        style: bold.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),

          // list drawer
          ListTile(
            onTap: () {
              Get.to(() => AddHistoryPage())?.then((value) {
                if (value ?? false) {
                  cHome.getAnalisis(cUser.data.idUser!);
                }
              });
            },
            leading: const Icon(Icons.add),
            horizontalTitleGap: 0,
            title: Text(
              "Tambah Baru",
              style: regular.copyWith(fontSize: 15),
            ),
            trailing: const Icon(Icons.navigate_next),
          ),
          const Divider(height: 1),
          ListTile(
            onTap: () {
              Get.to(() => const IncomeOutcomePage(type: 'Pemasukan'));
            },
            leading: const Icon(Icons.south_west),
            horizontalTitleGap: 0,
            title: Text(
              "Pemasukan",
              style: regular.copyWith(fontSize: 15),
            ),
            trailing: const Icon(Icons.navigate_next),
          ),
          const Divider(height: 1),
          ListTile(
            onTap: () {
              Get.to(() => const IncomeOutcomePage(type: 'Pengeluaran'));
            },
            leading: const Icon(Icons.south_east),
            horizontalTitleGap: 0,
            title: Text(
              "Pengeluaran",
              style: regular.copyWith(fontSize: 15),
            ),
            trailing: const Icon(Icons.navigate_next),
          ),
          const Divider(height: 1),
          ListTile(
            onTap: () {
              Get.to(() => const HistoryPage());
            },
            leading: const Icon(Icons.history),
            horizontalTitleGap: 0,
            title: Text(
              "Riwayat",
              style: regular.copyWith(fontSize: 15),
            ),
            trailing: const Icon(Icons.navigate_next),
          ),
          const Divider(height: 1),
        ],
      ),
    );
  }

  Row monthly(BuildContext context) {
    return Row(
      children: [
        // chart perbandingan pengeluaran dan pemasukan
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.5,
          height: MediaQuery.of(context).size.width * 0.5,
          child: Stack(
            children: [
              Obx(
                () {
                  return DChartPie(
                    data: [
                      {'domain': 'income', 'measure': cHome.monthIncome},
                      {'domain': 'outcome', 'measure': cHome.monthOutcome},
                      if (cHome.monthIncome == 0 && cHome.monthOutcome == 0)
                        {'domain': 'nol', 'measure': 1},
                    ],
                    fillColor: (pieData, index) {
                      switch (pieData['domain']) {
                        case 'income':
                          return AppColor.primary;
                        case 'outcome':
                          return AppColor.chart;
                        default:
                          return AppColor.bg.withOpacity(0.5);
                      }
                    },
                    donutWidth: 20,
                    labelColor: Colors.transparent,
                    showLabelLine: false,
                  );
                },
              ),
              Center(
                child: Obx(
                  () {
                    return Text(
                      "${cHome.percentIncome}%",
                      style: regular.copyWith(
                        color: AppColor.primary,
                        fontSize: 30.sp,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  height: 16.w,
                  width: 16.w,
                  color: AppColor.primary,
                ),
                DView.spaceWidth(8.w),
                Text(
                  "Pemasukan",
                  style: regular.copyWith(fontSize: 15),
                ),
              ],
            ),
            DView.spaceHeight(8.w),
            Row(
              children: [
                Container(
                  height: 16.w,
                  width: 16.w,
                  color: AppColor.chart,
                ),
                DView.spaceWidth(8.w),
                Text("Pengeluaran", style: regular.copyWith(fontSize: 15)),
              ],
            ),

            DView.spaceHeight(20),
            // keterangan
            Obx(
              () {
                return Text(
                  cHome.monthPercent,
                  style: regular.copyWith(fontSize: 13),
                );
              },
            ),
            DView.spaceHeight(10),
            Text("atau setara : ", style: regular.copyWith(fontSize: 13)),
            Obx(
              () {
                return Text(
                  AppFormat.currency(cHome.differentMonth.toString()),
                  style: bold.copyWith(
                    color: AppColor.primary,
                  ),
                );
              },
            ),
          ],
        ),

        Column()
      ],
    );
  }

  AspectRatio weekly() {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Obx(() {
        return DChartBar(
          data: [
            {
              'id': 'Bar',
              'data': List.generate(
                7,
                (index) {
                  return {
                    'domain': cHome.weekText()[index],
                    'measure': cHome.week[index],
                  };
                },
              ),
            },
          ],
          domainLabelPaddingToAxisLine: 8,
          axisLineTick: 2,
          axisLineColor: AppColor.primary,
          measureLabelPaddingToAxisLine: 16,
          barColor: (barData, index, id) => AppColor.primary,
          showBarValue: true,
        );
      }),
    );
  }

  Material cardToday(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(16.r),
      elevation: 4,
      color: AppColor.primary,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 4),
            child: Obx(() {
              return Text(
                AppFormat.currency(cHome.today.toString()),
                style: bold.copyWith(
                  fontSize: 30.sp,
                  color: AppColor.secondary,
                ),
              );
            }),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 30),
            child: Obx(
              () {
                return Text(
                  cHome.todayPercent,
                  style: regular.copyWith(
                    color: AppColor.bg,
                  ),
                );
              },
            ),
          ),
          GestureDetector(
            onTap: () {
              Get.to(
                () => DetailHistoryPage(
                  idUser: cUser.data.idUser!,
                  date: DateFormat('yyyy-MM-dd').format(DateTime.now()),
                  type: 'Pengeluaran',
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.fromLTRB(16, 0, 0, 16),
              padding: EdgeInsets.symmetric(vertical: 6.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.r),
                  bottomLeft: Radius.circular(8.r),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Selengkapnya",
                    style: regular.copyWith(color: AppColor.primary),
                  ),
                  const Icon(
                    Icons.navigate_next,
                    color: AppColor.primary,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
