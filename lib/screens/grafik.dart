import 'package:flutter/material.dart';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';

class UnvanDaireselGrafik extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('UNVANA GÖRE PERSONEL İSTATİSTİKLERİ'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('personel').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Veriler alınırken bir hata oluştu.'),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          List<Personel> personel = snapshot.data!.docs.map((doc) {
            return Personel.fromFirestore(doc);
          }).toList();

          if (personel.isEmpty) {
            return Center(
              child: Text('Gösterilecek veri bulunamadı.'),
            );
          }

          return AspectRatio(
            aspectRatio: 1.3,
            child: PieChart(
              PieChartData(
                sections: getSections(personel),
                sectionsSpace: 0,
                centerSpaceRadius: 60,
              ),
            ),
          );
        },
      ),
    );
  }

  List<PieChartSectionData> getSections(List<Personel> personel) {
    Map<String, int> unvanSayilari = {};

    personel.forEach((personel) {
      if (unvanSayilari.containsKey(personel.unvan)) {
        unvanSayilari[personel.unvan] = unvanSayilari[personel.unvan]! + 1;
      } else {
        unvanSayilari[personel.unvan] = 1;
      }
    });

    List<PieChartSectionData> sections = [];

    unvanSayilari.forEach((unvan, sayi) {
      sections.add(
        PieChartSectionData(
          value: sayi.toDouble(),
          color: getRandomColor(),
          title: '$unvan: $sayi',
          radius: 80,
          titleStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      );
    });

    return sections;
  }

  Color getRandomColor() {
    return Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
  }
}

class Personel {
  final String unvan;

  Personel({required this.unvan});

  factory Personel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Personel(
      unvan: data['unvan'] ?? '',
    );
  }
}
