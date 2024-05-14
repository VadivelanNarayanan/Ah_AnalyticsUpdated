import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SalesValue extends StatefulWidget {

  DateTime selectedDate;
  SalesValue({
    required  this.selectedDate
  });

  @override
  State<SalesValue> createState() => _SalesValueState();
}

class _SalesValueState extends State<SalesValue> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  DateTime? selecteddate;
  List salesData=[];
  List newleadsdata=[];

  @override
  void initState() {
    super.initState();
    fetchDataForSelectedMonth();
  } 

  @override
  void didUpdateWidget(covariant SalesValue oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedDate != oldWidget.selectedDate) {
      fetchDataForSelectedMonth();
    }
  }
  Future<void> fetchDataForSelectedMonth() async {
  newleadsdata.clear();
  salesData.clear();
  selecteddate=widget.selectedDate;

    firestore.collection("salesamount").where("month", isEqualTo: selecteddate!.month -1).where('year',isEqualTo: selecteddate!.year).snapshots().listen((salesamountdocs) {
      print("salesamount${salesamountdocs.docs.length}");
      if (salesamountdocs.docs.isNotEmpty) {
        setState(() {
          newleadsdata.add(salesamountdocs.docs[0].data());
          print("newleadsdata ${newleadsdata}");
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

  Widget build(BuildContext context) {
    return  Column(
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
                      "Net Sales",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                      )
                    ),
                    Text(
                      newleadsdata.isNotEmpty ?
                       newleadsdata[0]['netsales'] !=null ?  formatCurrency( newleadsdata[0]['netsales']) : 'Feature \n not done'
                      :'Feature\n Note Done',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: newleadsdata.isNotEmpty ?
                         newleadsdata[0]['netsales']!=null ? 20 : 15
                        :15,
                        fontWeight: FontWeight.w500,
                        color: newleadsdata.isNotEmpty ?
                        newleadsdata[0]['netsales']!=null ? Colors.black :Colors.red
                        :Colors.red,
                      )
                    ),
                  ],
                ),
              ],
            ),
          ) ,
        ),
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
                    Expanded(
                      child: Text(
                        "Advance Collected",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                        )
                      ),
                    ),
                    Expanded(
                      child: Text(
                        newleadsdata.isNotEmpty ?
                           newleadsdata[0]['advancedCollected'] !=null ?  formatCurrency(newleadsdata[0]['advancedCollected']) : 'Feature \n not done'
                        :'Feature\n Note Done',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: newleadsdata.isNotEmpty ?
                           newleadsdata[0]['advancedCollected'] !=null ? 20 : 15
                          :15,
                          fontWeight: FontWeight.w500,
                          color: newleadsdata.isNotEmpty ?
                           newleadsdata[0]['advancedCollected'] !=null ? Colors.black :Colors.red
                          :Colors.red,
                        ) 
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ) ,
        ),
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
                      "EMI Assured \n from net sales",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                      )
                    ),
                    Text(
                      newleadsdata.isNotEmpty ?
                        newleadsdata[0]['installmentamount'] !=null ?  formatCurrency(newleadsdata[0]['installmentamount']) : '0'
                      :'Feature\n Note Done',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: newleadsdata.isNotEmpty ?
                          newleadsdata[0]['installmentamount'] !=null ? 20 : 15
                        :15,
                        fontWeight: FontWeight.w500,
                        color: newleadsdata.isNotEmpty ?
                          newleadsdata[0]['installmentamount'] !=null ? Colors.black :Colors.red
                        :Colors.red,
                      )
                    ),
                  ],
                ),
              ],
            ),
          ) ,
        ), 
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
                    // Icon(Icons.circle),
                    Text(
                      "Cancel",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                      )
                    ),
                    Text(
                      newleadsdata.isNotEmpty ?
                         newleadsdata[0]['cancelled']!=null ?  formatCurrency(newleadsdata[0]['cancelled']) : 'Feature \n not done'
                      :'Feature\n Note Done',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: newleadsdata.isNotEmpty ?
                          newleadsdata[0]['cancelled']!=null ? 20 : 15
                        :15,
                        fontWeight: FontWeight.w500,
                        color: newleadsdata.isNotEmpty ?
                          newleadsdata[0]['cancelled'] !=null ? Colors.black :Colors.red
                        :Colors.red,
                      )
                    ),
                  ],
                ),
              ],
            ),
          ) ,
        ),   
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
                      "Downgrade",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                      )
                    ),
                    Text(
                      newleadsdata.isNotEmpty ? 
                        newleadsdata[0]['cancelled'] !=null ? newleadsdata[0]['cancelled'].toString() : 'Feature\nNot Done'
                      :'Feature\n Note Done',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: newleadsdata.isNotEmpty ?
                          newleadsdata[0]['cancelled'] !=null ? 20 :15
                        :15 ,
                        fontWeight: FontWeight.w500,
                        color:  newleadsdata.isNotEmpty ? 
                          newleadsdata[0]['cancelled'] !=null ? Colors.black:Colors.red
                        :Colors.red,
                      )
                    ),
                  ],
                ),
              ],
            ),
          ) ,
        ),
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
                    // Icon(Icons.circle),
                    Text(
                      "E-Nach",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                      )
                    ),
                    Text(
                      'Feature\n Note Done',
                      // salesData.isNotEmpty ?
                      //  salesData[0]['grosssales'] !=null ?  formatCurrency(salesData[0]['grosssales']) : 'Feature \n not done'
                      // :'Feature\n Note Done',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: salesData.isNotEmpty ?
                         salesData[0]['grosssales'] !=null ? 15 : 15
                        :15,
                        fontWeight: FontWeight.w500,
                        color: Colors.red
                        
                      )
                    ),
                  ],
                ),
              ],
            ),
          ) ,
        ),
      ],     
    );
  }
  String formatCurrency(dynamic amount) {
    final formatCurrency = NumberFormat.currency(locale: 'en_IN', symbol: '₹',decimalDigits:0 );
    return formatCurrency.format(amount);
  }
}