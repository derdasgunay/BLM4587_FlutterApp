import 'package:flutter/material.dart';

class Aliskanlik {
  final String ad;
  int streak;
  String? aciklama;

  Aliskanlik({required this.ad, this.streak = 0, this.aciklama});

  void bilgileriYazdir() {
    debugPrint('Alışkanlık: $ad');
    debugPrint('Zincir: $streak');
    debugPrint('Açıklama: ${aciklama ?? "Belirtilmedi"}');
  }
}

void main() {
  const String uygulamaAdi = 'Rutin Ağı';
  final Aliskanlik ornekGorev = Aliskanlik(ad: 'Kitap Okuma', streak: 3);

  debugPrint('--- $uygulamaAdi Test Başlıyor ---');
  ornekGorev.bilgileriYazdir();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Text(
            'Flutter ve Dart kurulumları tamamlandı.\nModel testleri için terminale bakınız.',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}