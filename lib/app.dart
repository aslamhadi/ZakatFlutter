import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or press Run > Flutter Hot Reload in IntelliJ). Notice that the
        // counter didn't reset back to zero; the application is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Kalkulator Zakat'),
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
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _controller = new TextEditingController();
  int goldPrice = 588296;
  int nishab = 85;
  bool _eligible = false;
  double _zakatValue = 0.00;

  void _eligibleToZakat() {
    var currentValue = int.parse(_controller.text);
    var nishabRupiah = goldPrice * nishab;

    if (currentValue >= nishabRupiah) {
      setState(() {
        _eligible = true;
        _zakatValue = 2.5/100 * currentValue;
      });
    } else {
      setState(() {
        _eligible = false;
        _zakatValue = 0.00;
      });
    } 
  }

  @override
  Widget build(BuildContext context) {
    var nishabRupiah = goldPrice * nishab;
    const textStyle = const TextStyle(
      fontSize: 20.00,
      fontWeight: FontWeight.bold
    );

    final idr = new NumberFormat("#,##0.00", "en_US");    
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return new Scaffold(
      appBar: new AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: new Text(widget.title),
      ),
      body: new Column(
        children: <Widget>[
          new ListTile(
            leading: const Icon(Icons.money_off),
            title: new TextField(
              controller: _controller,
              decoration: new InputDecoration(
                hintText: "0"
              ),
            ),
            subtitle: const Text('Jumlah Saldo'),
          ),
          new ListTile(
            leading: const Icon(Icons.attach_money),
            title: const Text('Harga Emas'),
            subtitle: new Text('Rp. ' + idr.format(goldPrice).toString()), 
          ),
          new ListTile(
            leading: const Icon(Icons.attach_money),
            title: new Text('Nishab Emas (' + nishab.toString() + 'gr)'),
            subtitle: new Text('Rp. ' + idr.format(nishabRupiah).toString()), 
          ),
          new ListTile(
            leading: const Icon(Icons.attach_money),
            title: new Text('Sudah Wajib Zakat'),
            subtitle: new Text(_eligible ? "Sudah" : "Belum"), 
          ),
          new ListTile(
            leading: const Icon(Icons.attach_money),
            title: new Text('Jumlah Zakat'),
            subtitle: new Text(
              'Rp. ' + idr.format(_zakatValue).toString(),
              style: textStyle,
            ), 
          ),
          new RaisedButton(
            onPressed: _eligibleToZakat,
            child: new Text('Hitung Zakat'),
          ),
        ],
      )
    );
  }
}