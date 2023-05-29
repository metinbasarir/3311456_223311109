import 'package:flutter/material.dart';
import 'package:mobil_projem/database/db_helper.dart';
import 'package:mobil_projem/model/sqflite_model.dart';

const List<String> unvan = <String>[
  'Programcı',
  'Mühendis',
  'Tekniker',
  'Teknisyen',
  'Çözümleyici',
];

const List<String> gorevYeri = <String>[
  'Satın Alma Birimi',
  'İnsan Kaynakları Birimi',
  'Ayniyat Birimi',
  'Öğrenci İşleri Birimi',
];

class FormPersonel extends StatefulWidget {
  final Personel? personel;

  FormPersonel({this.personel});

  @override
  _FormPersonelState createState() => _FormPersonelState();
}

class _FormPersonelState extends State<FormPersonel> {
  DbHelper db = DbHelper();

  TextEditingController? adiSoyadi;
  TextEditingController? lastadiSoyadi;
  TextEditingController? tcKimlikNo;
  String dropdownGorevYeri = gorevYeri.first;
  String dropdownUnvan = unvan.first;

  @override
  void initState() {
    adiSoyadi = TextEditingController(
        text: widget.personel == null ? '' : widget.personel!.adiSoyadi);

    tcKimlikNo = TextEditingController(
        text: widget.personel == null ? '' : widget.personel!.tcKimlikNo);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personel Görev Yeri Girişi'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
            ),
            child: TextField(
              controller: adiSoyadi,
              decoration: InputDecoration(
                  labelText: 'Adı-Soyadı',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
            ),
            child: TextField(
              controller: tcKimlikNo,
              decoration: InputDecoration(
                  labelText: 'T.C. Kimlik Numarası',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  )),
            ),
          ),
          Divider(),
          Text(
            'Personelin Unvanını Seçiniz',
            style: TextStyle(
              color: Colors.teal,
            ),
          ),
          Divider(),
          DropdownButton<String>(
            value: dropdownUnvan,
            icon: const Icon(Icons.arrow_downward),
            elevation: 5,
            style: const TextStyle(color: Colors.black),
            underline: Container(
              height: 1,
              color: Colors.black,
            ),
            onChanged: (String? value) {
              setState(() {
                dropdownUnvan = value!;
              });
            },
            items: unvan.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          Divider(),
          Text(
            'Personelin Birimini Seçiniz',
            style: TextStyle(
              color: Colors.teal,
            ),
          ),
          DropdownButton<String>(
            value: dropdownGorevYeri,
            icon: const Icon(Icons.arrow_downward),
            elevation: 5,
            style: const TextStyle(color: Colors.black),
            underline: Container(
              height: 1,
              color: Colors.black,
            ),
            onChanged: (String? value) {
              setState(() {
                dropdownGorevYeri = value!;
              });
            },
            items: gorevYeri.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: ElevatedButton(
              child: (widget.personel == null)
                  ? Text(
                'Ekle',
                style: TextStyle(color: Colors.white),
              )
                  : Text(
                'Güncelle',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                upsertPersonel();
              },
            ),
          )
        ],
      ),
    );
  }

  Future<void> upsertPersonel() async {
    if (widget.personel != null) {
      //update
      await db.updatePersonel(Personel(
          id: widget.personel!.id,
          adiSoyadi: adiSoyadi!.text,
          tcKimlikNo: tcKimlikNo!.text,
          unvan: dropdownUnvan,
          gorevYeri: dropdownGorevYeri));

      Navigator.pop(context, 'Güncelle');
    } else {
      //insert
      await db.savePersonel(Personel(
        adiSoyadi: adiSoyadi!.text,
        tcKimlikNo: tcKimlikNo!.text,
        unvan: dropdownUnvan,
        gorevYeri: dropdownGorevYeri,
      ));
      Navigator.pop(context, 'Kaydet');
    }
  }
}
