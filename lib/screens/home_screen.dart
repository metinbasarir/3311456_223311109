import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:mobil_projem/model/user_auth_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'personel_bilgileri.dart';
import 'personel_bilgileri_yazdir.dart';
import 'package:flutter/cupertino.dart';
import 'http_api.dart';
import 'dosya_islemleri.dart';
import 'sqflite_personel_birim_liste.dart';
import 'grafik.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Colors.teal),
              accountName: Text(
                "PERSONEL BİLGİ SİSTEMİ",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              accountEmail: Text(
                "mbasarir@selcuk.edu.tr ",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              ),
              currentAccountPicture: Image.asset(
                "assets/image/pbslogoanamenu.png",
                alignment: Alignment.center,
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                      leading: Icon(Icons.account_box_sharp),
                      title: Text("PERSONEL BİLGİ GİRİŞİ"),
                      trailing: Icon(Icons.keyboard_arrow_right),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PersonelBilgileri()),
                        );
                      }),
                  ListTile(
                      leading: Icon(Icons.article),
                      title: Text("PERSONEL LİSTESİ"),
                      trailing: Icon(Icons.keyboard_arrow_right),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PersonelBilgileriYazdir()),
                        );
                      }),
                  ListTile(
                      leading: Icon(Icons.people),
                      title: Text(
                        "PERSONEL LİSTESİ(HTTP)",
                      ),
                      trailing: Icon(Icons.keyboard_arrow_right),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MyHomePage()),
                        );
                      }),
                  ListTile(
                      leading: Icon(Icons.search_sharp),
                      title: Text("PERSONEL GÖREV YERİ"),
                      trailing: Icon(Icons.keyboard_arrow_right),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ListPersonelPage()),
                        );
                      }),
                  ListTile(
                      leading: Icon(CupertinoIcons.list_number),
                      title: Text("GRAFİK"),
                      trailing: Icon(Icons.keyboard_arrow_right),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UnvanDaireselGrafik()),
                        );
                      }),
                  ListTile(
                      leading: Icon(Icons.contact_phone),
                      title: Text("BANA ULAŞIN"),
                      trailing: Icon(Icons.keyboard_arrow_right),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MesajGonder()),
                        );
                      }),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
