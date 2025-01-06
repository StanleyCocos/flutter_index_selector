import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_index_selector/flutter_index_selector.dart';

List<String> letters = [
  'A',
  'B',
  'C',
  'D',
  'E',
  'F',
  'G',
  'H',
  'I',
  'J',
  'K',
  'L',
  'M',
  'N',
  'O',
  'P',
  'Q',
  'R',
  'S',
  'T',
  'U',
  'V',
  'W',
  'X',
  'Y',
  'Z',
];

List<String> names = [
  '追风',
  '星河梦',
  '月下独酌',
  '夏日微风',
  '清酒心清酒心清酒心',
  '不羁风',
  '夜空中最亮的星',
  '浅夏忆年',
  '一世倾心',
  '南风知我意我意我意',
  '流年水',
  '梦里花落',
  '青柠檬茶',
  '雨后初晴',
  '樱雨',
  '星空物语',
  '冷',
  '繁星点点',
  '墨青衣',
  '一抹1阳光',
  '初雪未央aaaa',
  '浅忆流年',
  'mmm暖阳倾城',
  '千与千寻',
  '独守一座城',
  '花开半夏',
  '夜未央',
  '静候音',
  '凉风有信',
  '倾城之恋',
  '幻月幽兰',
  '落花时节又逢君',
  '山有木兮',
  '一壶清酒醉红尘',
  '听风说秘密',
  '浅笑未央',
  '月光小筑',
  '微雨燕双飞',
  '白茶与风',
  '烟雨朦胧',
  '忆海流年',
  '北巷不夏',
  '萤火虫的梦',
  '春日迟迟',
  '君踏桃花归',
  '风起时想你',
  '半盏清茶',
  '明月入怀',
  '岁月成碑',
  '少年听雨歌楼上',
  '一念之间',
  '云中谁寄锦书来',
  '琴瑟和鸣',
  '夜风寄思念',
  '微风不燥',
  '山水相逢',
  '暗香浮动',
  '莫失莫忘',
  '竹影清风',
  '一年',
  '云卷云舒',
  '日舟',
  '芳草斜阳',
  '暖风旧巷',
  '星qlr',
  '长街听雨',
  '七里清风',
  '剑舞天涯',
  '白露霜',
  '夜色如歌s ',
  '酒入豪肠',
  '十里桃花开',
  '时光不老',
  '蓦然回首',
  '迷途未返',
  '长梦',
  '青山不改',
  '细雨轻愁',
  '月下长歌',
  '柳下桃花',
  '凌乱的记忆',
  '拾光旅行',
  '东风夜放花千树',
  '半夏微凉',
  '阳光正好',
  '爱笑的眼睛',
  '梧桐细雨',
  '十年如梦',
  '荒野星辰',
  '白驹过隙',
  '清风明月夜',
  '薄荷味的夏天',
  '橘子汽水',
  '雪中暖阳',
  '浅浅回忆',
  '沧海一声笑',
  '云淡风轻',
  '最后的烟火',
  '月亮邮递员',
  '南山有木',
  '时间偷不走的记忆'
];

extension ListExtension<E> on List<E> {
  E get random {
    int index = Random().nextInt(length - 1);
    return this[index];
  }
}

class ItemModel {
  String name = '';
  String label = '';

  ItemModel({this.name = '', this.label = ''});
}

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFE5E5E5)),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<ItemModel> items = [];

  @override
  Widget build(BuildContext context) {
    for (String index in letters) {
      for (int i = 3; i <= Random().nextInt(20); i++) {
        items.add(ItemModel(label: index, name: names.random));
      }
    }

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        title: const Text(
          '通讯录',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Stack(
        children: [
          _list,
          _index,
        ],
      ),
    );
  }

  Widget get _list {
    return ListView.separated(
      itemBuilder: (context, index) {
        return Container(
          height: 1,
          color: Colors.grey[100],
        );
      },
      separatorBuilder: (context, index) {
        return Container(
          height: 60,
          width: double.infinity,
          color: Colors.white,
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              Container(
                margin: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                clipBehavior: Clip.hardEdge,
                child:
                    Image.asset('images/${Random().nextInt(60) + 1}.pic.jpg'),
              ),
              Text(
                items[index].name,
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
            ],
          ),
        );
      },
      itemCount: items.length,
    );
  }

  Widget get _index {
    return Positioned(
      right: 0,
      top: 0,
      bottom: 0,
      child: IndexSelector(
        keys: letters,
        onChanged: (v) {
          if (kDebugMode) {
            print(v);
          }
        },
      ),
    );
  }
}
