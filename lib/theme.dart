import 'package:ah_analytics/cancellation.dart';
import 'package:ah_analytics/enach&onboarding.dart';
import 'package:ah_analytics/pipeline.dart';
import 'package:ah_analytics/revenue.dart';
import 'package:ah_analytics/sales.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

class Apptheme{

  Widget pieline ({required context,pipelineData}){
    return Column(
      children: [
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
                    index <5 ?  Expanded(
                      child: Shimmer.fromColors(
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
                        ),
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
    );
  }

}