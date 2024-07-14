import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:stunting_project/components/app_text_styles.dart';
import 'package:stunting_project/components/kelurahan_vars.dart';
import 'package:stunting_project/data/gizi/gizi_models.dart';
import 'package:stunting_project/service/gizi_service.dart';
import '../../../data/gizi/children_models.dart';
import '../../../tokenmanager.dart'; // Pastikan impor ini benar

class GiziPage extends StatefulWidget {
  const GiziPage({Key? key}) : super(key: key);

  @override
  State<GiziPage> createState() => _GiziPageState();
}

class _GiziPageState extends State<GiziPage> {
  final TextEditingController dateController = TextEditingController();
  final DateFormat formatter = DateFormat('dd/MM/yyyy');
  final _formKey = GlobalKey<FormState>();
  DateTime? birthDate;
  String _selectedKelurahan = '';
  String _gender = '';
  String ageBabyText = '';

  final TextEditingController namaController = TextEditingController();
  final TextEditingController nikController = TextEditingController();
  final TextEditingController tinggiController = TextEditingController();
  final TextEditingController beratController = TextEditingController();

  final GiziService _giziService = GiziService(); // Instance of GiziService

  List<NutritionHistory> _histories = [];
  NutritionHistory? _selectedHistory;

  List<Child> _children = [];
  Child? _selectedChild;

