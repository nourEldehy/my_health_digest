import 'package:flutter/material.dart';
import 'package:training_and_diet_app/ui/pages/add_medicine_dialog.dart';
import 'package:training_and_diet_app/global/myColors.dart';
import 'package:training_and_diet_app/global/myDimens.dart';
// import 'package:soochit/pages/authentication/signout-function.dart';
// import 'package:soochit/pages/authentication/splashScreen.dart';
// import 'package:soochit/pages/patient-specific/medicineDeadlines.dart';
// import 'package:soochit/pages/patient-specific/prescriptionHistory.dart';
// import 'package:soochit/widgets/addMedicineDialog.dart';

class MedicineReminder extends StatefulWidget {
  static String id = "homePatient";
  @override
  _MedicineReminderState createState() => _MedicineReminderState();
}

class _MedicineReminderState extends State<MedicineReminder> {
  int pageIndex = 0;
  int firstIconColorInt = 0;
  int secondIconColorInt = 1;
  // List _currentPage = [
  //   MedicineDeadlines(), PrescriptionHistory()
  // ];
  List _iconColors = [MyColors.white, MyColors.lightPink];

  @override
  Widget build(BuildContext context) {
    // void handleClick(String value) {
    //   switch (value) {
    //     case 'Logout':
    //       Auth.logout();
    //       Navigator.pushNamed(context, SplashScreen.id);
    //   }
    // }
    return Scaffold(
      body: Container(
          child: Image(
        image: AssetImage('assets/Med.png'),
        fit: BoxFit.cover,
      )),
      appBar: AppBar(
        title: Text('Medicine Reminder'),
        backgroundColor: Colors.lightBlue,
        foregroundColor: Colors.black,
        // backgroundColor: MyColors.primaryColor,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10),
          )
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: CircularNotchedRectangle(),
        child: Container(
          height: 60,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 60),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.event_note,
                    //color: _iconColors[firstIconColorInt],
                  ),
                  onPressed: () {
                    setState(() {
                      pageIndex = 0;
                      firstIconColorInt = 0;
                      secondIconColorInt = 1;
                    });
                  },
                ),
                IconButton(
                  icon: Icon(Icons.folder_open,
                      color: _iconColors[secondIconColorInt]),
                  onPressed: () {
                    setState(() {
                      pageIndex = 1;
                      firstIconColorInt = 1;
                      secondIconColorInt = 0;
                    });
                  },
                ),
              ],
            ),
          ),
          //color: MyColors.primaryColor,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddManualMedicineReminderDialog();
        },
        //backgroundColor: MyColors.primaryColor,
        child: Icon(Icons.add, size: 40),
      ),
    );
  }

  Future<Dialog> showAddManualMedicineReminderDialog() {
    return showDialog(
        context: context,
        builder: (BuildContext context) => AddMedicineDialog());
  }
}
