import 'package:flutter/material.dart';
import 'package:mobil_projem/screens/personel_bilgileri.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PersonelBilgileriYazdir extends StatefulWidget {
  const PersonelBilgileriYazdir({Key? key}) : super(key: key);

  @override
  State<PersonelBilgileriYazdir> createState() =>
      _PersonelBilgileriYazdirState();
}

class _PersonelBilgileriYazdirState extends State<PersonelBilgileriYazdir> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        centerTitle: true,
        title: Text(
          'Personel Bilgileri',
          style: TextStyle(fontWeight: FontWeight.w300),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('personel').snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          return streamSnapshot != null && streamSnapshot.hasData
              ? ListView.builder(
                  padding: EdgeInsets.symmetric(vertical: 41),
                  itemCount: streamSnapshot.data!.docs.length,
                  itemBuilder: ((context, index) {
                    return Container(
                        margin: EdgeInsets.symmetric(horizontal: 20)
                            .copyWith(bottom: 10),
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        decoration:
                            BoxDecoration(color: Colors.white, boxShadow: [
                          BoxShadow(
                              color: Colors.grey.shade300,
                              blurRadius: 5,
                              spreadRadius: 1,
                              offset: Offset(2, 2))
                        ]),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.person,
                                  size: 31,
                                  color: Colors.teal,
                                ),
                                SizedBox(width: 11),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      streamSnapshot.data!.docs[index]
                                          ['tckimlikno'],
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      streamSnapshot
                                          .data!.docs[index]['adi_soyadi']
                                          .toString(),
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w300),
                                    ),
                                    Text(
                                      streamSnapshot.data!.docs[index]['unvan'],
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                PersonelBilgileri(
                                                  tcKimlikNumarasi:
                                                      streamSnapshot
                                                              .data!.docs[index]
                                                          ['tckimlikno'],
                                                  adSoyad: streamSnapshot
                                                          .data!.docs[index]
                                                      ['adi_soyadi'],
                                                  unvan: streamSnapshot.data!
                                                      .docs[index]['unvan'],
                                                  id: streamSnapshot
                                                      .data!.docs[index]['id'],
                                                  sicilNumarasi:streamSnapshot
                                                      .data!.docs[index]['sicilno'] ,
                                                  cinsiyet: streamSnapshot
                                                      .data!.docs[index]['cinsiyet'],
                                                  kangrubu: streamSnapshot
                                                      .data!.docs[index]['kan_grubu'],
                                                    dogumTarihi: streamSnapshot
                                                        .data!.docs[index]['dogum_tarihi'],
                                                    iseBaslamaTarihi: streamSnapshot
                                                      .data!.docs[index]['baslama_tarihi'],
                                                  cepTelefonu:streamSnapshot
                                                      .data!.docs[index]['cep_telefonu'],
                                                  epostaAdresi:streamSnapshot
                                                      .data!.docs[index]['eposta'],
                                                )));
                                  },
                                  child: Icon(
                                    Icons.edit,
                                    color: Colors.blue,
                                    size: 21,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    final docData = FirebaseFirestore.instance
                                        .collection('personel')
                                        .doc(streamSnapshot.data!.docs[index]
                                            ['id']);
                                    await docData.delete();
                                  },
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.teal,
                                    size: 21,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ));
                  }))
              : Center();
        },
      ),
    );
  }
}