  @override
  void initState() {
    super.initState();
    _fetchChildren();
    _fetchNutritionHistories();
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

  Future<void> _fetchNutritionHistories() async {
    String? accessToken = await TokenManager.getAccessToken();
    try {
      List<NutritionHistory> histories =
          await _giziService.getUserNutritionHistories(accessToken!);
      setState(() {
        _histories = histories;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal mengambil data riwayat nutrisi: $e')),
      );
      print('Failed to fetch nutrition histories: $e');
    }
  }

  String calculateAgeText(DateTime dateOfBirth) {
    final currentDate = DateTime.now();
    final ageDiff = currentDate.difference(dateOfBirth).inDays / 30.44;
    final years = (ageDiff / 12).floor();
    final months = (ageDiff % 12).round();
    final ageBabyText =
        years != 0 ? '$years tahun $months bulan' : '$months bulan';
    return ageBabyText;
  }

  void _cekUmur() {
    setState(() {
      if (birthDate != null) {
        ageBabyText = calculateAgeText(birthDate!);
      } else {
        ageBabyText = '';
        // Handle if birthDate is null
      }
    });
  }

  void _fillFormWithChild(Child child) {
    setState(() {
      _selectedChild = child;
      namaController.text = child.childName;
      nikController.text = child.childNik;
      birthDate = (child.dateOfBirth);
      dateController.text = formatter.format(birthDate!);
      ageBabyText = calculateAgeText(birthDate!);
      _gender = child.gender;
      // Don't fill in height and weight
    });
  }

  void _submitForm() async {
    String? accessToken = await TokenManager.getAccessToken();

    if (_formKey.currentState!.validate() && _gender.isNotEmpty) {
      String ageText =
          calculateAgeText(birthDate ?? DateTime.now()); // Use birthDate

      try {
        // Validate height and weight inputs
        if (tinggiController.text.isEmpty || beratController.text.isEmpty) {
          throw const FormatException('Tinggi dan Berat tidak boleh kosong');
        }

        // Validate height input
        if (int.tryParse(tinggiController.text) == null) {
          throw const FormatException('Tinggi harus berupa angka');
        }

        // Validate weight input
        if (int.tryParse(beratController.text) == null) {
          throw const FormatException('Berat harus berupa angka');
        }

        // Send data to create nutrition history
        NutritionHistory history = await _giziService.createNutritionHistory(
          childNik: nikController.text,
          childName: namaController.text,
          childVillage: _selectedKelurahan,
          birthDate: birthDate ?? DateTime.now(),
          ageText: ageText,
          height: tinggiController.text,
          weight: beratController.text,
          gender: _gender,
          token: accessToken!,
        );

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Data berhasil disimpan')),
        );

        _formKey.currentState!.reset();
        tinggiController.clear();
        beratController.clear();
        setState(() {
          _gender = '';
          _selectedKelurahan = '';
          _selectedHistory = null;
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal menyimpan data: $e')),
        );
      }
    } else if (_gender.isEmpty) {
      setState(() {}); // Trigger rebuild to show gender error
    }
  }

  void _showTinggiInfoDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Keterangan Pengukuran Tinggi'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: [
                Text(
                    '1. Balita usia 0-23 bulan dihitung dengan posisi terlentang'),
                Text(
                    '2. Balita usia 24-59 bulan dihitung dengan posisi berdiri'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _updateChild() async {
    if (_selectedChild == null) return;

    String? accessToken = await TokenManager.getAccessToken();

    try {
      NutritionHistory updatedHistory =
          await _giziService.updateNutritionHistory(
        nutritionHistoryId: _selectedChild!.id, // Use the selected child's ID
        ageInMonth:
            calculateAgeText(birthDate ?? DateTime.now()), // Use birthDate
        height: tinggiController.text,
        weight: beratController.text,
        token: accessToken!,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Data berhasil diperbarui')),
      );

      // Refresh the list of nutrition histories after update
      _fetchNutritionHistories();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal memperbarui data: $e')),
      );
    }
  }

  Future<void> _deleteChild() async {
    if (_selectedChild == null) return;

    String? accessToken = await TokenManager.getAccessToken();

    try {
      await _giziService.deleteNutritionHistoryById(
        nutritionHistoryId: _selectedChild!.id, // Use the selected child's ID
        token: accessToken!,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Data berhasil dihapus')),
      );

      // Refresh the list of children after deletion
      _fetchChildren();

      // Reset the form and selected child
      setState(() {
        _selectedChild = null;
        namaController.clear();
        nikController.clear();
        tinggiController.clear();
        beratController.clear();
        dateController.clear();
        ageBabyText = '';
        _gender = '';
        _selectedKelurahan = '';
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal menghapus data: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kalkulator Gizi', style: AppTextStyle.heading4Bold),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {
              Navigator.pushNamed(context, 'gizihistory');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
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
                        _fillFormWithChild(
                            newValue!); // Pass newValue (Child) to method
                      });
                    },
                  ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: namaController,
                  decoration: const InputDecoration(labelText: 'Nama Balita'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Nama Balita tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: nikController,
                  decoration: const InputDecoration(labelText: 'NIK'),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(16),
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'NIK tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: dateController,
                        decoration:
                            const InputDecoration(labelText: 'Tanggal Lahir'),
                        keyboardType: TextInputType.datetime,
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime(2019),
                            firstDate: DateTime(2019),
                            lastDate: DateTime.now(),
                          );
                          if (pickedDate != null) {
                            setState(() {
                              birthDate = pickedDate; // Set birthDate here
                              dateController.text = formatter
                                  .format(pickedDate); // Update text field
                            });
                          }
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Tanggal Lahir tidak boleh kosong';
                          }
                          return null;
                        },
                      ),
                    ),
                    ElevatedButton(onPressed: _cekUmur, child: Text('Cek Umur'))
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  'Umur Balita : ' + ageBabyText,
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'Kelurahan',
                    border: OutlineInputBorder(),
                  ),
                  value:
                      _selectedKelurahan.isNotEmpty ? _selectedKelurahan : null,
                  items: listKelurahan.map((kelurahan) {
                    return DropdownMenuItem<String>(
                      value: kelurahan,
                      child: Text(kelurahan),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      _selectedKelurahan = newValue!;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Kelurahan tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Text('Jenis Kelamin:'),
                    const SizedBox(width: 8),
                    Row(
                      children: [
                        Radio<String>(
                          value: 'Laki-laki',
                          groupValue: _gender,
                          onChanged: (value) {
                            setState(() {
                              _gender = value!;
                            });
                          },
                          activeColor: Colors.black,
                        ),
                        const Text('Laki-laki'),
                        Radio<String>(
                          value: 'Perempuan',
                          groupValue: _gender,
                          onChanged: (value) {
                            setState(() {
                              _gender = value!;
                            });
                          },
                          activeColor: Colors.black,
                        ),
                        const Text('Perempuan'),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: tinggiController,
                        decoration: const InputDecoration(
                          labelText: 'Tinggi (cm)',
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Tinggi tidak boleh kosong';
                          }
                          return null;
                        },
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.info_outline),
                      onPressed: _showTinggiInfoDialog,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: beratController,
                  decoration: const InputDecoration(
                    labelText: 'Berat (kg)',
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(3),
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Berat tidak boleh kosong';
                    }
                    if (int.tryParse(value) == null) {
                      return 'Berat harus berupa angka';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                if (_selectedChild != null)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ElevatedButton(
                        onPressed: _updateChild,
                        child: const Text('Perbarui Data'),
                      ),
                      const SizedBox(height: 8.0),
                      ElevatedButton(
                        onPressed: _deleteChild,
                        child: const Text('Hapus Data'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Colors.red, // Change button color to red
                        ),
                      ),
                    ],
                  ),
                if (_selectedChild == null)
                  ElevatedButton(
                    onPressed: _submitForm,
                    child: const Text('Hitung Status Gizi'),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
