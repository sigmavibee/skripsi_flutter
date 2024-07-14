import 'package:flutter/material.dart';
import 'package:stunting_project/components/app_text_styles.dart';
import 'package:stunting_project/data/gizi/children_models.dart';
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
  List<Child> _children = [];
  Child? _selectedChild;
  List<NutritionHistory> _nutritionHistories = [];

  @override
  void initState() {
    super.initState();
    _fetchChildren();
  }

  Future<void> _fetchChildren() async {
    String? accessToken = await TokenManager.getAccessToken();
    try {
      List<Child> children = await _giziService.getChildren(accessToken!);
      setState(() {
        _children = children;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal mengambil data anak-anak: $e')),
      );
      print('Failed to fetch children data: $e');
    }
  }

  Future<void> _fetchNutritionHistories(String childNik) async {
    String? accessToken = await TokenManager.getAccessToken();
    try {
      List<NutritionHistory> histories =
          await _giziService.getUserNutritionHistoriesByChild(accessToken!);
      setState(() {
        _nutritionHistories = histories;
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
              if (_children.isNotEmpty)
                DropdownButtonFormField<Child>(
                  decoration: const InputDecoration(
                    labelText: 'Pilih Balita',
                    border: OutlineInputBorder(),
                  ),
                  value: _selectedChild,
                  items: _children.map((child) {
                    return DropdownMenuItem<Child>(
                      value: child,
                      child: Text(child.childName),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      _selectedChild = newValue;
                      _fetchNutritionHistories(newValue!.childNik);
                    });
                  },
                ),
              const SizedBox(height: 16),
              if (_selectedChild != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Nama: ${_selectedChild!.childName}'),
                    Text('NIK: ${_selectedChild!.childNik}'),
                  ],
                ),
              const SizedBox(height: 16),
              if (_nutritionHistories.isNotEmpty)
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columns: const [
                      DataColumn(label: Text('Umur')),
                      DataColumn(label: Text('TB')),
                      DataColumn(label: Text('BB')),
                      DataColumn(label: Text('IMT')),
                      DataColumn(label: Text('Kategori TB/U')),
                      DataColumn(label: Text('Kategori BB/U')),
                      DataColumn(label: Text('Kategori IMT/U')),
                    ],
                    rows: _nutritionHistories.map((history) {
                      return DataRow(cells: [
                        DataCell(Text('1 bulan')),
                        DataCell(Text('1 cm')),
                        DataCell(Text('1 kg')),
                        DataCell(Text('sqsqsq')),
                        DataCell(Text('sqsqsqs')),
                        DataCell(Text('sqsqsq')),
                        DataCell(Text('sqsqqsq')),
                      ]);
                    }).toList(),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
