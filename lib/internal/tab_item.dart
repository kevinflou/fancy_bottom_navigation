import 'package:badges/badges.dart';
import 'package:flutter/material.dart';

const double ICON_OFF = -3;
const double ICON_ON = 0;
const double TEXT_OFF = 3;
const double TEXT_ON = 1;
const double ALPHA_OFF = 0;
const double ALPHA_ON = 1;
const int ANIM_DURATION = 300;

class TabItem extends StatefulWidget {
  final UniqueKey uniqueKey;
  final String title;
  final IconData iconData;
  final bool selected;
  final Function(UniqueKey uniqueKey) callbackFunction;
  final Color textColor;
  final Color iconColor;
  int nbNotifications;

  TabItem({@required this.uniqueKey,
    @required this.selected,
    @required this.iconData,
    @required this.title,
    @required this.callbackFunction,
    @required this.textColor,
    @required this.iconColor,
    @required this.nbNotifications}) : super(key: uniqueKey);

  @override
  _TabItemState createState() => _TabItemState();
}

class _TabItemState extends State<TabItem> {



  final double iconYAlign = ICON_ON;
  final double textYAlign = TEXT_OFF;
  final double iconAlpha = ALPHA_ON;

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            child: AnimatedAlign(
                duration: Duration(milliseconds: ANIM_DURATION),
                alignment: Alignment(0, (widget.selected) ? TEXT_ON : TEXT_OFF),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.title,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                        fontWeight: FontWeight.w600, color: widget.textColor),
                  ),
                )),
          ),
          Container(
            height: double.infinity,
            width: double.infinity,
            child: AnimatedAlign(
              duration: Duration(milliseconds: ANIM_DURATION),
              curve: Curves.easeIn,
              alignment: Alignment(0, (widget.selected) ? ICON_OFF : ICON_ON),
              child: AnimatedOpacity(
                duration: Duration(milliseconds: ANIM_DURATION),
                opacity: (widget.selected) ? ALPHA_OFF : ALPHA_ON,
                child: _formatBadgeButton()
              ),
            ),
          )
        ],
      ),
    );
  }

  dynamic _formatBadgeButton(){
    if(widget.nbNotifications > 0) {
      return Badge(badgeContent: Text(
          widget.nbNotifications != null ? widget.nbNotifications.toString() : ""),
          child: IconButton(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            padding: EdgeInsets.all(0),
            alignment: Alignment(0, 0),
            icon: Icon(
              widget.iconData,
              color: widget.iconColor,
            ),
            onPressed: () {
              //setState(() {
                widget.nbNotifications = 0;
              //});

              widget.callbackFunction(widget.uniqueKey);
              setState(() => {
                print("Coucou, notifs : " + widget.nbNotifications.toString())
              });
            },)
      );
    }else{
      return  IconButton(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            padding: EdgeInsets.all(0),
            alignment: Alignment(0, 0),
            icon: Icon(
              widget.iconData,
              color: widget.iconColor,
            ),
            onPressed: () {
              setState(() => {

              });
              widget.callbackFunction(widget.uniqueKey);
            },);
    }
  }
}
