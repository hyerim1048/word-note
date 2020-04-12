import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Word Notes',
      theme: ThemeData(
        // This is the theme of your application
        primarySwatch: Colors.blueGrey,
      ),
      home: MyHomePage(title: 'Word Notes'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController customController = new TextEditingController();
  final List<String> _wordList = <String>[];

  Widget _buildRow(String word) {
    return ListTile(
      title: Text(word),
    );
  }

  Widget _buildWordList() {
    return ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _wordList.length,
        itemBuilder: (BuildContext _context, int i) {
          return _buildRow(_wordList[i]);
        });
  }

  Future<String> _createAlertDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("word?"),
            content: TextField(controller: customController),
            actions: <Widget>[
              MaterialButton(
                elevation: 5.0,
                child: Text('Submit'),
                onPressed: () {
                  Navigator.of(context).pop(customController.text.toString());
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: _buildWordList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _createAlertDialog(context).then((onValue) {
            setState(() {
              _wordList.add(onValue);
            });
          });
        },
        tooltip: 'Add a Word',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
