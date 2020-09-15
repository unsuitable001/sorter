import 'package:Shorter/model/sorted_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

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
      home: ChangeNotifierProvider(
        create: (context) => SortedList(),
        child: MyHomePage(title: 'Sorter')
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;
//  final SortedList sortedList;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  SortedList sortedList;
  @override
  void initState() {
    super.initState();
  }

  void _addNewRoll(String item, BuildContext scaffoldContext) {
    try {
      Provider.of<SortedList>(context, listen: false).addItem(item);
    } catch (e) {
      Scaffold.of(scaffoldContext).showSnackBar(SnackBar(content: const Text('This is not a number!'),));
    }
  }

  void _copySortedList(BuildContext scaffoldcontext) {
    Clipboard.setData(ClipboardData(text: Provider.of<SortedList>(context, listen: false).list ));
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
                  children: <Widget>[
                    Consumer<SortedList>(
                      builder: (context, data, child) => Text(
                        'Total Count : ${data.length}', 
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Consumer<SortedList>(
                      builder: (context, data, child) => SelectableText(
                      '${data.list}', 
                        onTap: () => {_copySortedList(context)}
                      ),
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
            onPressed: () => {
              _addNewRoll(textController.text, context),
              textController.text = ''
            },
            tooltip: 'Add Roll Nos.',
            child: Icon(Icons.add),
          );
        },
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

}
