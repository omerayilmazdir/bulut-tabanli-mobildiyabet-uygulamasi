import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Suhesabi extends StatefulWidget {
  @override
  _SuhesabiState createState() => _SuhesabiState();
}

class _SuhesabiState extends State<Suhesabi> {
  TextEditingController t1 = TextEditingController();
  TextEditingController t2 = TextEditingController();

  var liste1 = "";
  var liste2 = "";

  FirebaseAuth auth = FirebaseAuth.instance;

  ogunEkle() {
    FirebaseFirestore.instance.collection("Suhesabi").doc(t1.text).set({
      'kullaniciid': auth.currentUser!.uid,
      'kilo': t1.text,
      'sonuc': t2.text,
    }).whenComplete(() => print("Su hesabı eklendi"));
  }

  ogunGetir() {
    FirebaseFirestore.instance
        .collection("Suhesabi")
        .doc(t1.text)
        .get()
        .then((gelenVeri) {
      setState(() {
        liste1 = gelenVeri.data()!['kilo'];
        liste2 = gelenVeri.data()!['sonuc'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Su Hesabı"),
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        child: Center(
          child: Column(
            children: [
              TextFormField(
                controller: t1,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  hintText: "Kilo",
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 20.0)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(padding: EdgeInsets.only(left: 10.0)),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(elevation: 5),
                    onPressed: ogunEkle,
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: 8,
                        bottom: 8,
                        left: 10,
                        right: 10,
                      ),
                      child: Text('Hesapla'),
                    ),
                  ),
                ],
              ),
              Padding(padding: EdgeInsets.only(top: 10.0)),
              ListTile(
                title: Text(liste1),
                subtitle: Text(liste2),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
