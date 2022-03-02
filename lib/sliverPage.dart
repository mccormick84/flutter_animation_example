import 'package:flutter/material.dart';
import 'dart:math' as math;

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
            // 스크롤 시 앱바 사라짐 여부
            pinned: true,
          ),
          SliverPersistentHeader(
            delegate: _HeaderDelegate(
              minHeight: 50,
              maxHeight: 150,
              child: Container(
                color: Colors.blue,
                child: Center(
                  child: Column(
                    children: const <Widget>[
                      Text(
                        'list 숫자',
                        style: TextStyle(fontSize: 30),
                      ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                  ),
                ),
              ),
            ),
            pinned: true,
          ),
          SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
            return Container(
              child: customCard('list count: $index'),
            );
          }, childCount: 10)),
          SliverPersistentHeader(
            delegate: _HeaderDelegate(
              minHeight: 50,
              maxHeight: 150,
              child: Container(
                color: Colors.blue,
                child: Center(
                  child: Column(
                    children: const <Widget>[
                      Text(
                        '그리드 숫자',
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                  ),
                ),
              ),
            ),
            pinned: true,
          ),
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
            style: const TextStyle(fontSize: 30),
          ),
        ),
      ),
    );
  }
}

class _HeaderDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  _HeaderDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  // 머리말을 만들 때 사용할 위젯을 배치
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  // math.max 함수를 이용해 가장 높은 값을 최대 높이로 설정
  @override
  double get maxExtent => math.max(maxHeight, minHeight);

  @override
  double get minExtent => minHeight;

  @override
  // 위젯을 새로 그릴지 여부
  bool shouldRebuild(_HeaderDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
