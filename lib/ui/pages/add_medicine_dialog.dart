import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:training_and_diet_app/global/myColors.dart';
import 'package:training_and_diet_app/global/myDimens.dart';
import 'package:training_and_diet_app/global/mySpaces.dart';
import 'package:training_and_diet_app/global/myStrings.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddMedicineDialog extends StatefulWidget {
  @override
  _AddMedicineDialogState createState() => _AddMedicineDialogState();
}

class _AddMedicineDialogState extends State<AddMedicineDialog> {
  TextEditingController medicineNameController = new TextEditingController();
  TextEditingController timeController = new TextEditingController();
  String time;
  String medicineName;
  List medicineList = [];

  FToast fToast;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  _showToast() {
    print("Test");
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.greenAccent,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check),
          SizedBox(
            width: 12.0,
          ),
          Text("Medicine Recorder"),
        ],
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 2),
    );

    // Custom Toast Position
    fToast.showToast(
        child: toast,
        toastDuration: Duration(seconds: 2),
        positionedToastBuilder: (context, child) {
          return Positioned(
            child: child,
            top: 30.0,
            left: 16.0,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(MyDimens.double_10),
        ),
        elevation: 0.0,
        backgroundColor: Colors.lightBlue,
        child: Container(
            margin: EdgeInsets.all(20),
            color: Colors.lightBlue,
            child: Wrap(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      MyStrings.addAMedicineLabel,
                      style: Theme.of(context).textTheme.headline5.copyWith(
                          color: MyColors.white, fontFamily: 'lexenddeca'),
                    ),
                    MySpaces.vSmallGapInBetween,
                    _CupertinoTextFieldPres(
                      placeholderTextIndex: 0,
                      textInputType: TextInputType.text,
                      controller: medicineNameController,
                    ),
                    MySpaces.vGapInBetween,
                    _CupertinoTextFieldPres(
                      placeholderTextIndex: 1,
                      textInputType: TextInputType.text,
                      controller: timeController,
                    ),
                    MySpaces.vGapInBetween,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            print("Cancel");
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            MyStrings.cancelLabel,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                .copyWith(
                                    color: MyColors.lightPink,
                                    fontSize: MyDimens.double_15,
                                    fontFamily: 'lexenddeca'),
                          ),
                        ),
                        MySpaces.hSmallGapInBetween,
                        FlatButton(
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(MyDimens.double_4),
                          ),
                          onPressed: () {
                            _showToast();
                            // _showToast2;

                            print("confirm");
                            // adds the medicine in database.
                            //_onPressedAddMedicineDetails();
                            Navigator.of(context).pop();
                          },
                          color: MyColors.white,
                          child: Text(
                            MyStrings.confirmLabel,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                .copyWith(
                                    color: MyColors.primaryColor,
                                    fontSize: MyDimens.double_15,
                                    fontFamily: 'lexendeca'),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ],
            )));
    //void _showToast() => Fluttertoast.showToast();
  }
}

class _CupertinoTextFieldPres extends StatelessWidget {
  int placeholderTextIndex;
  TextInputType textInputType;
  TextEditingController controller;

  _CupertinoTextFieldPres(
      {@required this.placeholderTextIndex,
      @required this.textInputType,
      this.controller});
  List<String> placeholderTextList = [
    MyStrings.medicineNameLabel,
    MyStrings.timingsLabel,
  ];

  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
      controller: controller,
      keyboardType: textInputType,
      padding: EdgeInsets.symmetric(
          horizontal: MyDimens.double_20, vertical: MyDimens.double_15),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(MyDimens.double_4))),
      style: Theme.of(context)
          .textTheme
          .subtitle1
          .copyWith(color: Colors.pink, fontFamily: 'lexenddeca'),
      maxLines: 1,
      cursorColor: MyColors.lightPink,
      cursorWidth: 3,
      cursorRadius: Radius.circular(50),
      placeholder: placeholderTextList[placeholderTextIndex],
      placeholderStyle: Theme.of(context).textTheme.headline6.copyWith(
          fontSize: 18,
          color: MyColors.inputFieldTextPink,
          fontFamily: 'lexenddeca'),
    );
  }
}
