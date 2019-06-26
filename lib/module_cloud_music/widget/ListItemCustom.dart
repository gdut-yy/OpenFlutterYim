import 'package:flutter/material.dart';

class ListItemCustom extends StatelessWidget {
  final List<Widget> children;
  final double height;
  final Function onTap;
  final bool divider;

  ListItemCustom(
      {this.children, this.height = 54, this.onTap, this.divider = true});

  @override
  Widget build(BuildContext context) {
    List<Widget> childrenList = <Widget>[
      Container(
        padding: EdgeInsets.only(left: 10, right: 10),
        height: height,
        child: Row(mainAxisSize: MainAxisSize.max, children: children),
      )
    ];
    
    if (divider) {
      childrenList.add(Divider(
        height: 0,
      ));
    }

    return InkWell(
      onTap: onTap,
      child: Column(mainAxisSize: MainAxisSize.min, children: childrenList),
    );
  }
}
