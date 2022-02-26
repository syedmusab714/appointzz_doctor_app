import 'package:doctor_appointzz/Services/ColorPicker.dart';
import 'package:doctor_appointzz/Views/HomeScreen/components/DoctorListCard/doctor_card.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../main.dart';

class GeneralPhysicianHome extends StatefulWidget {
  const GeneralPhysicianHome({Key? key}) : super(key: key);

  @override
  _GeneralPhysicianHomeState createState() => _GeneralPhysicianHomeState();
}

class _GeneralPhysicianHomeState extends State<GeneralPhysicianHome> {

  @override
  void initState() {
    super.initState();
    _readGPDatabase();
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: cleanDarkBlueGrey,
                    ),
                    child: GestureDetector(
                      onTap: (){
                        dbRef
                            .child('Appointzz')
                            .child('Specialty')
                            .child('004/doctor_access')
                            .set("logged_out").then((value){
                          Future.delayed(const Duration(seconds: 1), () {
                            Navigator.pushReplacement(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => const SplashScreen(),
                              ),
                            );
                          });
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text("Logout  ", style: TextStyle(color: cleanWhite),),
                            Icon(Icons.logout, color: cleanWhite,),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Text("Upcoming Appointments!",
                style: Theme
                    .of(context)
                    .textTheme
                    .headline5,
                textAlign: TextAlign.center,
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      return const DoctorCard(
                        title: "Mr. Ahmed",
                        appointmentNumber: "001",
                        description: "Headache",
                      );
                    }),
              ),
            ],
          ),
        ),

        bottomNavigationBar: Container(
          width: MediaQuery.of(context).size.width * 0.92,
          height: 75,
          decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(2.0, 2.0), //(x,y)
                blurRadius: 1.0,
              ),
            ],
            borderRadius: BorderRadius.circular(25),
          ),
          child: Card(
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            color: const Color.fromRGBO(7, 78, 99, 0.6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: _minusCount,
                  icon: Icon(
                    Icons.remove_circle_outline,
                    color: cleanWhite,
                    size: 30,
                  ),
                ),
                Text(
                  '$displayGpText',
                  style: const TextStyle(
                    fontSize: 20,
                    letterSpacing: 1,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(231, 232, 225, 1),
                  ),
                  textAlign: TextAlign.center,
                ),
                IconButton(
                  onPressed: _plusCount,
                  icon: Icon(
                    Icons.add_circle_outline_rounded,
                    color: cleanWhite,
                    size: 30,
                  ),
                ),
              ],
            ),
          ),
        ),

      ),
    );
  }


  final dbRef = FirebaseDatabase.instance.ref();

  bool loader = false;

  /// dentist
  int gpCounter = 0;

  int displayGpText = 0;

  void _plusCount() {
    setState(() {
      gpCounter = displayGpText;
    });

    setState(() {
      gpCounter++;
    });

    Future.delayed(const Duration(seconds: 1), () {
      dbRef
          .child('Appointzz')
          .child('Specialty')
          .child('004/counter')
          .set(gpCounter);
    });
  }

  void _minusCount() {
    setState(() {
      gpCounter = displayGpText;
    });

    setState(() {
      if (displayGpText != 0) {
        gpCounter--;
      } else {
        debugPrint("minus dentist");
      }
    });

    Future.delayed(const Duration(seconds: 1), () {
      dbRef
          .child('Appointzz')
          .child('Specialty')
          .child('004/counter')
          .set(gpCounter);
    });
  }

  void _readGPDatabase() async {
    dbRef
        .child('Appointzz')
        .child('Specialty')
        .child('004/counter')
        .onValue
        .listen((event) {
      final des = event.snapshot.value;
      debugPrint(des.toString());

      setState(() {
        displayGpText = des as int;
      });
    });
  }

}
