import 'package:flutter/material.dart';
import 'package:pattern_formatter/pattern_formatter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

const List<String> kangrubu = <String>[
  '0Rh+',
  '0Rh-',
  'ARh+',
  'ARh-',
  'BRh+',
  'BRh-',
  'ABRh+',
  'ABRh-',
];
const List<String> Unvanlar = <String>[
  'Teknisyen',
  'Tekniker',
  'Memur',
  'Programcı',
  'Mühendis',
  'Bilgisayar İşletmeni',
  'Daire Başkanı',
  'Şube Müdürü',
];



class PersonelBilgileri extends StatefulWidget {
  final String cinsiyet;
  final String kangrubu;
  final String unvan;
  final String sicilNumarasi;
  final String tcKimlikNumarasi;
  final String adSoyad;
  final String cepTelefonu;
  final String epostaAdresi;
  final String dogumTarihi;
  final String iseBaslamaTarihi;
  final String id;

  PersonelBilgileri({
    this.cinsiyet = '',
    this.kangrubu = '',
    this.unvan = '',
    this.sicilNumarasi = '',
    this.tcKimlikNumarasi = '',
    this.adSoyad = '',
    this.cepTelefonu = '',
    this.epostaAdresi = '',
    this.dogumTarihi = '',
    this.iseBaslamaTarihi = '',
    this.id = '',
  });

  @override
  State<PersonelBilgileri> createState() => _PersonelBilgileriState();
}

class _PersonelBilgileriState extends State<PersonelBilgileri> {
  String dropdownkangrubu = kangrubu.first;
  String dropdownunvan = Unvanlar.first;
  String? cinsiyet;
  TextEditingController sicilNumarasiController = TextEditingController();
  TextEditingController tcKimlikNumarasiController = TextEditingController();
  TextEditingController adSoyadController = TextEditingController();
  TextEditingController cepTelefonuController = TextEditingController();
  TextEditingController epostaAdresiController = TextEditingController();
  TextEditingController dogumTarihiController = TextEditingController();
  TextEditingController iseBaslamaTarihiController = TextEditingController();
  bool showProgressIndicator = false;

  @override
  void initState() {
    sicilNumarasiController.text = widget.sicilNumarasi;
    tcKimlikNumarasiController.text = widget.tcKimlikNumarasi;
    adSoyadController.text = widget.adSoyad;
    cepTelefonuController.text = widget.cepTelefonu;
    epostaAdresiController.text = widget.epostaAdresi;
    dogumTarihiController.text = widget.dogumTarihi;
    iseBaslamaTarihiController.text = widget.iseBaslamaTarihi;
    super.initState();
  }

