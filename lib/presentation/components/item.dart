import 'package:flutter/material.dart';

Widget listItem({mount, date, title, subtitle, type}) {
  String image;
  if (type == 'income') {
    image = 'assets/icons/incomeIcon.png';
  } else if (type == 'outcome') {
    image = 'assets/icons/expenseIcon.png';
  } else {
    image = '';
  }
  return Card(
    child: Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                image,
                height: 50,
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 6),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        title,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Text(
                        subtitle,
                        overflow: TextOverflow.ellipsis,
                        style:
                            TextStyle(fontSize: 17, color: Color(0xff808080)),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      mount,
                      style:
                      TextStyle(
                          fontSize: 17,
                          color: Color(0xff4f6ef4),
                        fontWeight: FontWeight.bold,
                        fontFamily: 'comic'
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      date.toString(),
                      style: TextStyle(fontSize: 16, color: Color(0xff505050)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    ),
    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  );
}
