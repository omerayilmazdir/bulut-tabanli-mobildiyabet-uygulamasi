import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:new_app/profilsayfasi.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.cyan[100],
        colorScheme:
            ColorScheme.fromSwatch().copyWith(secondary: Colors.blue[400]),
      ),
      home: Scaffold(
          appBar: AppBar(
            title: Text(
              "MobiDiyaAPP",
              style: TextStyle(fontSize: 22.0, color: Colors.white),
            ),
          ),
          body: Iskele()),
    );
  }
}

class Iskele extends StatefulWidget {
  @override
  _IskeleState createState() => _IskeleState();
}

class _IskeleState extends State<Iskele> {
  TextEditingController t1 = TextEditingController();
  TextEditingController t2 = TextEditingController();

  Future<void> kayitOl() async {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: t1.text, password: t2.text)
        .then((kullanici) {
      FirebaseFirestore.instance
          .collection("Kullanicilar")
          .doc(t1.text)
          .set({"KullaniciEposta": t1.text, "KullaniciSifre": t2.text});
    });
  }

  girisYap() {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: t1.text, password: t2.text)
        .then((kullanici) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => ProfilEkrani()),
          (Route<dynamic> route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(30),
        child: Center(
          child: Column(
            children: [
              Padding(padding: EdgeInsets.only(top: 10.0)),
              Image.asset("images/logo.png", width: 170, height: 170),
              Padding(padding: EdgeInsets.only(top: 5.0)),
              TextFormField(
                controller: t1,
                obscureText: false,
                decoration: InputDecoration(
                  icon: Icon(Icons.mail),
                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  hintText: "Email adresi",
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 10.0)),
              TextFormField(
                controller: t2,
                obscureText: true,
                decoration: InputDecoration(
                  icon: Icon(Icons.key),
                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  hintText: "Parola",
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 10.0)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(padding: EdgeInsets.only(left: 20.0)),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(elevation: 5),
                    onPressed: girisYap,
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: 8,
                        bottom: 8,
                        left: 10,
                        right: 10,
                      ),
                      child: Text('Giriş Yap'),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(left: 20.0)),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(elevation: 5),
                    onPressed: kayitOl,
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: 8,
                        bottom: 8,
                        left: 15,
                        right: 15,
                      ),
                      child: Text('Kayıt Ol'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
