import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class YaziEkrani extends StatefulWidget {
  @override
  _YaziEkraniState createState() => _YaziEkraniState();
}

class _YaziEkraniState extends State<YaziEkrani> {
  TextEditingController t1 = TextEditingController();
  TextEditingController t2 = TextEditingController();

  var gelenYaziBasligi = "";
  var gelenYaziIcerigi = "";

  FirebaseAuth auth = FirebaseAuth.instance;

  yaziEkle() {
    FirebaseFirestore.instance.collection("Yazilar").doc(t1.text).set({
      'kullaniciid': auth.currentUser!.uid,
      'baslik': t1.text,
      'icerik': t2.text,
    }).whenComplete(() => print("Yazı eklendi"));
  }

  yaziGuncelle() {
    FirebaseFirestore.instance
        .collection("Yazilar")
        .doc(t1.text)
        .set({'baslik': t1.text, 'icerik': t2.text});
  }

  yaziSil() {
    FirebaseFirestore.instance.collection("Yazilar").doc(t1.text).delete();
  }

  yaziGetir() {
    FirebaseFirestore.instance
        .collection("Yazilar")
        .doc(t1.text)
        .get()
        .then((gelenVeri) {
      setState(() {
        gelenYaziBasligi = gelenVeri.data()!['baslik'];
        gelenYaziIcerigi = gelenVeri.data()!['icerik'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Yapılanlar Listesi"),
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        child: Center(
          child: Column(
            children: [
              TextField(
                  controller: t1,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    hintText: "Düzenlenen aktivite",
                  )),
              TextField(
                  controller: t2,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    hintText: "Gerçekleşme durumu",
                  )),
              Padding(padding: EdgeInsets.only(top: 20.0)),
              Row(
                children: [
                  Padding(padding: EdgeInsets.only(left: 80.0)),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(elevation: 5),
                    onPressed: yaziEkle,
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: 8,
                        bottom: 8,
                        left: 15,
                        right: 15,
                      ),
                      child: Text('Ekle'),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(left: 10.0)),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(elevation: 5),
                    onPressed: yaziGuncelle,
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: 8,
                        bottom: 8,
                        left: 10,
                        right: 10,
                      ),
                      child: Text('Güncelle'),
                    ),
                  ),
                ],
              ),
              Padding(padding: EdgeInsets.only(top: 10.0)),
              Row(
                children: [
                  Padding(padding: EdgeInsets.only(left: 80.0)),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(elevation: 5),
                    onPressed: yaziSil,
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: 8,
                        bottom: 8,
                        left: 22,
                        right: 22,
                      ),
                      child: Text('Sil'),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(left: 10.0)),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(elevation: 5),
                    onPressed: yaziGetir,
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: 8,
                        bottom: 8,
                        left: 22,
                        right: 22,
                      ),
                      child: Text('Getir'),
                    ),
                  ),
                ],
              ),
              ListTile(
                title: Text(gelenYaziBasligi),
                subtitle: Text(gelenYaziIcerigi),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
