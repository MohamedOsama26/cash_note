import 'package:cash_note/constants/enums.dart';
import 'package:cash_note/logic/data/item_data.dart';
import 'package:cash_note/logic/models/item_data_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class NewItemScreen extends StatefulWidget {
  const NewItemScreen({Key? key}) : super(key: key);
  @override
  _NewItemScreenState createState() => _NewItemScreenState();
}

class _NewItemScreenState extends State<NewItemScreen> {
  final _formKey = GlobalKey<FormState>();

  late DatabaseHandler db;

  final _title = TextEditingController();
  final _subTitle = TextEditingController();
  final _amount = TextEditingController();
  String _typeString = ItemType.income.toString().split('.').last;
  ItemType? _type = ItemType.income;
  final _date = TextEditingController();
  late Item newItem;
  List<Item> items = [];

  @override
  void initState() {
    super.initState();
    this.db = DatabaseHandler();
    this.db.initializeDb().whenComplete(() async {
      items = await this.db.readItems();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff4f6ef4),
        resizeToAvoidBottomInset: false,
        body: Container(
          margin: EdgeInsets.only(top: 50),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(30), topLeft: Radius.circular(30)),
            color: Color(0xffffffff),
          ),

          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  child: Text(
                    'ADD NEW ITEM',
                    style: TextStyle(color: Color(0xa4454545), fontSize: 30),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom:
                              BorderSide(color: Color(0xa6454545), width: 5),),),
                ),


                //=========================== RadioButtons for itemType
                Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Expanded(
                        child: ListTile(
                          contentPadding: EdgeInsets.all(0),
                          title: Text('Income', style: TextStyle(fontSize: 20)),
                          leading: Radio<ItemType>(
                            value: ItemType.income,
                            groupValue: _type,
                            onChanged: (value) {
                              setState(() {
                                _type = value;
                                _typeString = value.toString().split('.').last;
                              });
                            },
                            activeColor: Color(0xff4f6ef4),
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListTile(
                          contentPadding: EdgeInsets.all(0),
                          title: Text(
                            'Outcome',
                            style: TextStyle(fontSize: 20),
                          ),
                          leading: Radio<ItemType>(
                            value: ItemType.outcome,
                            groupValue: _type,
                            onChanged: (value) {
                              setState(() {
                                _type = value;
                                _typeString = value.toString().split('.').last;
                              });
                            },
                            activeColor: Color(0xff4f6ef4),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                //=========================== TextField for itemTitle
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    controller: _title,
                    style: TextStyle(
                      fontSize: 20,
                      color: Color(0xd5000000),
                    ),
                    decoration: const InputDecoration(
                      labelText: 'Title',
                      labelStyle: TextStyle(
                        fontSize: 20,
                      ),
                      focusColor: Color(0xff4f6ef4),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xff4f6ef4), width: 1),
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                      hintText: 'Enter the item title',
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xff4f6ef4), width: 0.5),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xffff0000),
                        ),
                      ),
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                ),

                //=========================== TextField for item Subtitle
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    style: TextStyle(
                      fontSize: 20,
                      color: Color(0xd5000000),
                    ),
                    controller: _subTitle,
                    decoration: const InputDecoration(
                      labelText: 'Subtitle',
                      focusColor: Color(0xff4f6ef4),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xff4f6ef4), width: 1),
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                      hintText: 'Enter the subtitle',
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xff4f6ef4), width: 0.5),
                      ),
                    ),
                  ),
                ),

                //=========================== TextField for item Amount
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    controller: _amount,
                    style: TextStyle(
                      fontSize: 20,
                      color: Color(0xd5000000),
                    ),
                    keyboardType: TextInputType.numberWithOptions(signed: true),
                    decoration: const InputDecoration(
                      labelText: 'Amount',
                      focusColor: Color(0xff4f6ef4),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xff4f6ef4), width: 1),
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                      hintText: 'Enter amount of money',
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xff4f6ef4), width: 0.5),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xffff0000),
                        ),
                      ),
                    ),
                    validator: (String? value) {
                      final number = num.tryParse(value!);

                      if (value.isEmpty || number == null) {
                        return 'Please enter a number';
                      }
                      return null;
                    },
                  ),
                ),

                //=========================== TextField for item Inserted Date
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                      style: TextStyle(
                        fontSize: 20,
                        color: Color(0xd5000000),
                      ),
                      controller: _date,
                      keyboardType: TextInputType.datetime,
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.calendar_today,
                          color: Color(0xff4f6ef4),
                          size: 20,
                        ),
                        labelText: 'Date',
                        focusColor: Color(0xff4f6ef4),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xff4f6ef4), width: 1),
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                        hintText: 'Enter amount of money',
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xff4f6ef4), width: 0.5),),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xffff0000),
                          ),
                        ),
                      ),
                      readOnly: true,
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      onTap: () async {
                        var date = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime.now());
                        _date.text = date.toString().substring(0, 10);
                      }),
                ),

                //=========================== Buttons for Submit or Cancel
                Container(
                  padding: EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [

                      //====================== Submit
                      ElevatedButton(
                          style: ButtonStyle(
                            textStyle: MaterialStateProperty.all(
                              TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                                side: BorderSide(
                                  width: 2,
                                  color: Color(0xff4f6ef4),
                                ),
                              ),
                            ),
                            padding: MaterialStateProperty.all(
                              EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                            ),
                            backgroundColor: MaterialStateProperty.all(
                              Color(0xff4f6ef4),
                            ),
                          ),
                          child: Text('Submit'),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();

                              newItem = Item(
                                title: _title.text,
                                subTitle: _subTitle.text,
                                type: _typeString,
                                amount: double.parse(_amount.text),
                                creationDate: _date.text,
                              );

                              await db.insertItems(newItem);
                              Navigator.pushNamedAndRemoveUntil(
                                  context, '/', (route) => false);
                            }
                          }),

                      //====================== Cancel
                      ElevatedButton(
                        style: ButtonStyle(
                          textStyle: MaterialStateProperty.all(
                            TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                              side: BorderSide(
                                width: 2,
                                color: Color(0xff4f6ef4),
                              ),
                            ),
                          ),
                          padding: MaterialStateProperty.all(
                            EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                          ),
                          backgroundColor: MaterialStateProperty.all(
                            Color(0xffffffff),
                          ),
                        ),
                        onPressed: () => Navigator.pop(context),
                        child: Text('Cancel',style: TextStyle(color: Color(0xff4f6ef4)),),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
