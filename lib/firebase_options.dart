import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "api_key",
      authDomain: "uthermosillo.edu.mx",
      databaseURL:
          "https://console.firebase.google.com/u/0/project/apliacion-mobile-tienda/settings/general?hl=es",
      projectId: "apliacion-mobile-tienda",
      storageBucket: "",
      messagingSenderId: "your_messaging_sender_id",
      appId: "483509185955",
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Apliacion mobile Tienda',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Firebase Example'),
      ),
      body: Center(
        child: Text(
          'Firebase Initialized Successfully!',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
