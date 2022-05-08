import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Egzersiz extends StatefulWidget {
  @override
  _EgzersizState createState() => _EgzersizState();
}

class _EgzersizState extends State<Egzersiz> {
  TextEditingController t1 = TextEditingController();

  var liste1 = "";

  FirebaseAuth auth = FirebaseAuth.instance;

  degerEkle() {
    FirebaseFirestore.instance.collection("Egzersiz").doc(t1.text).set({
      'kullaniciid': auth.currentUser!.uid,
      'egzersiz': t1.text,
    }).whenComplete(() => print("Egzersizler eklendi"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Egzersiz Ekle"),
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
                  hintText: "Egzersiz",
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 20.0)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(padding: EdgeInsets.only(left: 10.0)),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(elevation: 5),
                    onPressed: degerEkle,
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: 8,
                        bottom: 8,
                        left: 10,
                        right: 10,
                      ),
                      child: Text('Egzersiz Ekle'),
                    ),
                  ),
                ],
              ),
              Padding(padding: EdgeInsets.only(top: 10.0)),
              ListTile(
                title: Text(liste1),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
