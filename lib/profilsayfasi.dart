import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_app/main.dart';
import 'package:new_app/yazisayfasi.dart';
import 'package:new_app/ogun.dart';
import 'package:new_app/ogunListe.dart';
import 'package:new_app/tansiyon.dart';
import 'package:new_app/tansiyonListe.dart';
import 'package:new_app/kanSekeri.dart';
import 'package:new_app/kanSekeriListe.dart';
import 'package:new_app/suHesabi.dart';
import 'package:new_app/egzersiz.dart';
import 'package:new_app/egzersizListe.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfilEkrani extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profil Sayfası"), actions: <Widget>[
        IconButton(
            icon: Icon(Icons.power_settings_new, size: 30),
            onPressed: () {
              FirebaseAuth.instance.signOut().then((deger) {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => Iskele()),
                    (Route<dynamic> route) => false);
              });
            })
      ]),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.book, size: 30),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => YaziEkrani()),
                (Route<dynamic> route) => true);
          }),
      body: ListView(
        children: [
          Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.arrow_drop_down_circle),
                  title: const Text('Öğün Listesi'),
                  subtitle: Text(
                    'Günlük öğün listesi planla.',
                    style: TextStyle(color: Colors.black.withOpacity(0.6)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Sağlıklı bir yaşam için dengeli ve düzenli beslenme gereklidir.',
                    style: TextStyle(color: Colors.black.withOpacity(0.6)),
                  ),
                ),
                ButtonBar(
                  alignment: MainAxisAlignment.start,
                  children: [
                    FlatButton(
                      textColor: const Color(0xFF6200EE),
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (_) => OgunL()),
                            (Route<dynamic> route) => true);
                      },
                      child: const Text('GÖZAT'),
                    ),
                    FlatButton(
                      textColor: const Color(0xFF6200EE),
                      onPressed: () {
                        {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (_) => Ogun()),
                              (Route<dynamic> route) => true);
                        }
                      },
                      child: const Text('EKLE'),
                    ),
                  ],
                ),
                Image.asset("images/ogun.png", width: 100, height: 100),
              ],
            ),
          ),
          Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.arrow_drop_down_circle),
                  title: const Text('Tansiyon Değerleri'),
                  subtitle: Text(
                    'Günlük ölçülen tansiyon değerleri.',
                    style: TextStyle(color: Colors.black.withOpacity(0.6)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Sağlığınız için tansiyon değerlerinizi ölçerek, bu değerlere dikkat ediniz.',
                    style: TextStyle(color: Colors.black.withOpacity(0.6)),
                  ),
                ),
                ButtonBar(
                  alignment: MainAxisAlignment.start,
                  children: [
                    FlatButton(
                      textColor: const Color(0xFF6200EE),
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (_) => TansiyonL()),
                            (Route<dynamic> route) => true);
                      },
                      child: const Text('GÖZAT'),
                    ),
                    FlatButton(
                      textColor: const Color(0xFF6200EE),
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (_) => Tansiyon()),
                            (Route<dynamic> route) => true);
                      },
                      child: const Text('YENİ DEĞER'),
                    ),
                  ],
                ),
                Image.asset("images/tans.png", width: 100, height: 100),
              ],
            ),
          ),
          Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.arrow_drop_down_circle),
                  title: const Text('Kan Şekeri Değerleri'),
                  subtitle: Text(
                    'Günlük ölçülen kan şekeri değerleri.',
                    style: TextStyle(color: Colors.black.withOpacity(0.6)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Sağlığınız için kan şekeri değerlerinizi ölçerek, bu değerlere dikkat ediniz.',
                    style: TextStyle(color: Colors.black.withOpacity(0.6)),
                  ),
                ),
                ButtonBar(
                  alignment: MainAxisAlignment.start,
                  children: [
                    FlatButton(
                      textColor: const Color(0xFF6200EE),
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (_) => KansekeriL()),
                            (Route<dynamic> route) => true);
                      },
                      child: const Text('GÖZAT'),
                    ),
                    FlatButton(
                      textColor: const Color(0xFF6200EE),
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (_) => Kansekeri()),
                            (Route<dynamic> route) => true);
                      },
                      child: const Text('YENİ DEĞER'),
                    ),
                  ],
                ),
                Image.asset("images/kan.png", width: 100, height: 100),
              ],
            ),
          ),
          Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.arrow_drop_down_circle),
                  title: const Text('Su Hesabı'),
                  subtitle: Text(
                    'Günlük su hesabınızı yapın.',
                    style: TextStyle(color: Colors.black.withOpacity(0.6)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Sağlınız için gerekli olan su hesabı miktarını dikkate alarak su tüketin.',
                    style: TextStyle(color: Colors.black.withOpacity(0.6)),
                  ),
                ),
                ButtonBar(
                  alignment: MainAxisAlignment.start,
                  children: [
                    FlatButton(
                      textColor: const Color(0xFF6200EE),
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (_) => Suhesabi()),
                            (Route<dynamic> route) => true);
                      },
                      child: const Text('HESAPLA'),
                    ),
                    FlatButton(
                      textColor: const Color(0xFF6200EE),
                      onPressed: () {
                        // Perform some action
                      },
                      child: const Text('GÜNCELLE'),
                    ),
                  ],
                ),
                Image.asset("images/su.png", width: 100, height: 100),
              ],
            ),
          ),
          Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.arrow_drop_down_circle),
                  title: const Text('Egzersiz'),
                  subtitle: Text(
                    'Egzersiz yapmak sizi zinde tutar.',
                    style: TextStyle(color: Colors.black.withOpacity(0.6)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Sağlınız için gerekli olan egzersizleri gerçekleştirin daha güçlü bir hayat yaşayın.',
                    style: TextStyle(color: Colors.black.withOpacity(0.6)),
                  ),
                ),
                ButtonBar(
                  alignment: MainAxisAlignment.start,
                  children: [
                    FlatButton(
                      textColor: const Color(0xFF6200EE),
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (_) => EgzersizL()),
                            (Route<dynamic> route) => true);
                      },
                      child: const Text('GÖZAT'),
                    ),
                    FlatButton(
                      textColor: const Color(0xFF6200EE),
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (_) => Egzersiz()),
                            (Route<dynamic> route) => true);
                      },
                      child: const Text('GÜNCELLE'),
                    ),
                  ],
                ),
                Image.asset("images/egzersiz.png", width: 100, height: 100),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
