import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class KansekeriL extends StatefulWidget {
  @override
  _KansekeriLState createState() => _KansekeriLState();
}

class _KansekeriLState extends State<KansekeriL> {
  TextEditingController t1 = TextEditingController();
  TextEditingController t2 = TextEditingController();

  var liste1 = "";
  var liste2 = "";

  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kan Şekeri Değerleri"),
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        child: KansekeriListesi(),
      ),
    );
  }
}

class KansekeriListesi extends StatefulWidget {
  @override
  _KansekeriListesiState createState() => _KansekeriListesiState();
}

class _KansekeriListesiState extends State<KansekeriListesi> {
  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
        .collection('Kansekeri')
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
              title: Text(data['Kanseker']),
            );
          }).toList(),
        );
      },
    );
  }
}
