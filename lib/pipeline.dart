import 'package:ah_analytics/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
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
  List favourites = [];
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
        var fav=[];
        for (var i = 0; i < pipelineDatadocs.docs.length; i++) {
          if(pipelineDatadocs.docs[i].data()['category'] == "favourites"){
            fav.add(pipelineDatadocs.docs[i].data());
            print("fav $fav");
          }else{
           list.add(pipelineDatadocs.docs[i].data());
          }
        }
        setState(() {
          pipelineData = list;
          favourites=fav;
          isLoading = false; 
          print("pipelineData $pipelineData");
          print("favourites $favourites");
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
                  height: MediaQuery.of(context).size.height /1.6, 
                  child: DefaultTabController(
                    length: 2,
                    child: Column(
                      children: [
                        Container(
                          color: Color(0xff7ed7c1),
                          width: MediaQuery.of(context).size.width/1,
                          child:TabBar(
                            indicatorColor: Colors.black,
                            labelColor: Colors.black,
                            unselectedLabelColor: Colors.black26,
                            isScrollable: true,
                            unselectedLabelStyle: GoogleFonts.poppins(fontSize:14),
                            labelStyle: GoogleFonts.poppins(fontSize: 16),
                            tabs: [
                              Tab(text: 'HOT PIPELINES',),
                              Tab(text: 'FAVOURITE PIPELINES'),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Container(
                            color: Color(0xff7ed7c1).withOpacity(0.2),
                            child: TabBarView(
                              children: [
                                Apptheme().pieline(context: context,pipelineData:pipelineData),
                                Apptheme().pieline(context: context,pipelineData:favourites),
                              ],
                            ),
                          )
                        ),
                      ],
                    ),
                  ),
                ),
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

