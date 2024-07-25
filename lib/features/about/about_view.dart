import 'package:flutter/material.dart';
import 'package:stunting_project/components/app_text_styles.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Puskesmas Dukuhseti'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.asset('assets/dukuhseti.png'),
            const SizedBox(height: 16),
            const Text(
              'Tentang Puskesmas Dukuhseti',
              style: AppTextStyle.body3Bold,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Text(
              'UPT Puskesmas Dukuhseti merupakan suatu kesatuan organisasi kesehatan fungsional yang merupakan pusat pengembangan kesehatan masyarakat yang juga berfungsi memberi pelayanan secara menyeluruh dan terpadu kepada masyarakat di kecamatan Dukuhseti.',
              style: AppTextStyle.body4Regular,
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 16),
            const Text(
              'Lokasi',
              style: AppTextStyle.body3Bold,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Text(
              'Puskesmas Dukuhseti terletak di Kecamatan Dukuhseti yang berjarak 37 km dari pusat kota Pati.',
              style: AppTextStyle.body4Regular,
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
}
