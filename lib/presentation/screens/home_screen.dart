import 'package:cash_note/logic/data/item_data.dart';
import 'package:cash_note/logic/models/item_data_model.dart';
import 'package:cash_note/presentation/components/drawer.dart';
import 'package:cash_note/presentation/components/item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DatabaseHandler db = DatabaseHandler();
  late String sub;
  late String itemNumber;
  late List<Item> itemsList;
  late List<Item> listOfItems;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: sideDrawer(
        context: context,
      ),
      body: Stack(children: [
        Container(
          height: double.maxFinite,
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.35,
                color: Color(0xff4f6ef4),
                width: double.infinity,
              ),
              Expanded(
                child: FutureBuilder(
                  future: db.readItems(sort: 'DESC'),
                  builder: (BuildContext futureBuilderContext,
                      AsyncSnapshot<List<Item>> snapshot) {
                    if (snapshot.hasData)
                      return ListView.builder(
                        padding: EdgeInsets.only(top: 65, bottom: 10),
                        itemCount: snapshot.data?.length,
                        itemBuilder:
                            (BuildContext itemBuilderContext, int index) {
                          print(snapshot.data![index].id);
                          if (snapshot.data![index].subTitle != null)
                            sub = snapshot.data![index].subTitle.toString();
                          else
                            sub = '';

                          if(snapshot.data![index].amount>=1000000){
                            itemNumber = ((snapshot.data![index].amount)/1000000).toStringAsFixed(2)+' M';
                          }
                          else if(snapshot.data![index].amount>=1000){
                            itemNumber = ((snapshot.data![index].amount)/1000).toStringAsFixed(2)+' K';
                          }
                          else {
                            itemNumber =
                                snapshot.data![index].amount.toStringAsFixed(2);
                          }

                          return GestureDetector(
                            child: listItem(
                              date: snapshot.data![index].creationDate,
                              type: snapshot.data![index].type,
                              title: snapshot.data![index].title,
                              mount: itemNumber,
                              subtitle: sub,
                            ),
                            onLongPress: () {
                              showMenu(
                                context: context,
                                position: RelativeRect.fromLTRB(
                                    MediaQuery.of(context).size.width, 0, 0, 0),
                                items: [
                                  PopupMenuItem(
                                    child: GestureDetector(
                                      child: Text('delete'),
                                      onTap: () {
                                        db.removeItems(int.parse(
                                            (snapshot.data![index].id)
                                                .toString()));
                                        setState(() {});
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      );
                    else if (snapshot.hasError)
                      return Center(
                        child: Text(
                            'Sorry there something went wrong \n ${snapshot.error}'),
                      );
                    else
                      return Center(child: CircularProgressIndicator());
                  },
                ),
              ),
            ],
          ),
        ),

        //front side of screen which has menu button and counters counters
        FutureBuilder(
          future: db.readItems(),
          builder: (BuildContext futureBuilderContext,
              AsyncSnapshot<List<Item>> snapshot) {
            double incomeSum = 0, outcomeSum = 0;
            if (snapshot.hasData) {
              for (var i = 0; i < snapshot.data!.length; i++) {
                if (snapshot.data![i].type == 'income')
                  incomeSum += snapshot.data![i].amount;
                else if (snapshot.data![i].type == 'outcome')
                  outcomeSum += snapshot.data![i].amount;
              }

              double balance = incomeSum - outcomeSum;

              String outcomeNumber;
              String incomeNum;
              String balanceNum;

              if(incomeSum>=1000000){
                incomeNum = (incomeSum/1000000).toStringAsFixed(2)+' M';
              }
              else if(incomeSum>=100000){
                incomeNum = (incomeSum/1000).toStringAsFixed(2)+' K';
              }
              else {
                incomeNum =
                    incomeSum.toStringAsFixed(2);
              }


              if(outcomeSum>=1000000){
                outcomeNumber = (outcomeSum/1000000).toStringAsFixed(2)+' M';
              }
              else if(outcomeSum>=100000){
                outcomeNumber = (outcomeSum/1000).toStringAsFixed(2)+' K';
              }
              else {
                outcomeNumber =
                    outcomeSum.toStringAsFixed(2);
              }



              if(balance>=1000000){
                balanceNum = (balance/1000000).toStringAsFixed(2)+' M';
              }
              else if(balance>=1000){
                balanceNum = (balance/100000).toStringAsFixed(2)+' K';
              }
              else {
                balanceNum =
                    balance.toStringAsFixed(2);
              }





              return Container(
                // child: OverflowBox(
                  child: Container(
                    child: Column(
                      children: [
                        SafeArea(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                              child: GestureDetector(child: Icon(Icons.menu,size: 40,color: Color(0xffffffff),),onTap: (){
                                Scaffold.of(futureBuilderContext).openDrawer();
                              }),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 25),
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                    color: Color(0xFFFFFFFF),
                                    borderRadius: BorderRadius.circular(15),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Color(0x22000000),
                                          offset: Offset(-2, 2),
                                          blurRadius: 5),
                                    ]),
                                child: Column(
                                  children: [
                                    Text(
                                      'EXPENSE',
                                      style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          outcomeNumber,
                                          style: TextStyle(
                                              color: Color(0xff4f6ef4),
                                              fontSize: 35,
                                              fontFamily: 'agency',
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          'EGP',
                                          style: TextStyle(
                                              fontFamily: 'agency',
                                              fontSize: 20,
                                              color: Color(0xff4f6ef4)),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(15),
                                margin: EdgeInsets.only(left: 10),
                                decoration: BoxDecoration(
                                    color: Color(0xFFFFFFFF),
                                    borderRadius: BorderRadius.circular(15),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Color(0x22000000),
                                          offset: Offset(-2, 2),
                                          blurRadius: 5),
                                    ]),
                                child: Column(
                                  children: [
                                    Text(
                                      'INCOME',
                                      style: TextStyle(
                                        color: Color(0xff000000),
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          incomeNum,
                                          style: TextStyle(
                                              color: Color(0xff4f6ef4),
                                              fontSize: 35,
                                              fontFamily: 'agency',
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          'EGP',
                                          style: TextStyle(
                                              fontFamily: 'agency',
                                              fontSize: 20,
                                              color: Color(0xff4f6ef4)),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 25),
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 25),
                          decoration: BoxDecoration(
                              color: Color(0xffffffff),
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                    color: Color(0x22000000),
                                    offset: Offset(-2, 2),
                                    blurRadius: 5),
                              ]),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    Container(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        'Balance',
                                        style: TextStyle(
                                            color: Color(0xff333333),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 22,
                                            fontFamily: 'comic'),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      child: Column(
                                        children: [
                                          Container(
                                            alignment: Alignment.bottomLeft,
                                            child: Row(
                                              children: [
                                                Text(
                                                  balanceNum,
                                                  style: TextStyle(
                                                      color: Color(0xff4f6ef4),
                                                      fontSize: 40,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily: 'agency'),
                                                  textAlign: TextAlign.start,
                                                ),
                                                Text(
                                                  'EGP',
                                                  style: TextStyle(
                                                    fontSize: 25,
                                                    fontFamily: 'agency',
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              FloatingActionButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/newItem');
                                },
                                child: Icon(
                                  Icons.add,
                                  color: Color(0xffffffff),
                                ),
                                backgroundColor: Color(0xff4f6ef4),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                // ),
              );
            } else
              return Center(child: CircularProgressIndicator());
          },
        ),
      ]),
    );
  }
}

