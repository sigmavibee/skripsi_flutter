import 'package:flutter/material.dart';
import 'package:stunting_project/data/gizi/gizi_list.dart';

class GiziHistoryPage extends StatelessWidget {
  const GiziHistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Riwayat Status Gizi'),),
        body: SingleChildScrollView(
        // scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: DataTable(columnSpacing: 12,
            columns: const [
              DataColumn(label: Text('Nama')),
              DataColumn(label: Text('Umur')),
              DataColumn(label: Text('TB')),
              DataColumn(label: Text('BB')),
              DataColumn(label: Text('BMI')),
              DataColumn(label: Text('Kategori')),
            ],
            rows: nutritionData.map((nutritionStatus) {
              return DataRow(cells: [
                DataCell(Text(nutritionStatus.name)),
                DataCell(Text(nutritionStatus.age.toString())),
                DataCell(Text(nutritionStatus.height.toString())),
                DataCell(Text(nutritionStatus.weight.toString())),
                DataCell(Text(nutritionStatus.bmi.toStringAsFixed(1))),
                DataCell(Text(nutritionStatus.category)),
              ]);
            }).toList(),
          ),
        ),
      ),
    );}}