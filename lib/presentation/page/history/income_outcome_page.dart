import 'package:course_money_record/config/app_color.dart';
import 'package:course_money_record/config/app_format.dart';
import 'package:course_money_record/data/model/history.dart';
import 'package:course_money_record/presentation/controller/c_user.dart';
import 'package:course_money_record/presentation/controller/history/c_income_outcome.dart';
import 'package:course_money_record/presentation/page/history/update_history_page.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

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
  menuOption(String value, History history) {
    if (value == 'update') {
      Get.to(() => UpdateHistoryPage(
          date: history.date!, idHistory: history.idHistory!))?.then((value) {
        if (value ?? false) {
          refresh();
        }
      });
    } else if (value == 'delete') {}
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
            Text(widget.type),
            Expanded(
              child: Container(
                height: 40,
                margin: const EdgeInsets.all(16),
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
                      borderRadius: BorderRadius.circular(30),
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
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 0,
                      horizontal: 16,
                    ),
                    hintText: 'Masukan tanggal',
                    hintStyle: const TextStyle(color: Colors.white),
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
                child: Row(
                  children: [
                    DView.spaceWidth(),
                    Text(
                      AppFormat.date(history.date!),
                      style: const TextStyle(
                        color: AppColor.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        AppFormat.currency(history.total!),
                        style: const TextStyle(
                          color: AppColor.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.end,
                      ),
                    ),

                    // popup button
                    PopupMenuButton<String>(
                      itemBuilder: (context) => const [
                        PopupMenuItem(value: "update", child: Text("Update")),
                        PopupMenuItem(value: "delete", child: Text("Delete")),
                      ],
                      onSelected: (value) => menuOption(value, history),
                    )
                  ],
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
