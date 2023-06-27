import 'package:flutter/material.dart';
import 'database_helper.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Map<String, dynamic>> _rows = [];

  @override
  void initState() {
    super.initState();
    fetchRows();
  }

  Future<void> fetchRows() async {
    List<Map<String, dynamic>> rows =
        await DatabaseHelper.instance.queryAll();
    setState(() {
      _rows = rows;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter SQLite Example',
      home: Scaffold(
        appBar: AppBar(title: Text('Flutter SQLite Example')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                child: Text('Insert into Database'),
                onPressed: () async {
                  Map<String, dynamic> row = {
                    DatabaseHelper.columnName: 'John Doe',
                  };
                  int id = await DatabaseHelper.instance.insert(row);
                  print('Inserted row id: $id');
                },
              ),
              ElevatedButton(
                child: Text('Fetch All Rows'),
                onPressed: fetchRows,
              ),
              SizedBox(height: 20),
              Text(
                'Fetched Rows:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: _rows.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(_rows[index][DatabaseHelper.columnName]),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
