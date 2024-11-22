import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_index_selector/flutter_index_selector.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,

      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<String> lists = [];


  @override
  Widget build(BuildContext context) {
    List<String> letters = [
      'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J',
      'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T',
      'U', 'V', 'W', 'X', 'Y', 'Z',
    ];
    lists.clear();
    for(int i = 0; i < letters.length; i++){
      int randomInt = Random().nextInt(7) + 3;
      for(int j = 0; j < randomInt; j++){
        lists.add("这是第${letters[i]}组的 ==> 第${j}个数据");
      }
    }


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Stack(
        children: [
          ListView.separated(
            itemBuilder: (context, index) {
              return Container(
                height: 1,
                color: Colors.grey,
              );
            },
            separatorBuilder: (context, index) {
              return Container(
                height: 50,
                width: double.infinity,
                color: Colors.white,
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(lists[index]),
              );
            },
            itemCount: lists.length,
          ),
          Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            child: IndexSelector(
              keys: letters,
              onChanged: (v){
                print(v);
              },
            ),
          ),
        ],
      ),
    );
  }
}
