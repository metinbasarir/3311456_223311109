import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobil_projem/main.dart';
import 'package:mobil_projem/model/user_auth_model.dart';
import 'package:mobil_projem/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;

  String? errorMessage;

  final _formKey = GlobalKey<FormState>();
  final adiEditingController = new TextEditingController();
  final soyadiEditingController = new TextEditingController();
  final epostaEditingController = new TextEditingController();
  final passwordEditingController = new TextEditingController();
  final confirmPasswordEditingController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final isim = TextFormField(
        autofocus: false,
        controller: adiEditingController,
        keyboardType: TextInputType.name,
        validator: (value) {
          RegExp regex = new RegExp(r'^.{3,}$');
          if (value!.isEmpty) {
            return ("İsim Boş Geçilemez");
          }
          if (!regex.hasMatch(value)) {
            return ("En az 3 karakter olan geçerli isim giriniz!)");
          }
          return null;
        },
        onSaved: (value) {
          adiEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.account_circle),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Adı",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    final soyadi = TextFormField(
        autofocus: false,
        controller: soyadiEditingController,
        keyboardType: TextInputType.name,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Soyadı Boş Geçilemez");
          }
          return null;
        },
        onSaved: (value) {
          soyadiEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.account_circle),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Soyadı",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    final eposta = TextFormField(
        autofocus: false,
        controller: epostaEditingController,
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Lütfen e-posta adresinizi girin");
          }
          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
              .hasMatch(value)) {
            return ("Lütfen geçerli eposta adresini giriniz");
          }
          return null;
        },
        onSaved: (value) {
          adiEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.mail),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "E-Posta",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    final sifre = TextFormField(
        autofocus: false,
        controller: passwordEditingController,
        obscureText: true,
        validator: (value) {
          RegExp regex = new RegExp(r'^.{6,}$');
          if (value!.isEmpty) {
            return ("Giriş için şifreniz gerekli");
          }
          if (!regex.hasMatch(value)) {
            return ("Geçerli Parolayı Girin(Min. 6 Karakter)");
          }
        },
        onSaved: (value) {
          adiEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.vpn_key),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Şifre",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    final sifreTekrar = TextFormField(
        autofocus: false,
        controller: confirmPasswordEditingController,
        obscureText: true,
        validator: (value) {
          if (confirmPasswordEditingController.text !=
              passwordEditingController.text) {
            return "Şifre eşleşmiyor";
          }
          return null;
        },
        onSaved: (value) {
          confirmPasswordEditingController.text = value!;
        },
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.vpn_key),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Şifreyi Onayla",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    final kaydetButonu = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.teal,
      child: MaterialButton(
          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () {
            signUp(epostaEditingController.text, passwordEditingController.text);
          },
          child: Text(
            "Üye Ol",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          )),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.teal),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                        height: 180,
                        child: Image.asset(
                          "assets/image/pbslogo.png",
                          fit: BoxFit.contain,
                        )),
                    SizedBox(height: 45),
                    isim,
                    SizedBox(height: 20),
                    soyadi,
                    SizedBox(height: 20),
                    eposta,
                    SizedBox(height: 20),
                    sifre,
                    SizedBox(height: 20),
                    sifreTekrar,
                    SizedBox(height: 20),
                    kaydetButonu,
                    SizedBox(height: 15),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void signUp(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) => {postDetailsToFirestore()})
            .catchError((e) {
          Fluttertoast.showToast(msg: e!.message);
        });
      } on FirebaseAuthException catch (error) {
        switch (error.code) {
          case "invalid-email":
            errorMessage = "E-posta adresiniz hatalı biçimlendirilmiş görünüyor.";
            break;
          case "wrong-password":
            errorMessage = "Parolanız yanlış.";
            break;
          case "user-not-found":
            errorMessage = "Bu e-postaya sahip kullanıcı mevcut değil.";
            break;
          case "user-disabled":
            errorMessage = "Bu e-postaya sahip kullanıcı devre dışı bırakıldı.";
            break;
          case "too-many-requests":
            errorMessage = "çok fazla istek";
            break;
          case "operation-not-allowed":
            errorMessage = "E-posta ve Şifre ile oturum açma etkin değil.";
            break;
          default:
            errorMessage = "Tanımlanamayan bir Hata oluştu.";
        }
        Fluttertoast.showToast(msg: errorMessage!);
        print(error.code);
      }
    }
  }

  postDetailsToFirestore() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel();

    userModel.eposta = user!.email;
    userModel.uid = user.uid;
    userModel.adi = adiEditingController.text;
    userModel.soyadi= soyadiEditingController.text;

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Hesap Başarıyla Oluşturuldu. :) ");

    Navigator.pushAndRemoveUntil(
        (context),
        MaterialPageRoute(builder: (context) => LoginScreen()),
            (route) => false);
  }
}
