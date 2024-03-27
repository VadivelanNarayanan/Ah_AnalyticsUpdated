// import 'package:ah_analytics/cancellation.dart';
// import 'package:ah_analytics/enach&onboarding.dart';
// import 'package:ah_analytics/pipeline.dart';
// import 'package:ah_analytics/revenue.dart';
// import 'package:ah_analytics/sales.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:intl/intl.dart';

// class Apptheme{
//   Widget category ({required context}){
//     return Column(
//       children: [
//         Container(
//           height: MediaQuery.of(context).size.height, 
//           child: DefaultTabController(
//             length: 5,
//             child: Column(
//               children: [
//                 Container(
//                   color: Color(0xff7ed7c1),
//                   child:TabBar(
//                     indicatorColor: Colors.black,
//                     labelColor: Colors.black,
//                     unselectedLabelColor: Colors.black26,
//                     isScrollable: true,
//                     unselectedLabelStyle: GoogleFonts.poppins(fontSize: 16),
//                     labelStyle: GoogleFonts.poppins(fontSize: 19),
//                     tabs: [
//                       Tab(text: 'ENACH'),
//                       Tab(text: 'SALES'),
//                       Tab(text: 'OPPRTUNITY'),
//                       Tab(text: 'REVENUE'),
//                       Tab(text: 'CANCELLATION'),
//                     ],
//                   ),
//                 ),
//                 Expanded(
//                   child: Container(
//                     color: Color(0xff7ed7c1).withOpacity(0.2),
//                     child: TabBarView(
//                       children: [
//                         Container(child: Enach()),
//                         Center(child: Sales()),
//                         Center(child:Pipeline(  )),
//                         Center(child: Revenue()),
//                         Center(child:cancellation()),
//                       ],
//                     ),
//                   )
//                 ),
//               ],
//             ),
//           ),
//         )
//       ],
//     );
//   }

// }