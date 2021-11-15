import 'package:flutter/material.dart';

Widget sideDrawer({context}) {
  return Drawer(
    child: Container(
      color: Color(0xffffffff),
      child: SafeArea(
        child: Container(
          margin: EdgeInsets.all(10),
          child: Column(
            children: [
              ListTile(
                title: Text(
                  'Home Page',
                  style: TextStyle(
                    color: Color(0xff433DF2),
                    fontSize: 23
                  ),
                ),
                onTap: () => Navigator.pushNamedAndRemoveUntil(context,'/', (Route<dynamic> route) => false),
                tileColor: Color(0xff433DF2),
                leading: Icon(Icons.home,size: 27,color: Color(0xff433DF2),),
              ),
              Container(
                height: 1,
                color: Color(0xff433DF2),
                margin: EdgeInsets.symmetric(horizontal: 10),
              ),
              ListTile(
                title: Text(
                  'Analysis',
                  style: TextStyle(
                    color: Color(0xff433DF2),
                    fontSize: 25
                  ),
                ),
                onTap: () => Navigator.pushNamed(context, '/analyzing'),
                tileColor: Color(0xff433DF2),
                leading: Icon(Icons.show_chart,size: 27,color: Color(0xff433DF2),),
              ),
              Container(
                height: 1,
                color: Color(0xff433DF2),
                margin: EdgeInsets.symmetric(horizontal: 10),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
