import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:stunting_project/components/app_text_styles.dart';
import 'package:stunting_project/components/kelurahan_vars.dart';
import 'package:stunting_project/data/gizi/gizi_models.dart';
import 'package:stunting_project/service/gizi_service.dart';

import '../../../tokenmanager.dart'; // Pastikan impor ini benar

class GiziPage extends StatefulWidget {
  GiziPage({Key? key}) : super(key: key);

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

  final TextEditingController namaController = TextEditingController();
  final TextEditingController nikController = TextEditingController();
  final TextEditingController tinggiController = TextEditingController();
  final TextEditingController beratController = TextEditingController();

  GiziService _giziService = GiziService(); // Instance of GiziService

  String calculateAgeText(DateTime dateOfBirth) {
    final currentDate = DateTime.now();
    final ageDiff = currentDate.difference(dateOfBirth).inDays / 30.44;
    final years = (ageDiff / 12).floor();
    final months = (ageDiff % 12).round();
    final ageBabyText =
        years != 0 ? '$years tahun $months bulan' : '$months bulan';
    return ageBabyText;
  }

  void _submitForm() async {
    String? accessToken = await TokenManager.getAccessToken();
    print('Access Token: $accessToken');

    if (_formKey.currentState!.validate() && _gender.isNotEmpty) {
      // If form is valid and gender is selected
      String ageText = calculateAgeText(DateTime.now()); // Example age text

      try {
        // Validate height and weight inputs
        if (tinggiController.text.isEmpty || beratController.text.isEmpty) {
          throw FormatException('Tinggi dan Berat tidak boleh kosong');
        }

        // Validate height input
        if (int.tryParse(tinggiController.text) == null) {
          throw FormatException('Tinggi harus berupa angka');
        }

        // Validate weight input
        if (int.tryParse(beratController.text) == null) {
          throw FormatException('Berat harus berupa angka');
        }

        // Send data to create nutrition history
        NutritionHistory history = await _giziService.createNutritionHistory(
          childNik: nikController.text,
          childName: namaController.text,
          childVillage: _selectedKelurahan,
          birthDate: birthDate ?? DateTime.now(),
          ageText: ageText,
          height: int.parse(tinggiController.text),
          weight: int.parse(beratController.text),
          gender: _gender,
          token: accessToken!, // Replace with actual authentication token
        );

        // Handle success (e.g., show success message)
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Data berhasil disimpan')),
        );

        // Clear form fields after successful submission (optional)
        _formKey.currentState!.reset();
        tinggiController.clear();
        beratController.clear();
        setState(() {
          _gender = '';
          _selectedKelurahan = '';
        });
      } catch (e) {
        // Handle error (e.g., show error message)
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal menyimpan data: $e')),
        );
      }
    } else if (_gender.isEmpty) {
      setState(() {}); // Trigger rebuild to show gender error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kalkulator Gizi', style: AppTextStyle.heading4Bold),
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
                TextFormField(
                  controller: dateController,
                  decoration: const InputDecoration(labelText: 'Tanggal Lahir'),
                  keyboardType: TextInputType.datetime,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2018),
                      lastDate: DateTime.now(),
                    );
                    if (pickedDate != null) {
                      String formattedDate =
                          DateFormat('yyyy-MM-ddTHH:mm:ss.SSSZ')
                              .format(pickedDate); // Calculate age text
                      String ageText = calculateAgeText(pickedDate);
                      setState(() {
                        dateController.text = ageText;
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
                if (_gender.isEmpty)
                  const Padding(
                    padding: EdgeInsets.only(left: 16),
                    child: Text(
                      'Jenis Kelamin tidak boleh kosong',
                      style: TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'Kelurahan',
                    border: OutlineInputBorder(),
                  ),
                  value: _selectedKelurahan.isEmpty ? null : _selectedKelurahan,
                  items: listKelurahan.map((String kelurahan) {
                    return DropdownMenuItem<String>(
                      value: kelurahan,
                      child: Text(
                        kelurahan,
                        style: TextStyle(fontSize: 12),
                      ),
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
                    Expanded(
                      child: TextFormField(
                        controller: tinggiController,
                        decoration: const InputDecoration(
                            labelText: 'Tinggi Badan (cm)'),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Tinggi Badan tidak boleh kosong';
                          }
                          return null;
                        },
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.info),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Keterangan Pengukuran Tinggi'),
                              content: const SingleChildScrollView(
                                child: ListBody(
                                  children: <Widget>[
                                    Text(
                                        '-Balita usia 0-23 bulan dihitung dengan posisi terlentang'),
                                    Text(
                                        '-Balita usia 24-59 bulan dihitung dengan posisi berdiri'),
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
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: beratController,
                  decoration:
                      const InputDecoration(labelText: 'Berat Badan (kg)'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Berat Badan tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                Card(
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('IMT :', style: AppTextStyle.body2Medium),
                        const SizedBox(height: 4),
                        Text('Kategori TB/U :',
                            style: AppTextStyle.body2Medium),
                        const SizedBox(height: 4),
                        Text('Kategori BB/U:', style: AppTextStyle.body2Medium),
                        const SizedBox(height: 4),
                        Text('Kategori IMT/U :',
                            style: AppTextStyle.body2Medium),
                      ],
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: _submitForm,
                  child: const Text('Simpan'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
