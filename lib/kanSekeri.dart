import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Kansekeri extends StatefulWidget {
  @override
  _KansekeriState createState() => _KansekeriState();
}

class _KansekeriState extends State<Kansekeri> {
  TextEditingController t1 = TextEditingController();
  TextEditingController t2 = TextEditingController();

  var liste1 = "";

  FirebaseAuth auth = FirebaseAuth.instance;

  degerEkle() {
    FirebaseFirestore.instance.collection("Kansekeri").doc(t1.text).set({
      'kullaniciid': auth.currentUser!.uid,
      'Kanseker': t1.text,
    }).whenComplete(() => print("Tansiyon değerleri eklendi"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kan Şekeri Değeri Ekle"),
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
                  hintText: "Kan şeker değeri",
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
                      child: Text('Kan Şekeri Değeri Ekle'),
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
