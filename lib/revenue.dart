import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';

class Revenue extends StatefulWidget {
    DateTime selectedDate;
   Revenue({
    required  this.selectedDate
   });

  @override
  State<Revenue> createState() => _RevenueState();
}

class _RevenueState extends State<Revenue> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  List watsonData=[];
  List salesData=[];


  // late DateTime _selectedDate=DateTime.now();
  DateTime? selecteddate;

  @override
  void initState() {
    super.initState();
    // _selectedDate = DateTime.now();
    fetchDataForSelectedMonth();
  }

  @override
  void didUpdateWidget(covariant Revenue oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedDate != oldWidget.selectedDate) {
      fetchDataForSelectedMonth();
    }
  }

  // Future<void> _selectDate(BuildContext context) async {
  //   final DateTime? picked = await showDatePicker(
  //     context: context,
  //     initialDate: widget.selectedDate,
  //     firstDate: DateTime(2012),
  //     lastDate:DateTime.now(),
  //     initialDatePickerMode: DatePickerMode.year,
  //   );
  //   if (picked != null && picked != widget.selectedDate) {
  //     setState(() {
  //       widget.selectedDate = picked;
  //     });
  //     fetchDataForSelectedMonth();
  //   } else {
  //     setState(() {
  //       widget.selectedDate = DateTime.now();
  //     });
  //     fetchDataForSelectedMonth();
  //   }
  // }


  Future<void> fetchDataForSelectedMonth() async {
  watsonData.clear();
  salesData.clear();
  selecteddate=widget.selectedDate;
   await firestore.collection("watsondata").where("month", isEqualTo: selecteddate!.month -1).where('year',isEqualTo: selecteddate!.year).snapshots().listen((watsondatadocs) {
      print("wastondataaaa${watsondatadocs.docs}");
      if (watsondatadocs.docs.isNotEmpty) {
        setState(() {
          watsonData.add(watsondatadocs.docs[0].data());
          print("watsonData ${watsonData}");
        });
      }
    });
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
  //  String formattedMonth =DateFormat('MMMM yyyy').format(_selectedDate); 
    return Column(
      children: [
        SizedBox(height: 10,),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.end,
        //   children: [
        //     ElevatedButton(
        //       onPressed: (){},
        //       // onPressed: () => _selectDate(context),
        //       style: ElevatedButton.styleFrom(
        //         primary:  Color(0xfff0dbaf), 
        //         shape: RoundedRectangleBorder(
        //           borderRadius: BorderRadius.circular(10.0),
        //         ),
        //       ),
        //       child: Padding(
        //         padding: EdgeInsets.symmetric(horizontal: 3,vertical: 4),
        //         child: Row(
        //           mainAxisAlignment: MainAxisAlignment.end,
        //           children: [
        //             Text('$formattedMonth'),
        //             Icon(Icons.arrow_drop_down_rounded)
        //           ],
        //         ),
        //       ),
        //     ),
        //   ],
        // ),
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
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "Gross Sales \n Value",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                          )
                        ),
                        Text(
                          salesData.isNotEmpty ?
                           salesData[0]['grosssales'] !=null ?  formatCurrency(salesData[0]['grosssales']) : 'Feature \n not done'
                          :'Feature\n Note Done',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: salesData.isNotEmpty ?
                             salesData[0]['grosssales'] !=null ? 20 : 15
                            :15,
                            fontWeight: FontWeight.w500,
                            color: salesData.isNotEmpty ?
                             salesData[0]['grosssales'] !=null ? Colors.black :Colors.red
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
                  "Gross Sales",
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700 ,
                  )
                ),)
              )
            )
          ],
        ),
        SizedBox(height: 20,),
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
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "Amount Assured",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                          )
                        ),
                        Text(
                          watsonData.isNotEmpty ?
                           watsonData[0]['totalemiassured'] !=null ? formatCurrency(watsonData[0]['totalemiassured']): 'Feature \n not done'
                          :'Feature\n Note Done',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize:watsonData.isNotEmpty ?
                             watsonData[0]['totalemiassured'] !=null ? 20 : 15
                            :15,
                            fontWeight: FontWeight.w500,
                            color: watsonData.isNotEmpty ?
                             watsonData[0]['totalemiassured'] !=null ?Colors.black :Colors.red
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
                          "Amount Collected ",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                          )
                        ),
                        Text(
                          watsonData.isNotEmpty ?
                           watsonData[0]['totalemireceived'] !=null ?formatCurrency( watsonData[0]['totalemireceived']): 'Feature \n Not Done'
                          :'Feature\n Note Done',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: watsonData.isNotEmpty 
                             ?watsonData[0]['totalemireceived'] !=null ? 20 :15
                            :15,
                            fontWeight: FontWeight.w500,
                            color: watsonData.isNotEmpty ?
                             watsonData[0]['totalemireceived'] !=null ? Colors.black :Colors.red
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
                          "Net Increse \n in Montly \n Collected Assured  ",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                          )
                        ),
                        Icon(
                          watsonData.isNotEmpty 
                           ?watsonData[0]['netincrease'].toString().startsWith('-') ?  Icons.arrow_downward_outlined : Icons.arrow_upward
                          :Icons.error_outline,
                          color:watsonData.isNotEmpty ? watsonData[0]['netincrease'].toString().startsWith('-') ? Colors.red : Colors.green :Colors.black,
                        ),
                        Text(
                          watsonData.isNotEmpty ? 
                            watsonData[0]['netincrease']!=null ?
                            NumberFormat.currency(locale: 'en_IN',symbol: "",decimalDigits: 0 ).format( (int.parse(watsonData[0]['netincrease'].toString())).abs()) : 'Feature \n Not Done'
                          : 'Feature \n Not Done',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: watsonData.isNotEmpty ?
                              watsonData[0]['netincrease']!=null ? 20 : 15
                            :15,
                            fontWeight: FontWeight.w500,
                            color:  watsonData.isNotEmpty ?
                              watsonData[0]['netincrease']!=null ? watsonData[0]['netincrease'].toString().startsWith('-') ? Colors.red : Colors.green
                            : Colors.red  :Colors.red, 
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
                  "Amount",
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700 ,
                  )
                ),)
              )
            )
          ],
        ),
        SizedBox(height: 7,),
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
                          "Refund Completed Value",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                          )
                        ),
                        Text(
                          salesData.isNotEmpty ? 
                            salesData[0]['refundcomplete'] !=null ?  salesData[0]['refundcomplete'].toString() : 'Feature \n Not Done'
                          : 'Feature\n Note Done',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: salesData.isNotEmpty ?
                              salesData[0]['refundcomplete'] ==null ?15: 20
                            : 15,
                            fontWeight: FontWeight.w500,
                            color: salesData.isNotEmpty ? salesData[0]['refundcomplete'] ==null ? Colors.red:Colors.black : Colors.red  ,
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
                          "Refund Request Value",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                          )
                        ),
                        Text(
                          salesData.isNotEmpty ? 
                            salesData[0]['refundrequest'] !=null ?  salesData[0]['refundrequest'].toString() : 'Feature \n Not Done'
                          : 'Feature\n Note Done',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: salesData.isNotEmpty ?
                              salesData[0]['refundrequest'] ==null ? 15: 20
                            : 15 ,
                            fontWeight: FontWeight.w500,
                            color: salesData.isNotEmpty ? salesData[0]['refundrequest'] ==null ? Colors.red:Colors.black : Colors.red  ,
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
                  "Refund",
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
  String formatCurrency(dynamic amount) {
    final formatCurrency = NumberFormat.currency(locale: 'en_IN', symbol: '₹',decimalDigits:0 );
    return formatCurrency.format(amount);
  }
}

