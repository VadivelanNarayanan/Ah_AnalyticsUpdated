import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

class Pipeline extends StatefulWidget {
  DateTime selectedDate;
  Pipeline({
    required  this.selectedDate
  });
  
  @override
  State<Pipeline> createState() => _PipelineState();
}

class _PipelineState extends State<Pipeline> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  List pipelineData = [];
  List leads = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    firestore.collection("pipelinedata").orderBy("convertedcount",descending: true).snapshots().listen((pipelineDatadocs) {
      if (pipelineDatadocs.docs.isNotEmpty) {
        var list = [];
        for (var i = 0; i < pipelineDatadocs.docs.length; i++) {
          list.add(pipelineDatadocs.docs[i].data());
        }
        setState(() {
          pipelineData = list;
          isLoading = false; 
          print("pipelineData $pipelineData");
        });
      }
    });

    firestore.collection("leads").snapshots().listen((leadsdocs) {
      if(leadsdocs.docs.isNotEmpty){
        var list = [];
        for (var i = 0; i < leadsdocs.docs.length; i++) {
          list.add(leadsdocs.docs[i].data());
        }
        setState(() {
          leads = list;
          isLoading = false; 
        });
      } 
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 10,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "Total Uncontacted Leads",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
              )
            ),
            Text(
              leads.isNotEmpty ?
               leads[0]['uncontactedleads'] !=null ?formatCurrency(leads[0]['uncontactedleads']).toString() :'Feature\nNot Done'
              :"0",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize:leads.isNotEmpty ?
                  leads[0]['uncontactedleads'] !=null ?20:15
                :20,
                fontWeight: FontWeight.bold,
                color: leads.isNotEmpty ?
                  leads[0]['uncontactedleads'] !=null ?Colors.black:Colors.red
                :Colors.black,
              )
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.all(15),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color(0x72f6f6f6),
            ),
            child:isLoading? CircularProgressIndicator() : Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                    color: Color(0xffdc8686),
                  ),
                  child: Padding(
                    padding:EdgeInsets.symmetric(horizontal: 20, vertical: 3),
                    child: Text(
                      " HOT PIPELINES",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 20,right: 20,top: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(0),
                    color: Colors.white,
                  ),
                  padding: EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Pipeline Name",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "Number Of Leads",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  height:MediaQuery.of(context).size.height / 2.2,
                  child:Scrollbar(
                    thickness: 6.0,
                    child:ListView.builder(
                      itemCount: pipelineData.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          margin: EdgeInsets.only(left: 20, right: 20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(0),
                            color: Colors.white,
                          ),
                          padding: EdgeInsets.all(15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                             index <5 ?  Shimmer.fromColors(
                                baseColor: Colors.yellow[900]!,
                                highlightColor: Colors.yellow,
                                child: Container(
                                  child: Text(
                                   '${pipelineData[index]['pipelinename']}',
                                    style: TextStyle(
                                      color: Colors.yellow[900]!,
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                )
                              ): Expanded(
                                child: Text(
                                  '${pipelineData[index]['pipelinename']}',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              index <5 ?  Shimmer.fromColors(
                                baseColor: Colors.yellow[900]!,
                                highlightColor: Colors.yellow,
                                child: Container(
                                  child: Text(
                                   '${pipelineData[index]['leadscount']}',
                                    style: TextStyle(
                                      color: Colors.yellow[900]!,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                )
                              ):  Text(
                                '${pipelineData[index]['leadscount']}',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        );                       
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left:30,right:30),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(0),
            color: Colors.white,
          ),
          padding: EdgeInsets.all(15),
          child: Row(
            mainAxisAlignment:MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Referrals",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                )
              ),
              Text(
                leads.isNotEmpty ?
                 leads[0]['referrals']!=null ?formatCurrency(leads[0]['referrals']).toString() : 'Feature\n Note Done'
                :"0",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize:  leads.isNotEmpty ?
                    leads[0]['referrals']!=null ?15:10
                  :15,
                  fontWeight: FontWeight.bold,
                  color:   leads.isNotEmpty ?
                 leads[0]['referrals']!=null ?Colors.black:Colors.red : Colors.black,
                )
              ),
            ],
          ),
        )       
      ],
    );
  }

  String formatCurrency(dynamic amount) {
    final formatCurrency = NumberFormat.decimalPattern( );
    return formatCurrency.format(amount);
  }
}

