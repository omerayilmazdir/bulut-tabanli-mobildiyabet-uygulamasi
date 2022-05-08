import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Tansiyon extends StatefulWidget {
  @override
  _TansiyonState createState() => _TansiyonState();
}

class _TansiyonState extends State<Tansiyon> {
  TextEditingController t1 = TextEditingController();
  TextEditingController t2 = TextEditingController();

  var liste1 = "";
  var liste2 = "";

  FirebaseAuth auth = FirebaseAuth.instance;

  degerEkle() {
    FirebaseFirestore.instance.collection("Tansiyon").doc(t1.text).set({
      'kullaniciid': auth.currentUser!.uid,
      'BTans': t1.text,
      'KTans': t2.text,
    }).whenComplete(() => print("Tansiyon değerleri eklendi"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tansiyon Değerleri Ekle"),
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
                  hintText: "Büyük tansiyon",
                ),
              ),
              TextFormField(
                controller: t2,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  hintText: "Küçük tansiyon",
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
                      child: Text('Tansiyon Değerleri Ekle'),
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
