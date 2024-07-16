import 'package:flutter/material.dart';
import 'package:stunting_project/components/app_text_styles.dart';

import 'package:stunting_project/data/gizi/gizi_models.dart';
import 'package:stunting_project/service/gizi_service.dart';
import 'package:stunting_project/tokenmanager.dart';

class GiziHistoryPage extends StatefulWidget {
  const GiziHistoryPage({Key? key}) : super(key: key);

  @override
  State<GiziHistoryPage> createState() => _GiziHistoryPageState();
}

class _GiziHistoryPageState extends State<GiziHistoryPage> {
  final GiziService _giziService = GiziService();
  List<NutritionHistory> _histories = [];
  List<String> _childNames = [];
  String? _selectedChildName;

  @override
  void initState() {
    super.initState();
    _fetchNutritionHistories();
  }

  Future<void> _fetchNutritionHistories() async {
    String? accessToken = await TokenManager.getAccessToken();
    try {
      List<NutritionHistory> histories =
          await _giziService.getUserNutritionHistories(accessToken!);
      setState(() {
        _histories = histories;
        _childNames =
            histories.map((history) => history.childName).toSet().toList();
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal mengambil data riwayat nutrisi: $e')),
      );
      print('Failed to fetch nutrition histories: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Riwayat Status Gizi',
          style: AppTextStyle.heading4Bold,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Pilih Balita',
                  border: OutlineInputBorder(),
                ),
                value: _selectedChildName,
                onChanged: (value) {
                  setState(() {
                    _selectedChildName = value;
                  });
                },
                items: _childNames.map((childName) {
                  return DropdownMenuItem<String>(
                    value: childName,
                    child: Text(childName),
                  );
                }).toList(),
              ),
              SizedBox(
                height: 6,
              ),
              Center(
                child: Text(
                  'Silahkan scroll tabel ke kanan untuk melihat tabel lengkap nya',
                  style: AppTextStyle.body4Bold,
                ),
              ),
              if (_histories.isNotEmpty)
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columns: const [
                      DataColumn(label: Text('Nama')),
                      DataColumn(label: Text('Umur')),
                      DataColumn(label: Text('TB')),
                      DataColumn(label: Text('BB')),
                      DataColumn(label: Text('IMT')),
                      DataColumn(label: Text('Kategori TB/U')),
                      DataColumn(label: Text('Kategori BB/U')),
                      DataColumn(label: Text('Kategori IMT/U')),
                    ],
                    rows: _selectedChildName != null
                        ? _histories
                            .where((history) =>
                                history.childName == _selectedChildName)
                            .map((history) {
                            return DataRow(cells: [
                              DataCell(Text(history.childName)),
                              DataCell(Text(history.ageText)),
                              DataCell(Text(history.height.toString())),
                              DataCell(Text(history.weight.toString())),
                              DataCell(Text(history.bmi.toString())),
                              DataCell(Text(history.heightCategory)),
                              DataCell(Text(history.massCategory)),
                              DataCell(Text(history.weightCategory)),
                            ]);
                          }).toList()
                        : [],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
