import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

class Sales extends StatefulWidget {
  Sales({
  required  this.selectedDate
  });
  DateTime selectedDate;
  @override
  State<Sales> createState() => _SalesState();
}

class _SalesState extends State<Sales> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Map<String,dynamic> journeysalesdata={};
  bool isLoading = true;
  DateTime? selecteddate;

  @override
  void initState() {
    super.initState();
    fetchDataForSelectedMonth();
  }

  @override
  void didUpdateWidget(covariant Sales oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedDate != oldWidget.selectedDate) {
      fetchDataForSelectedMonth();
    }
  }

  Future<void> fetchDataForSelectedMonth() async {
    journeysalesdata.clear();
    selecteddate=widget.selectedDate;
    firestore.collection("journeysalesdata").where("month", isEqualTo: selecteddate!.month -1 ).where('year',isEqualTo: selecteddate!.year).snapshots().listen((journeysalesdatadocs) {
      print("journeysalesdatadocs${journeysalesdatadocs.docs.length}");
      if (journeysalesdatadocs.docs.isNotEmpty) {
        setState(() {
          journeysalesdata.addAll(journeysalesdatadocs.docs[0].data());
          isLoading=false;
          print("journeysalesdata ${journeysalesdata}");
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading ? CircularProgressIndicator() : Container(
      child: journeysalesdata.isNotEmpty ?  Column(
        children: [
        SizedBox(height: 10,),
          Padding(
            padding: EdgeInsets.all(15),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color(0x72f6f6f6)
              ),
              child: Column(
                children: [ 
                  Padding(
                    padding: EdgeInsets.all(10),
                    child:Row(
                      children: [
                        Expanded(
                          child:Column(
                            children: [
                              Text(
                                "DFU",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                )
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 5,bottom: 10),
                                width: MediaQuery.of(context).size.width/3 ,
                                height: 0.2,
                                color: Colors.black,
                              ),
                              //  Container(
                              //   height: 400,
                              //   child:ListView.builder(
                              //     itemCount: journeysalesdata.length,
                              //     shrinkWrap: true,
                              //     scrollDirection: Axis.vertical,
                              //     itemBuilder: (BuildContext context, int index) { 
                              //       var key = journeysalesdata['DFU'].keys.elementAt(index);
                              //       var value = journeysalesdata['DFU'][key];
                              //       return  Padding(
                              //         padding: EdgeInsets.all(5),
                              //         child: Container(
                              //           decoration:BoxDecoration(
                              //             borderRadius: BorderRadius.circular(5), 
                              //             color: Colors.white
                              //           ),
                              //           padding: EdgeInsets.all(10),
                              //           child:Row(
                              //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //             children: [
                              //               Expanded(
                              //                 child:  Text(
                              //                   "$key",
                              //                   style: TextStyle(
                              //                     fontSize: 18,
                              //                     fontWeight: FontWeight.bold,
                              //                   )
                              //                 ),
                              //                ),
                              //               Text(
                              //                 '$value',
                              //                 style: TextStyle(
                              //                   fontSize: 18,
                              //                   fontWeight: FontWeight.w500,
                              //                 )
                              //               )
                              //             ],
                              //           ),
                              //         ),
                              //       );
                              //       // ):Text(
                              //       //   'Feature\n Not Done',
                              //       //   textAlign: TextAlign.center,
                              //       //   style: TextStyle(
                              //       //     fontSize:20,
                              //       //     fontWeight: FontWeight.w500,
                              //       //     color:Colors.red
                              //       //   )
                              //       // );
                              //     },
                              //   )
                              // )
                             Container(
                                height: 400,
                                child: Scrollbar(
                                  thickness: 6.0,
                                  child: ListView.builder(
                                    itemCount: journeysalesdata['DFU']?.length ?? 0,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    itemBuilder: (BuildContext context, int journeysalesdataindex) { 
                                      if (journeysalesdata['DFU'] == null) {
                                        return Container();
                                      }
                                      var key = journeysalesdata['DFU'].keys.elementAt(journeysalesdataindex);
                                      var value = journeysalesdata['DFU'][key];
                                      return key !=null && value!=null ? Padding(
                                        padding: EdgeInsets.all(5),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(5), 
                                            color: Colors.white,
                                          ),
                                          padding: EdgeInsets.all(10),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child:  Text(
                                                  "$key",
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                '$value',
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ):  Text(
                                        'Feature\n Not Done',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize:20,
                                          fontWeight: FontWeight.w500,
                                          color:Colors.red
                                        )
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 1,),
                        Expanded(
                          child:Column(
                            children: [
                              Text(
                                "Eco system",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                )
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 5,bottom: 10),
                                width: MediaQuery.of(context).size.width/3 ,
                                height: 0.2,
                                color: Colors.black,
                              ),
                              Container(
                                height: 400,
                                child: Scrollbar(
                                  thickness: 6.0,
                                  child: ListView.builder(
                                    itemCount: journeysalesdata['Ecosystem']?.length ?? 0,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    itemBuilder: (BuildContext context, int journeysalesdataindex) { 
                                      if (journeysalesdata['Ecosystem'] == null) {
                                        return Container();
                                      }
                                      var key = journeysalesdata['Ecosystem'].keys.elementAt(journeysalesdataindex);
                                      var value = journeysalesdata['Ecosystem'][key];
                                      return key !=null && value!=null ? Padding(
                                        padding: EdgeInsets.all(5),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(5), 
                                            color: Colors.white,
                                          ),
                                          padding: EdgeInsets.all(10),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child:  Text(
                                                  "$key",
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                '$value',
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ):  Text(
                                        'Feature\n Not Done',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize:20,
                                          fontWeight: FontWeight.w500,
                                          color:Colors.red
                                        )
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          )
                        ),
                      ],
                    )
                  ),
                  Container(
                    decoration:BoxDecoration(
                      borderRadius: BorderRadius.circular(15), 
                      color: Colors.white
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "TOTAL :",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    )
                                  ),
                                  Text(
                                   journeysalesdata['DFUtotal']!=null ?  "${journeysalesdata['DFUtotal']}":'Feature\n Note Done',
                                   textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize:journeysalesdata['DFUtotal']!=null ? 20 :15,
                                      fontWeight: FontWeight.bold,
                                      color: journeysalesdata['DFUtotal']!=null ? Colors.black:Colors.red
                                    )
                                  )
                                ],
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "TOTAL :",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    )
                                  ),
                                  Text(
                                    journeysalesdata['ecosystemtotal']!=null? "${journeysalesdata['ecosystemtotal']}":'Feature\n Note Done',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize:  journeysalesdata['ecosystemtotal']!=null? 20 :15,
                                      color:   journeysalesdata['ecosystemtotal']!=null? Colors.black:Colors.red,
                                      fontWeight: FontWeight.bold,
                                    )
                                  )
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),  
                  )
                ],
              ),
            ),
          )
        ],
      ): Center(
        child:  Shimmer.fromColors(
          baseColor: Colors.yellow[900]!,
          highlightColor: Colors.yellow,
          child: Container(
            child: Text(
              'There is no data on this month and Feature Not Done',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.red,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            )
          )
        )
      ),
    );
  }
}