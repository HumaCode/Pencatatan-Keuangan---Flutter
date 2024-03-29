import 'package:course_money_record/config/app_color.dart';
import 'package:course_money_record/config/app_format.dart';
import 'package:course_money_record/config/constants.dart';
import 'package:course_money_record/data/model/history.dart';
import 'package:course_money_record/data/source/source_history.dart';
import 'package:course_money_record/presentation/controller/c_user.dart';
import 'package:course_money_record/presentation/controller/history/c_income_outcome.dart';
import 'package:course_money_record/presentation/page/history/detail_history_page.dart';
import 'package:course_money_record/presentation/page/history/update_history_page.dart';
import 'package:d_info/d_info.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IncomeOutcomePage extends StatefulWidget {
  const IncomeOutcomePage({super.key, required this.type});

  final String type;

  @override
  State<IncomeOutcomePage> createState() => _IncomeOutcomePageState();
}

class _IncomeOutcomePageState extends State<IncomeOutcomePage> {
  // inisialisasi controller yang diperlukan
  final cInOut = Get.put(CIncomeOutcome());
  final cUser = Get.put(CUser());

  final controllerSearch = TextEditingController();

  // function refresh
  refresh() {
    // list inout dari controller
    cInOut.getList(cUser.data.idUser, widget.type);
  }

  // function show menu
  menuOption(String value, History history) async {
    if (value == 'update') {
      Get.to(() => UpdateHistoryPage(
          date: history.date!, idHistory: history.idHistory!))?.then((value) {
        if (value ?? false) {
          refresh();
        }
      });
    } else if (value == 'delete') {
      bool? yes = await DInfo.dialogConfirmation(
          context, 'Konfirmasi', 'Apakah anda yakin akan menghapus data ini..?',
          textNo: 'Batal', textYes: 'Hapus data');

      if (yes!) {
        bool success = await SourceHistory.delete(history.idHistory!);

        // jika success, maka akan di refresh
        if (success) refresh();
      }
    }
  }

  @override
  void initState() {
    refresh();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Row(
          children: [
            Text(
              widget.type,
              style: regular.copyWith(fontSize: 20.sp),
            ),
            Expanded(
              child: Container(
                height: 40.w,
                margin: EdgeInsets.all(16.w),
                child: TextField(
                  controller: controllerSearch,
                  onTap: () async {
                    DateTime? result = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2023, 01, 01),
                      lastDate: DateTime(DateTime.now().year + 1),
                    );
                    // cek ada atu tidak tanggal yng dipilih
                    if (result != null) {
                      controllerSearch.text =
                          DateFormat('yyyy-MM-dd').format(result);
                    }
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.r),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: AppColor.chart.withOpacity(0.5),
                    suffixIcon: IconButton(
                      onPressed: () {
                        cInOut.search(
                          cUser.data.idUser,
                          widget.type,
                          controllerSearch.text,
                        );
                      },
                      icon: const Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                    ),
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 0,
                      horizontal: 16.w,
                    ),
                    hintText: DateFormat('yyyy-MM-dd', 'id_ID')
                        .format(DateTime.now()),
                    hintStyle:
                        regular.copyWith(color: Colors.white, fontSize: 14.sp),
                  ),
                  textAlignVertical: TextAlignVertical.center,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      // body
      body: GetBuilder<CIncomeOutcome>(builder: (_) {
        // jika sedang loading
        if (_.loading) return DView.loadingCircle();

        // jika tidak ada data
        if (_.list.isEmpty) return DView.empty('Tidak ada data');

        return RefreshIndicator(
          onRefresh: () async => refresh(),
          child: ListView.builder(
            itemCount: _.list.length,
            itemBuilder: (context, index) {
              // buat objek history
              History history = _.list[index];

              return Card(
                elevation: 4,
                margin: EdgeInsets.fromLTRB(16, index == 0 ? 16 : 8, 16,
                    index == _.list.length - 1 ? 16 : 8),
                child: InkWell(
                  onTap: () {
                    Get.to(() => DetailHistoryPage(
                          idUser: cUser.data.idUser!,
                          date: history.date!,
                          type: history.type!,
                        ));
                  },
                  borderRadius: BorderRadius.circular(4.r),
                  child: Row(
                    children: [
                      DView.spaceWidth(),
                      Text(
                        AppFormat.date(history.date!),
                        style: bold.copyWith(
                          color: AppColor.primary,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          AppFormat.currency(history.total!),
                          style: bold.copyWith(
                            color: AppColor.primary,
                          ),
                          textAlign: TextAlign.end,
                        ),
                      ),

                      // popup button
                      PopupMenuButton<String>(
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            value: "update",
                            textStyle: regular.copyWith(
                              color: Colors.black,
                              fontSize: 15.sp,
                            ),
                            child: const Text("Update"),
                          ),
                          PopupMenuItem(
                              value: "delete",
                              textStyle: regular.copyWith(
                                color: Colors.black,
                                fontSize: 15.sp,
                              ),
                              child: const Text("Delete")),
                        ],
                        onSelected: (value) => menuOption(value, history),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
