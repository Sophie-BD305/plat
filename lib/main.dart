import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:what3words/what3words.dart';
import 'package:http/http.dart' as http;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

var api = What3WordsV3('MABA5QIB');

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void searchlocation() async {
    var words = await api
        .convertTo3wa(Coordinates(51.508344, -0.12549900))
        .language('en')
        .execute();
    print('Words: ${words.data()?.toJson()}');
  }

  void findlocation() async {
    var coordinates =
        await api.convertToCoordinates('index.home.raft').execute();

    if (coordinates.isSuccessful()) {
      print('Coordinates ${coordinates.data()!.toJson()}');
    } else {
      var error = coordinates.error();

      if (error == What3WordsError.BAD_WORDS) {
        // The three word address provided is invalid
        print('BadWords: ${error?.message}');
      } else if (error == What3WordsError.INTERNAL_SERVER_ERROR) {
        // Server Error
        print('InternalServerError: ${error?.message}');
      } else if (error == What3WordsError.NETWORK_ERROR) {
        // Network Error
        print('NetworkError: ${error?.message}');
      } else {
        print('${error?.code} : ${error?.message}');
      }
    }
  }

  void fetchPost() {
    print(http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts/1')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
              onPressed: () {
                firebaseFirestore
                    .collection('profile')
                    .doc('please...')
                    .set({'sophie': '935'});
              },
              child: const Text('제발 돼라!!!!!'),
            ),
            TextButton(
              onPressed: () {
                searchlocation();
              },
              child: const Text('이건?'),
            ),
            Text(
              '$fetchPost()',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
