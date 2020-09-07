import 'package:ecommerce/constant/images.dart';
import 'package:ecommerce/constant/strings.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/constant/colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Location extends StatefulWidget {
  @override
  _LocationState createState() => _LocationState();
}

class _LocationState extends State<Location> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.grey[100].withOpacity(0.1),
        actions: <Widget>[
          FlatButton(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            textColor: ThemeColors.redColor,
            onPressed: () {
              Navigator.pushReplacementNamed(context, "/tabs");
            },
            child: Row(
              children: <Widget>[
                Text(
                  "Skip",
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
                SizedBox(
                  width: 3,
                ),
                FaIcon(
                  FontAwesomeIcons.angleDoubleRight,
                  size: 20.0,
                )
              ],
            ),
          ),
        ],
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Image.asset(
                Images.locationPageLocationIcon,
                height: MediaQuery.of(context).size.height / 3,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: FittedBox(
                child: Text(
                  Strings.locationHiMessage,
                  style: TextStyle(
                    fontSize: 34.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10, bottom: 10),
              child: Text(
                Strings.locationChooseLocationMessage,
                style: TextStyle(
                  color: Colors.grey[800],
                  fontWeight: FontWeight.w500,
                  fontSize: 15.0,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.7,
              child: OutlineButton(
                highlightedBorderColor: ThemeColors.redColor,
                borderSide: BorderSide(
                  color: ThemeColors.redColor,
                  width: 2,
                ),
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(7.0)),
                color: ThemeColors.redColor,
                textColor: ThemeColors.redColor,
                onPressed: () {
                  Navigator.pushReplacementNamed(context, "/tabs");
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.navigation),
                    Text(
                      Strings.locationBtn,
                      style: TextStyle(fontSize: 19.0),
                    )
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.only(top: 50.0),
                child: Container(
                  margin: const EdgeInsets.only(top: 10.3),
                  height: 7,
                  width: MediaQuery.of(context).size.width * 0.30,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    border: Border.all(
                      color: Colors.transparent,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
