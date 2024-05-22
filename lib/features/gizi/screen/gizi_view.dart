import 'package:flutter/material.dart';

class GiziPage extends StatelessWidget {
  const GiziPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Status Gizi Balita'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context, 0);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.history), // Icon yang digunakan untuk history
            onPressed: () {Navigator.pushNamed(context, 'gizihistory'); // Action ketika ikon history ditekan
              // Action ketika ikon history ditekan
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Nama Balita'),
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Tanggal Lahir'),
                keyboardType: TextInputType.datetime,
                // Use a DatePicker to select date
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2010),
                    lastDate: DateTime(2030),
                  );
                  if (pickedDate != null) {
                    // Handle selected date
                  }
                },
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Text('Jenis Kelamin:'),
                  const SizedBox(width: 8),
                  Row(
                    children: [
                      Radio(
                        value: 'Laki-laki',
                        groupValue: 'gender',
                        onChanged: (value) {
                          // Handle radio button changes
                        },
                      ),
                      const Text('Laki-laki'),
                      Radio(
                        value: 'Perempuan',
                        groupValue: 'gender',
                        onChanged: (value) {
                          // Handle radio button changes
                        },
                      ),
                      const Text('Perempuan'),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Tinggi Badan (cm)'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Berat Badan (kg)'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // Handle submit button
                },
                child: const Text('Simpan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
