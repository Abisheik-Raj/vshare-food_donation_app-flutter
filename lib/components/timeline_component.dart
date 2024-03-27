import "package:flutter/material.dart";
import "package:timeline_tile/timeline_tile.dart";
import "package:vshare/resources/Colors.dart";
// import "package:material_design_icons_flutter/";

class TimeLineComponent extends StatelessWidget {
  TimeLineComponent({
    super.key,
    required this.isFirst,
    required this.isLast,
    required this.isPast,
    required this.color,
    required this.icon,
    required this.text,
  });

  final Color color;
  final bool isFirst;
  final bool isLast;
  final bool isPast;
  final icon;
  final text;

  @override
  Widget build(BuildContext context) {
    return TimelineTile(
      endChild: Padding(
        padding: EdgeInsets.all(20),
        child: Text(
          text,
          style: TextStyle(
              color: Colors.white, fontFamily: "PoppinsSemiBold", fontSize: 30),
        ),
      ),
      beforeLineStyle: LineStyle(color: color),
      indicatorStyle:
          IndicatorStyle(width: 30, iconStyle: IconStyle(iconData: icon)),
    );
  }
}
