import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class MesajGonder extends StatefulWidget {
  @override
  _MesajGonderState createState() => _MesajGonderState();
}

class _MesajGonderState extends State<MesajGonder> {
  final _formKey = GlobalKey<FormState>();
  final _epostaController = TextEditingController();
  final _mesajController = TextEditingController();
  final _adsoyadController= TextEditingController();

  Future<String> get _getDosyaYolu async {
    Directory dosya = await getApplicationDocumentsDirectory();
    return '${dosya.path}/mesajlar.txt';
  }

  Future<void> _kaydet() async {
    if (_formKey.currentState!.validate()) {
      String adiSoyadi =_adsoyadController.text;
      String eposta = _epostaController.text;
      String mesaj = _mesajController.text;


      String mesajBilgisi = 'Adı-Soyadı: $adiSoyadi\n E-posta: $eposta\nMesaj: $mesaj\n\n';


      String dosyaYolu = await _getDosyaYolu;
      File dosya = File(dosyaYolu);
      dosya.writeAsString(mesajBilgisi, mode: FileMode.append);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Mesajınız dosyaya kaydedildi.'),
        ),
      );

      _epostaController.clear();
      _mesajController.clear();
      _adsoyadController.clear();
    }
  }

  Future<String> _mesajlariGetir() async {
    String dosyaYolu = await _getDosyaYolu;
    File dosya = File(dosyaYolu);

    if (await dosya.exists()) {
      String dosyaIcerik = await dosya.readAsString();
      return dosyaIcerik;
    } else {
      return '';
    }
  }

  @override
  void dispose() {
    _epostaController.dispose();
    _mesajController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mesaj Gönder'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _adsoyadController,
                    decoration: InputDecoration(labelText: 'Adı-Soyadı'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Lütfen Adınızı ve Soyadınızı Giriniz.';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _epostaController,
                    decoration: InputDecoration(labelText: 'E-posta'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Lütfen e-posta adresinizi girin.';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _mesajController,
                    decoration: InputDecoration(labelText: 'Mesaj'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Lütfen bir mesaj girin.';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: _kaydet,
                    child: Text('Gönder'),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: FutureBuilder(
                future: _mesajlariGetir(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Bir hata oluştu.'));
                  } else {
                    String mesajlar = snapshot.data ?? '';
                    return ListView(
                      children: [
                        Text(
                          'Gönderilen Mesajlar',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Text(mesajlar),
                        Divider(),
                      ],
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}