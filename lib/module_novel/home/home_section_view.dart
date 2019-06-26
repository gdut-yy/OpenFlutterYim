import 'package:flutter/material.dart';

/// 栏目名称
/// 2019-03-27
class HomeSectionView extends StatelessWidget {
  final String title;

  HomeSectionView(this.title);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(15, 15, 0, 5),
      child: Row(
        children: <Widget>[
          Image.asset('assets/mod_novel/img/home_tip.png'),
          SizedBox(width: 10),
          Text(
            '$title',
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
