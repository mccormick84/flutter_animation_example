import 'package:flutter/material.dart';

class SliverPage extends StatefulWidget {
  const SliverPage({Key? key}) : super(key: key);

  @override
  State<SliverPage> createState() => _SliverPageState();
}

class _SliverPageState extends State<SliverPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            // 앱바의 높이 설정
            expandedHeight: 150.0,
            // SliverAppBar 공간에 어떤 위젲을 만들지 설정
            flexibleSpace: FlexibleSpaceBar(
              title: const Text('Sliver Example'),
              background: Image.asset('repo/images/sunny.png'),
            ),
            backgroundColor: Colors.deepOrangeAccent,
          ),
          SliverList(
              delegate: SliverChildListDelegate([
            customCard('1'),
            customCard('2'),
            customCard('3'),
            customCard('4'),
          ])),
          SliverGrid(
              delegate: SliverChildListDelegate([
                customCard('1'),
                customCard('2'),
                customCard('3'),
                customCard('4'),
              ]),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2)),
        ],
      ),
    );
  }

  Widget customCard(String text) {
    return Card(
      child: SizedBox(
        height: 120,
        child: Center(
          child: Text(
            text,
            style: const TextStyle(fontSize: 40),
          ),
        ),
      ),
    );
  }
}
