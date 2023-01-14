import 'dart:convert';

import 'package:course_money_record/config/app_color.dart';
import 'package:course_money_record/config/app_format.dart';
import 'package:course_money_record/data/source/source_history.dart';
import 'package:course_money_record/presentation/controller/c_user.dart';
import 'package:course_money_record/presentation/controller/history/c_add_history.dart';
import 'package:d_input/d_input.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddHistoryPage extends StatelessWidget {
  AddHistoryPage({super.key});

  final cAddHistory = Get.put(CAddHistory());
  final cUser = Get.put(CUser());
  final controllerName = TextEditingController();
  final controllerPrice = TextEditingController();

  // function add history
  addHistory() async {
    bool success = await SourceHistory.add(
      cUser.data.idUser!,
      cAddHistory.date,
      cAddHistory.type,
      jsonEncode(cAddHistory.items),
      cAddHistory.total.toString(),
    );

    // jika success
    if (success) {
      // kasih deley dulu
      Future.delayed(const Duration(milliseconds: 3000), () {
        Get.back(result: true);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DView.appBarLeft('Tambah Baru'),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Tanggal',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: [
              Obx(() {
                return Text(cAddHistory.date);
              }),
              DView.spaceWidth(),
              ElevatedButton.icon(
                onPressed: () async {
                  DateTime? result = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2023, 01, 01),
                    lastDate: DateTime(DateTime.now().year + 1),
                  );
                  // cek ada atu tidak tanggal yng dipilih
                  if (result != null) {
                    cAddHistory
                        .setDate(DateFormat('yyyy-MM-dd').format(result));
                  }
                },
                icon: const Icon(Icons.event),
                label: const Text("Pilih"),
              ),
            ],
          ),
          DView.spaceHeight(),
          const Text(
            "Tipe",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          DView.spaceHeight(4),
          Obx(() {
            return DropdownButtonFormField(
              value: cAddHistory.type,
              items: ['Pemasukan', 'Pengeluaran'].map(
                (e) {
                  return DropdownMenuItem(
                    value: e,
                    child: Text(e),
                  );
                },
              ).toList(),
              onChanged: (value) {
                cAddHistory.setType(value);
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                isDense: true,
              ),
            );
          }),
          DView.spaceHeight(),
          DInput(
            controller: controllerName,
            hint: 'Masukan Keterangan',
            title: 'Sumber/Objek Pengeluaran',
          ),
          DView.spaceHeight(),
          DInput(
            controller: controllerPrice,
            hint: 'Masukan Nominal',
            title: 'Harga',
            inputType: TextInputType.number,
          ),
          DView.spaceHeight(),

          ElevatedButton(
            onPressed: () {
              cAddHistory.addItem({
                'name': controllerName.text,
                'price': controllerPrice.text,
              });

              // setelah di tambahkan ke item, hapus value di controler name dan price
              controllerName.clear();
              controllerPrice.clear();
            },
            child: const Text("Tambah ke Items"),
          ),

          DView.spaceHeight(),

          // divider
          Center(
            child: Container(
              height: 5,
              width: 80,
              decoration: BoxDecoration(
                color: AppColor.bg,
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),

          DView.spaceHeight(),
          const Text(
            "Items",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          DView.spaceHeight(4),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Colors.grey,
              ),
            ),
            child: GetBuilder<CAddHistory>(builder: (_) {
              return Wrap(
                spacing: 8,
                runSpacing: 0,
                children: List.generate(_.items.length, (index) {
                  return Chip(
                    label: Text(_.items[index]['name']),
                    deleteIcon: const Icon(Icons.clear),
                    onDeleted: () => _.deleteItem(index),
                  );
                }),
              );
            }),
          ),

          DView.spaceHeight(),
          Row(
            children: [
              const Text(
                "Total : ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              DView.spaceWidth(8),
              Obx(() {
                return Text(
                  AppFormat.currency(cAddHistory.total.toString()),
                  style: Theme.of(context).textTheme.headline4!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColor.primary,
                      ),
                );
              })
            ],
          ),
          DView.spaceHeight(50),
          Material(
            color: AppColor.primary,
            borderRadius: BorderRadius.circular(8),
            child: InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: () => addHistory(),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Center(
                  child: Text(
                    "SUBMIT",
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}