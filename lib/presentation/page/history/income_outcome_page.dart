import 'package:course_money_record/config/app_color.dart';
import 'package:course_money_record/presentation/controller/c_user.dart';
import 'package:course_money_record/presentation/controller/history/c_income_outcome.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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

  // function refresh
  refresh() {
    // list inout dari controller
    cInOut.getList(cUser.data.idUser, widget.type);
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
                  onTap: () {},
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: AppColor.chart.withOpacity(0.5),
                    suffixIcon: IconButton(
                      onPressed: () {},
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
      body: RefreshIndicator(
        onRefresh: () async => refresh(),
        child: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return Card(
              elevation: 4,
              margin: EdgeInsets.fromLTRB(
                  16, index == 0 ? 16 : 8, 16, index == 9 ? 16 : 8),
              child: Row(
                children: [
                  DView.spaceWidth(),
                  Text(
                    "14 Jan 2023",
                    style: TextStyle(
                      color: AppColor.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "Rp. 200.000,00",
                      style: TextStyle(
                        color: AppColor.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.end,
                    ),
                  ),

                  // popup button
                  PopupMenuButton(
                    itemBuilder: (context) => [],
                    onSelected: (value) {},
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}