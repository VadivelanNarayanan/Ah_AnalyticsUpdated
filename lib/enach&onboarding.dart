
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Enach extends StatefulWidget {
  DateTime selectedDate;
   Enach({
     required  this.selectedDate
  });

  @override
  State<Enach> createState() => _EnachState();
}

class _EnachState extends State<Enach> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  List watsonData=[];
  List onboardingdata=[];
  DateTime? selecteddate;
  // late DateTime _selectedDate=DateTime.now();

  @override
  void initState() {
    super.initState();
    setState(() {
      // selecteddate=widget.selectedDate;
      // print("dateeeeeeeeeeeee${widget.selectedDate}");
      fetchDataForSelectedMonth();
    });
  }
   @override
  void didUpdateWidget(covariant Enach oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedDate != oldWidget.selectedDate) {
      fetchDataForSelectedMonth();
    }
  }
 

  // Future<void> _selectDate(BuildContext context) async {
  //   final DateTime? picked = await showDatePicker(
  //     context: context,
  //     initialDate: _selectedDate,
  //     firstDate: DateTime(2012),
  //     lastDate:DateTime.now(),
  //     initialDatePickerMode: DatePickerMode.year,
  //   );
  //   if (picked != null && picked != _selectedDate) {
  //     setState(() {
  //       _selectedDate = picked;
  //     });
  //     fetchDataForSelectedMonth();
  //   } else {
  //     setState(() {
  //       _selectedDate = DateTime.now();
  //     });
  //     fetchDataForSelectedMonth();
  //   }
  // }

  Future<void> fetchDataForSelectedMonth() async {
    watsonData.clear();
    onboardingdata.clear();
    selecteddate=widget.selectedDate;
    firestore.collection("watsondata").where("month", isEqualTo:selecteddate!.month -1).where('year',isEqualTo:selecteddate!.year).snapshots().listen((watsondatadocs) {
      if (watsondatadocs.docs.isNotEmpty) {
        setState(() {
          watsonData.add(watsondatadocs.docs[0].data());
          print("watsonData ${watsonData}");
        });
      }
    });
    
    firestore.collection("onboardingdata").where("month", isEqualTo:selecteddate!.month -1).where('year',isEqualTo:selecteddate!.year).snapshots().listen((onboardingdatadocs) {
      if (onboardingdatadocs.docs.isNotEmpty) {
        setState(() {
          onboardingdata.add(onboardingdatadocs.docs[0].data());
          print("onboardingdata ${onboardingdata}");
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // String formattedMonth =DateFormat('MMMM yyyy').format(_selectedDate); 
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        SizedBox(height: 20,),
          //  Row(
          //   mainAxisAlignment: MainAxisAlignment.end,
          //   children: [
          //     ElevatedButton(
          //       onPressed: () => _selectDate(context),
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
              margin: EdgeInsets.only(left: 20,right: 20,top: 10),
              decoration:BoxDecoration(
              borderRadius: BorderRadius.circular(15), 
              color: Colors.white
              ),
              child:Padding(
                padding: EdgeInsets.all(20),
                child:Column(
                  children:  [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "No. of ENACH Filled  ",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                          )
                        ),
                        Text(
                          watsonData.isNotEmpty ?
                           watsonData[0]['totalnachapproved'] != null ? watsonData[0]['totalnachapproved'].toString() : 'Feature\n Not Done'
                          :'Feature\n Note Done',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize:  watsonData.isNotEmpty ?
                             watsonData[0]['totalnachapproved'] != null ? 20 :15
                            :15,
                            fontWeight: FontWeight.w500,
                            color:watsonData.isNotEmpty 
                             ? watsonData[0]['totalnachapproved'] != null ? Colors.black:Colors.red
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
                          "No. of ENACH Pending ",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                          )
                        ),
                        Text(
                           watsonData.isNotEmpty ?
                           watsonData[0]['totalnachpending']!= null ? watsonData[0]['totalnachpending'].toString() :'Feature \n Not Done'
                           :'Feature\n Note Done',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize:  watsonData.isNotEmpty ? watsonData[0]['totalnachpending']!= null ? 20:15 :15,
                            fontWeight: FontWeight.w500,
                            color:watsonData.isNotEmpty ? watsonData[0]['totalnachpending']!= null ?Colors.black:Colors.red :Colors.red
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
                  "E - NACH",
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
                          "Onboarding Completed ",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                          )
                        ),
                        Text(
                          onboardingdata.isNotEmpty ?
                            onboardingdata[0]['onboardcompleted']!=null? onboardingdata[0]['onboardcompleted'].toString() : 'Feature \n Not Done' 
                          :'Feature\n Note Done',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize:onboardingdata.isNotEmpty ? 
                              onboardingdata[0]['onboardcompleted']!=null? 20:15
                            :15,
                            fontWeight: FontWeight.w500,
                            color: onboardingdata.isNotEmpty ?
                              onboardingdata[0]['onboardcompleted']!=null?  Colors.black:Colors.red
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
                          "Onboarding in Pending ",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                          )
                        ),
                        Text(
                          onboardingdata.isNotEmpty ?
                            onboardingdata[0]['onboardpending']!=null? onboardingdata[0]['onboardpending'].toString() : 'Feature \n Not Done' 
                          :'Feature\n Note Done',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize:onboardingdata.isNotEmpty ? 
                              onboardingdata[0]['onboardpending']!=null? 20:15
                            :15,
                            fontWeight: FontWeight.w500,
                            color: onboardingdata.isNotEmpty ? 
                              onboardingdata[0]['onboardpending']!=null ?Colors.black:Colors.red
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
                child:Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30  ,vertical: 2),
                  child:Text(
                    "ONBOARDING",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700 ,
                    )
                  ),
                )
              )
            )
          ],
        ),
      ],
    );
  }
}
