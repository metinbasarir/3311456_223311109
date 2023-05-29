import 'package:flutter/material.dart';
import 'sqflite_personel_birim_liste.dart';
import 'package:mobil_projem/database/db_helper.dart';
import 'package:mobil_projem/model/sqflite_model.dart';
import 'sqflite_personel_birim_formu.dart';

class ListPersonelPage extends StatefulWidget {
  const ListPersonelPage({Key? key}) : super(key: key);

  @override
  _ListPersonelPageState createState() => _ListPersonelPageState();
}

class _ListPersonelPageState extends State<ListPersonelPage> {
  List<Personel> listPersonel = [];
  DbHelper db = DbHelper();

  @override
  void initState() {
    _getAllPersonel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("Personel Görev Yeri Listesi"),
        ),
      ),
      body: ListView.builder(
          itemCount: listPersonel.length,
          itemBuilder: (context, index) {
            Personel personel = listPersonel[index];
            return Padding(
              padding: const EdgeInsets.only(top: 20),
              child: ListTile(
                leading: Icon(
                  Icons.person,
                  size: 50,
                ),
                title: Text('${personel.adiSoyadi}'),
                subtitle: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 8,
                      ),
                      child: Text("Unvanı: ${personel.unvan}"),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 8,
                      ),
                      child:
                      Text("T.C.Kimlik Numarası: ${personel.tcKimlikNo}"),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 8,
                      ),
                      child: Text("Görev Yeri: ${personel.gorevYeri}"),
                    )
                  ],
                ),
                trailing: FittedBox(
                  fit: BoxFit.fill,
                  child: Row(
                    children: [
                      // button edit
                      IconButton(
                          onPressed: () {
                            _openFormEdit(personel);
                          },
                          icon: Icon(Icons.edit)),
                      // button hapus
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          AlertDialog hapus = AlertDialog(
                            title: Text(
                              "Bilgilendirme",
                              style: TextStyle(
                                color: Colors.teal,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            content: Container(
                              height: 100,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.info,
                                        color: Colors.teal,
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        "${personel.adiSoyadi} Silmek İçin Emin Misiniz?",
                                        style: TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  _deletePersonel(personel, index);
                                  Navigator.pop(context);
                                },
                                style: ButtonStyle(
                                  foregroundColor:
                                  MaterialStateProperty.all<Color>(
                                      Colors.red),
                                ),
                                child: Text(
                                  "Evet",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  "Hayır",
                                  style: TextStyle(
                                    color: Colors.teal,
                                  ),
                                ),
                              ),
                            ],
                          );

                          showDialog(
                            context: context,
                            builder: (context) => hapus,
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _openFormCreate();
        },
      ),
    );
  }

  Future<void> _getAllPersonel() async {
    var list = await db.getAllPersonel();

    setState(() {
      listPersonel.clear();

      list!.forEach((personel) {
        listPersonel.add(Personel.fromMap(personel));
      });
    });
  }

  Future<void> _deletePersonel(Personel personel, int position) async {
    await db.deletePersonel(personel.id!);
    setState(() {
      listPersonel.removeAt(position);
    });
  }

  Future<void> _openFormCreate() async {
    var result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => FormPersonel()));
    if (result == 'Kaydet') {
      await _getAllPersonel();
    }
  }

  Future<void> _openFormEdit(Personel personel) async {
    var result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => FormPersonel(personel: personel)));
    if (result == 'Güncelle') {
      await _getAllPersonel();
    }
  }
}
