import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OgunL extends StatefulWidget {
  @override
  _OgunLState createState() => _OgunLState();
}

class _OgunLState extends State<OgunL> {
  TextEditingController t1 = TextEditingController();
  TextEditingController t2 = TextEditingController();

  var liste1 = "";
  var liste2 = "";

  FirebaseAuth auth = FirebaseAuth.instance;
  ogunGetir() {
    FirebaseFirestore.instance
        .collection("Ogun")
        .doc(t1.text)
        .get()
        .then((gelenVeri) {
      setState(() {
        liste1 = gelenVeri.data()!['ogunAdi'];
        liste2 = gelenVeri.data()!['ogunListe'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Öğün Listesi"),
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        child: OgunListesi(),
      ),
    );
  }
}

class OgunListesi extends StatefulWidget {
  @override
  _OgunListesiState createState() => _OgunListesiState();
}

class _OgunListesiState extends State<OgunListesi> {
  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
        .collection('Ogun')
        .where("kullaniciid", isEqualTo: auth.currentUser!.uid)
        .snapshots();

    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;
            return ListTile(
              title: Text(data['ogunAdi']),
              subtitle: Text(data['ogunListe']),
            );
          }).toList(),
        );
      },
    );
  }
}
