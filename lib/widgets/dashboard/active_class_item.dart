import 'dart:ui';

import 'package:flutter/material.dart';

class ActiveClassItem extends StatefulWidget {
  @override
  _ActiveClassItemState createState() => _ActiveClassItemState();
}

class _ActiveClassItemState extends State<ActiveClassItem> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Card(
      color: Colors.orangeAccent,
      borderOnForeground: false,
      shape: RoundedRectangleBorder(
        side: BorderSide.none,
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(140),
          topRight: Radius.circular(10),
          bottomLeft: Radius.circular(10),
          topLeft: Radius.circular(10),
        ),
      ),
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: 15,
                      top: 10,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.school),
                        Text(
                          'Matematika',
                          textScaleFactor: 1.6,
                        ),
                        Text(
                          'Lecture',
                          textScaleFactor: 1.4,
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          right: 30,
                          left: size.width * 0.4,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.location_pin,
                              size: 45,
                            ),
                            Text(
                              '403',
                              textScaleFactor: 1.8,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Spacer(),
              Padding(
                padding: EdgeInsets.only(left: 15),
                child: Row(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              '15:45',
                              textAlign: TextAlign.start,
                            ),
                            SizedBox(
                              width: 300,
                              height: 8,
                              child: Container(
                                color: Colors.blue,
                              ),
                            ),
                            Text(
                              '16:30',
                              textAlign: TextAlign.start,
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Spacer(),
              Padding(
                padding: EdgeInsets.only(left: 15, bottom: 10),
                child: Row(children: [
                  Icon(Icons.people),
                  Text(
                    'Teacher name',
                    textScaleFactor: 1.6,
                  ),
                ]),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
