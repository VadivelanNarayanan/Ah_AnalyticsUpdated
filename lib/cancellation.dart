import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';

class cancellation extends StatefulWidget {
  DateTime selectedDate;
  cancellation({
    required  this.selectedDate
  });

  @override
  State<cancellation> createState() => _cancellationState();
}

class _cancellationState extends State<cancellation> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  DateTime? selecteddate;
  List salesData=[];


  @override
  void initState() {
    super.initState();
    fetchDataForSelectedMonth();
  } 

  @override
  void didUpdateWidget(covariant cancellation oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedDate != oldWidget.selectedDate) {
      fetchDataForSelectedMonth();
    }
  }
  Future<void> fetchDataForSelectedMonth() async {
  salesData.clear();
  selecteddate=widget.selectedDate;
  firestore.collection("salesdata").where("month", isEqualTo: selecteddate!.month -1).where('year',isEqualTo: selecteddate!.year).snapshots().listen((watsondatadocs) {
      if (watsondatadocs.docs.isNotEmpty) {
        setState(() {
          salesData.add(watsondatadocs.docs[0].data());
          print("salesdata ${salesData}");
        });
      }
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10,),
        Stack(
          children: [
            Container(
              margin: EdgeInsets.only(left: 20,right: 20,top: 10),
              decoration:BoxDecoration(
              borderRadius: BorderRadius.circular(15), 
              color: Colors.white
              ),
              child:Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "Total Cancellation \n Request ",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                          )
                        ),
                        Text(
                          salesData.isNotEmpty ?
                           salesData[0]['cancelrequest'] !=null ? salesData[0]['cancelrequest'].toString() : 'Feature \n Not Done'
                          :'Feature\n Note Done',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize:  salesData.isNotEmpty ?
                             salesData[0]['cancelrequest'] !=null ? 20 : 25
                            :15,
                            fontWeight: FontWeight.w500,
                            color:  salesData.isNotEmpty ?
                             salesData[0]['cancelrequest'] !=null ?Colors.black:Colors.red
                            :Colors.black,
                          )
                        ),
                     ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20,bottom: 20),
                      width: MediaQuery.of(context).size.width/1.5 ,
                      height: 0.2,
                      color: Colors.red,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "Total Cancellation \n Approved ",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                          )
                        ),
                        Text(
                          salesData.isNotEmpty ?
                           salesData[0]['cancelledsales']!=null ? salesData[0]['cancelledsales'].toString() : 'Feature \n Not Done'
                          :'Feature\n Note Done',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize:salesData.isNotEmpty  ?
                             salesData[0]['cancelledsales']!=null ? 20:15
                            :15,
                            fontWeight: FontWeight.w500,
                            color:salesData.isNotEmpty ?
                             salesData[0]['cancelledsales']!=null ? Colors.black :Colors.red
                            :Colors.red,
                          )
                        ),
                     ],
                    ),
                  ],
                ),
              ) ,
            ),
            Positioned(
              top:4,
              left: 50,
              child:Container(
                decoration:BoxDecoration(
                  borderRadius: BorderRadius.circular(5), 
                  color: Color(0xffdc8686),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.8),
                      blurRadius: 5, 
                      spreadRadius: 3,
                    ),
                  ],
                ),
                child:Padding(padding: EdgeInsets.symmetric(horizontal: 30  ,vertical: 2),
                child:  Text(
                  "CANCELLATION",
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700 ,
                  )
                ),)
              )
            )
          ],
        ),
        SizedBox(height:20),
        Stack(
          children: [
            Container(
              margin: EdgeInsets.only(left: 20,right: 20,top:10),
              decoration:BoxDecoration(
              borderRadius: BorderRadius.circular(15), 
              color: Colors.white
              ),
              child:Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "Total Downgrade \n Request",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                          )
                        ),
                        Text(
                          salesData.isNotEmpty ? 
                           salesData[0]['downgraderequest']!=null ? salesData[0]['downgraderequest'].toString() : 'Feature \n Not Done' :
                          'Feature\n Note Done',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: salesData.isNotEmpty ?
                             salesData[0]['downgraderequest']!=null ? 20:15
                            :15,
                            fontWeight: FontWeight.w500,
                            color: salesData.isNotEmpty ?
                             salesData[0]['downgraderequest']!=null ? Colors.black:Colors.red
                            :Colors.red,
                          )
                        ),
                     ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20,bottom: 20),
                      width: MediaQuery.of(context).size.width/1.5 ,
                      height: 0.2,
                      color: Colors.red,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "Total Downgrade \n Approved ",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                          )
                        ),
                        Text(
                          salesData.isNotEmpty ? 
                            salesData[0]['downgradedsales'] !=null ? salesData[0]['downgradedsales'].toString() : 'Feature\nNot Done'
                          :'Feature\n Note Done',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: salesData.isNotEmpty ?
                              salesData[0]['downgradedsales'] !=null ? 20 :15
                            :15 ,
                            fontWeight: FontWeight.w500,
                            color:  salesData.isNotEmpty ? 
                             salesData[0]['downgradedsales'] !=null ? Colors.black:Colors.red
                            :Colors.red,
                          )
                        ),
                     ],
                    ),
                  ],
                ),
              ) ,
            ),
            Positioned(
              top:4,
              left: 50,
              child:Container(
                decoration:BoxDecoration(
                  borderRadius: BorderRadius.circular(5), 
                  color: Color(0xffdc8686),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.8),
                      blurRadius: 5, 
                      spreadRadius: 3,
                    ),
                  ],
                ),
                child:Padding(padding: EdgeInsets.symmetric(horizontal: 30  ,vertical: 2),
                child:  Text(
                  "DOWNGRADE",
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700 ,
                  )
                ),)
              )
            )
          ],
        ),
      ],
    );
  }
}