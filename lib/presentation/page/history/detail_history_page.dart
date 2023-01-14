import 'dart:convert';
import 'package:course_money_record/config/app_color.dart';
import 'package:course_money_record/config/app_format.dart';
import 'package:course_money_record/config/constants.dart';
import 'package:course_money_record/presentation/controller/history/c_detail_history.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailHistoryPage extends StatefulWidget {
  const DetailHistoryPage({
    super.key,
    required this.idUser,
    required this.date,
    required this.type,
  });

  final String idUser;
  final String date;
  final String type;

  @override
  State<DetailHistoryPage> createState() => _DetailHistoryPageState();
}

class _DetailHistoryPageState extends State<DetailHistoryPage> {
  final cDetailHitory = Get.put(CDetailHistory());

  @override
  void initState() {
    cDetailHitory.getData(widget.idUser, widget.date, widget.type);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        titleTextStyle: regular.copyWith(fontSize: 20.sp),
        title: Obx(
          () {
            if (cDetailHitory.data.date == null) return DView.nothing();

            return Row(
              children: [
                Expanded(child: Text(AppFormat.date(cDetailHitory.data.date!))),
                cDetailHitory.data.type == 'Pemasukan'
                    ? Icon(Icons.south_west, color: Colors.green[300])
                    : Icon(Icons.north_west, color: Colors.red[300]),
              ],
            );
          },
        ),
      ),
      body: GetBuilder<CDetailHistory>(builder: (_) {
        if (_.data.date == null) {
          String today = DateFormat('yyyy-MM-dd').format(DateTime.now());
          if (widget.date == today && widget.type == 'Pengeluaran') {
            return DView.empty('Belum ada pengeluaran');
          }
          return DView.nothing();
        }

        List details = jsonDecode(_.data.details!);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Text(
                "Total",
                style: bold.copyWith(
                  color: AppColor.primary.withOpacity(0.6),
                  fontWeight: FontWeight.bold,
                  fontSize: 20.sp,
                ),
              ),
            ),
            DView.spaceHeight(8.h),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
              child: Text(
                AppFormat.currency(_.data.total!),
                style: regular.copyWith(
                  color: AppColor.primary,
                  fontSize: 30.sp,
                ),
              ),
            ),
            Center(
              child: Container(
                height: 5.h,
                width: 100.w,
                decoration: BoxDecoration(
                  color: AppColor.bg,
                  borderRadius: BorderRadius.circular(30.r),
                ),
              ),
            ),
            DView.spaceHeight(20.h),

            // list
            Expanded(
              child: ListView.separated(
                itemCount: details.length,
                separatorBuilder: (context, index) => const Divider(
                  height: 1,
                  indent: 16,
                  endIndent: 16,
                  color: Colors.grey,
                ),
                itemBuilder: (context, index) {
                  // ubah ke map
                  Map item = details[index];

                  return Padding(
                    padding: EdgeInsets.all(16.w),
                    child: Row(
                      children: [
                        Text(
                          '${index + 1}.',
                          style: regular.copyWith(
                            fontSize: 20.sp,
                          ),
                        ),
                        DView.spaceWidth(8.w),
                        // ignore: prefer_const_constructors
                        Expanded(
                          child: Text(
                            item['name'],
                            style: regular.copyWith(
                              fontSize: 20.sp,
                            ),
                          ),
                        ),
                        Text(
                          AppFormat.currency(item['price']),
                          style: regular.copyWith(
                            fontSize: 20.sp,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        );
      }),
    );
  }
}
