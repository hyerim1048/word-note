import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    const MaterialColor white = const MaterialColor(
      0xFFFFFFFF,
      const <int, Color>{
        50: const Color(0xFFFFFFFF),
        100: const Color(0xFFFFFFFF),
        200: const Color(0xFFFFFFFF),
        300: const Color(0xFFFFFFFF),
        400: const Color(0xFFFFFFFF),
        500: const Color(0xFFFFFFFF),
        600: const Color(0xFFFFFFFF),
        700: const Color(0xFFFFFFFF),
        800: const Color(0xFFFFFFFF),
        900: const Color(0xFFFFFFFF),
      },
    );
    return MaterialApp(
      title: 'Word Notes',
      theme: ThemeData(
        // This is the theme of your application
        fontFamily: 'RedHatDisplay',
        primarySwatch: Colors.blue,
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
    /*
    return ListTile(
      title: Text(word),
    );*/
    return Container(
        width: 100.0,
        height: 130.0,
        margin: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            boxShadow: [
              BoxShadow(
                  blurRadius: 2.0, color: Colors.grey, offset: Offset(1.0, 3.0))
            ]),
        child: Container(
          padding: EdgeInsets.all(30.0),
          child: Align(
            alignment: Alignment
                .center, // Align however you like (i.e .centerRight, centerLeft)
            child: Text(
              word,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                fontFamily: 'RedHatDisplay',
              ),
            ),
          ),
        ));
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
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.0),
        child: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text("Today's words", style: TextStyle(color: Colors.black)),
          backgroundColor: Color(0xFFFFFFFF),
          elevation: 0.0,
          centerTitle: false,
        ),
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
