import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Keep Sorted',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Sorter'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<int> _list = new List();
  String _sortedList = '';


  void _addNewRoll(String item, BuildContext scaffoldContext) {
    setState(() {
      try {
        item.split(',').forEach((element) {
          _list.add(int.parse(element.trim()));
        });
        _list.sort();
        _sortedList =_list.join(', ');
      } catch (e) {
        Scaffold.of(scaffoldContext).showSnackBar(SnackBar(content: const Text('This is not a number!'),));
      }
    });
  }

  void _copySortedList(BuildContext scaffoldcontext) {
    Clipboard.setData(ClipboardData(text: _sortedList));
    Scaffold.of(scaffoldcontext).showSnackBar(SnackBar(content: const Text('Copied To Clipboard!'),));
  }

  @override
  Widget build(BuildContext context) {
    final textController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Builder(
        builder: (BuildContext context) {
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[Text('Total Count : ${_list.length}', style: TextStyle(fontWeight: FontWeight.bold),),
                    SelectableText(
                      '$_sortedList', 
                        onTap: () => {_copySortedList(context)}
                        ),
                  ],
                ),
                TextField(
                  controller: textController,
                    decoration: InputDecoration(
                        hintText: 'Enter roll numbers here (comma seperated)'
                    ),
                )
              ],
            ),
          );
        }
      ),
      floatingActionButton: Builder(
        builder: (BuildContext context) {
          return FloatingActionButton(
            onPressed: () => _addNewRoll(textController.text, context),
            tooltip: 'Add Roll Nos.',
            child: Icon(Icons.add),
          );
        },
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

}
