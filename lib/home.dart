import 'package:ah_analytics/cancellation.dart';
import 'package:ah_analytics/enach&onboarding.dart';
import 'package:ah_analytics/login.dart';
import 'package:ah_analytics/pipeline.dart';
import 'package:ah_analytics/revenue.dart';
import 'package:ah_analytics/sales.dart';
import 'package:ah_analytics/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DateTime _selectedDate = DateTime.now();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
  }
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2012),
      lastDate:DateTime.now(),
      initialDatePickerMode: DatePickerMode.year,
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });

    } else {
      setState(() {
        _selectedDate = DateTime.now();
      });

    }
  }

  @override
  Widget build(BuildContext context) {
    String formattedMonth =DateFormat('MMMM yyyy').format(_selectedDate); 
    return Scaffold(
      key: scaffoldKey, 
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            toolbarHeight: kToolbarHeight + 20,
            pinned: false,
            floating: false,
            leading: GestureDetector(
              onTap: (){
                scaffoldKey.currentState?.openDrawer();
              },
              child: Container(
                height:10,width: 10,
                padding: EdgeInsets.fromLTRB(20,10,8,10 ),
                child: Image.asset("assets/logo/logo.jpg",),
              ),
            ),
            leadingWidth: 84,
            titleSpacing: 0,
            title:Text(
              "ANALYTICS",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black
              ),
            ),
            backgroundColor: Colors.white,
            elevation: 5,
            actions: [
              // IconButton(onPressed: (){}, icon: Icon(Icons.notifications_none_outlined,color: Colors.black,))
              ElevatedButton(
                onPressed: () { _selectDate(context); print("object"); },
                style: ElevatedButton.styleFrom(
                  primary:  Color(0xfff0dbaf), 
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 3,vertical: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('$formattedMonth'),
                      Icon(Icons.arrow_drop_down_rounded)
                    ],
                  ),
                ),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child:Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                category(context: context, selectedDate:_selectedDate)
              ],
            ),   
          ),
        ],
      ),
      drawer:Drawer(
        child: Column(
          children: [
            Container(
              height:100,
              width: 100,
              padding: EdgeInsets.fromLTRB(20,10,8,10 ),
              child: Image.asset("assets/logo/logo.jpg",),
            ),
            Text("data"),
            Expanded(
              child: SizedBox(),
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text("Logout"),
              onTap: () async {
                try {
                  await FirebaseAuth.instance.signOut();
                  // Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => Login()));
                } catch (e) {
                  print("Error signing out: $e");
                }
              },
            ),
          ],
        ),
      ),
    );
  }
  Widget category ({required context,required DateTime selectedDate}){
    print('${selectedDate},Date');
    print("object");
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height, 
          child: DefaultTabController(
            length: 5,
            child: Column(
              children: [
                Container(
                  color: Color(0xff7ed7c1),
                  child:TabBar(
                    indicatorColor: Colors.black,
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.black26,
                    isScrollable: true,
                    unselectedLabelStyle: GoogleFonts.poppins(fontSize: 16),
                    labelStyle: GoogleFonts.poppins(fontSize: 19),
                    tabs: [
                      Tab(text: 'ENACH'),
                      Tab(text: 'SALES'),
                      Tab(text: 'OPPORTUNITY'),
                      Tab(text: 'REVENUE'),
                      Tab(text: 'CANCELLATION'),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Color(0xff7ed7c1).withOpacity(0.2),
                    child: TabBarView(
                      children: [
                        
                        Container(child: Enach(selectedDate: selectedDate)),
                        Center(child: Sales(selectedDate: selectedDate)),
                        Center(child:Pipeline(selectedDate: selectedDate  )),
                        Center(child: Revenue(selectedDate: selectedDate)),
                        Center(child:cancellation(selectedDate: selectedDate)),
                      ],
                    ),
                  )
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}