  @override
  void dispose() {
    sicilNumarasiController.dispose();
    tcKimlikNumarasiController.dispose();
    adSoyadController.dispose();
    cepTelefonuController.dispose();
    epostaAdresiController.dispose();
    dogumTarihiController.dispose();
    iseBaslamaTarihiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Personel Bilgileri Girişi",
          style: TextStyle(fontSize: 20.0, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListView(
            shrinkWrap: true,
            children: [
              TextFormField(
                controller: sicilNumarasiController,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    labelText: "Sicil Numarası",
                    hintText: "Sicil Numarası",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.teal),
                      borderRadius: BorderRadius.circular(10),)),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: tcKimlikNumarasiController,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    labelText: "T.C.Kimlik Numarası",
                    hintText: "T.C.Kimlik Numarası",
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.teal),
                        borderRadius: BorderRadius.circular(10),
                    )),

              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: adSoyadController,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    labelText: "Adı-Soyadı",
                    hintText: "Adı-Soyadı",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.teal),
                      borderRadius: BorderRadius.circular(10),)),
              ),
              SizedBox(
                height: 10,
              ),
              Divider(),
              Text('Personelin Cinsiyetini Seçiniz?'),
              Divider(),
              RadioListTile<String>(
                title: const Text('Bayan'),
                value: 'Bayan',
                groupValue: cinsiyet,
                onChanged: (String? value) {
                  setState(() {
                    cinsiyet = value;
                  });
                },
              ),
              RadioListTile<String>(
                title: const Text('Erkek'),
                value: 'Erkek',
                groupValue: cinsiyet,
                onChanged: (String? value) {
                  setState(() {
                    cinsiyet = value;
                  });
                },
              ),
              Divider(),
              Text('Personelin Unvanını Seçiniz'),
              Divider(),
              DropdownButton<String>(
                value: dropdownunvan,
                icon: const Icon(Icons.arrow_downward),
                elevation: 5,
                style: const TextStyle(color: Colors.black),
                underline: Container(
                  height: 1,
                  color: Colors.teal,
                ),
                onChanged: (String? value) {
                  setState(() {
                    dropdownunvan = value!;
                  });
                },
                items: Unvanlar.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              Divider(),
              Text('Personelin Kan Grubunu Seçiniz'),
              Divider(),
              DropdownButton<String>(
                value: dropdownkangrubu,
                icon: const Icon(Icons.arrow_downward),
                elevation: 5,
                style: const TextStyle(color: Colors.black),
                underline: Container(
                  height: 1,
                  color: Colors.teal,
                ),
                onChanged: (String? value) {
                  setState(() {
                    dropdownkangrubu = value!;
                  });
                },
                items: kangrubu.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: iseBaslamaTarihiController,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.date_range_sharp),
                    labelText: "Personelin İşe Başlama Tarihini Giriniz",
                    hintText: "Personelin İşe Başlama Tarihini Giriniz",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.teal),
                      borderRadius: BorderRadius.circular(10),)),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  DateInputFormatter(),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: dogumTarihiController,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.date_range_sharp),
                    labelText: "Personelin Doğum Tarihini Giriniz",
                    hintText: "Personelin Doğum Tarihini Giriniz",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.teal),
                      borderRadius: BorderRadius.circular(10),)),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  DateInputFormatter(),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: cepTelefonuController,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    labelText: "Cep Telefonu",
                    hintText: "Cep Telefonu",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.teal),
                      borderRadius: BorderRadius.circular(10),)),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: epostaAdresiController,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    labelText: "E-Posta Adresi",
                    hintText: "E-Posta Adresi",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.teal),
                      borderRadius: BorderRadius.circular(10),)),
              ),
              SizedBox(
                height: 10,
              ),
              Material(
                elevation: 5.0,
                borderRadius: BorderRadius.circular(5.0),
                color: Colors.teal,
                child: MaterialButton(
                  minWidth: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.fromLTRB(25.0, 25.0, 25.0, 25.0),
                  onPressed: () async {
                    setState(() {});
                    if (sicilNumarasiController.text.isEmpty ||
                        tcKimlikNumarasiController.text.isEmpty ||
                        adSoyadController.text.isEmpty ||
                        cepTelefonuController.text.isEmpty ||
                        epostaAdresiController.text.isEmpty ||
                        dogumTarihiController.text.isEmpty ||
                        iseBaslamaTarihiController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Tüm alanları doldurun')));
                    } else {
                      //reference to document
                      final dUser = FirebaseFirestore.instance
                          .collection('personel')
                          .doc(widget.id.isNotEmpty ? widget.id : null);
                      String docID = '';
                      if (widget.id.isNotEmpty) {
                        docID = widget.id;
                      } else {
                        docID = dUser.id;
                      }
                      final jsonData = {
                        'adi_soyadi': adSoyadController.text,
                        'baslama_tarihi': iseBaslamaTarihiController.text,
                        'cep_telefonu': cepTelefonuController.text,
                        'cinsiyet':cinsiyet,
                        'dogum_tarihi': dogumTarihiController.text,
                        'eposta': epostaAdresiController.text,
                        'kan_grubu': dropdownkangrubu,
                        'sicilno': sicilNumarasiController.text,
                        'tckimlikno': tcKimlikNumarasiController.text,
                        'unvan': dropdownunvan,
                        'id': docID
                      };
                      showProgressIndicator = true;
                      if (widget.id.isEmpty) {
                        //create document and write data to firebase
                        await dUser.set(jsonData).then((value) {
                          sicilNumarasiController.text = '';
                          tcKimlikNumarasiController.text = '';
                          adSoyadController.text = '';
                          cepTelefonuController.text = '';
                          epostaAdresiController.text = '';
                          dogumTarihiController.text = '';
                          iseBaslamaTarihiController.text = '';
                          showProgressIndicator = false;
                          setState(() {});
                        });
                      } else {
                        await dUser.update(jsonData).then((value) {
                          sicilNumarasiController.text = '';
                          tcKimlikNumarasiController.text = '';
                          adSoyadController.text = '';
                          cepTelefonuController.text = '';
                          epostaAdresiController.text = '';
                          dogumTarihiController.text = '';
                          iseBaslamaTarihiController.text = '';
                          showProgressIndicator = false;
                          setState(() {});
                        });
                      }
                    }
                  },
                  child: showProgressIndicator
                      ? CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : Text(
                          "Kaydet",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white, fontStyle: FontStyle.normal),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
