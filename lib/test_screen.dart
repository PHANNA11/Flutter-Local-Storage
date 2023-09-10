import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  List<String> names = [];
  void setDataName({String? name}) async {
    var prefs = await SharedPreferences.getInstance();
    names.add(name!);
    prefs.setStringList('names', names);
    getData();
  }

  void getData() async {
    var prefs = await SharedPreferences.getInstance();
    setState(() {
      names = prefs.getStringList('names') ?? [];
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        itemCount: names.length,
        itemBuilder: (context, index) => Card(
          elevation: 0,
          child: ListTile(
            title: Text(names[index]),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setDataName(name: 'Dany');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
