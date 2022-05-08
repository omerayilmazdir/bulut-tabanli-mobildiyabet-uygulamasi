import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EgzersizL extends StatefulWidget {
  @override
  _EgzersizLState createState() => _EgzersizLState();
}

class _EgzersizLState extends State<EgzersizL> {
  TextEditingController t1 = TextEditingController();
  TextEditingController t2 = TextEditingController();

  var liste1 = "";

  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Yapılacak Egzersizler"),
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        child: EgzersizListesi(),
      ),
    );
  }
}

class EgzersizListesi extends StatefulWidget {
  @override
  _EgzersizListesiState createState() => _EgzersizListesiState();
}

class _EgzersizListesiState extends State<EgzersizListesi> {
  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
        .collection('Egzersiz')
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
              title: Text(data['egzersiz']),
            );
          }).toList(),
        );
      },
    );
  }
}
