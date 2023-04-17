import 'package:flutter/material.dart';
import 'package:mobile_app/src/modules/medicines/model/medicinemodel.dart';
import 'package:mobile_app/src/styles/theme.dart';
import 'package:mobile_app/src/globals.dart' as globals;
import 'package:mobile_app/src/utilities/strings.dart';
import 'package:mobile_app/src/utils/utility.dart';
import 'package:mobile_app/src/widgets/model/button_widget.dart';

import '../../db/db_services.dart';

class AddNote extends StatefulWidget {
  final String notetext;
  AddNote({Key key, @required this.notetext});
  @override
  _AddNoteState createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  FocusNode _descriptionFocus;
  TextEditingController textController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    _descriptionFocus = FocusNode();
    textController = TextEditingController(text: widget.notetext);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 5,
        backgroundColor: Color(0xff463DC7),
        centerTitle: true,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Add Note',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: AppTheme.title,
                  letterSpacing: 0,
                  fontSize: globals.deviceType == 'phone' ? 20 : 28,
                  fontFamily: 'SF UI Display Semibold',
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context, '');
          },
          child: Icon(
            Icons.arrow_back,
            size: 30.0,
            color: AppTheme.iconColor,
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          child: Stack(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(20),
                      child:
                          // TextField(
                          //   keyboardType: TextInputType.multiline,
                          //   maxLines: null,
                          //   focusNode: _descriptionFocus,
                          //   onSubmitted: (value) async {
                          //     if (value != "") {}
                          //   },
                          //   controller: textController,
                          //   decoration: InputDecoration(
                          //     hintText: "Enter Description of the Note...",
                          //     border: InputBorder.none,
                          //     contentPadding: EdgeInsets.symmetric(
                          //       horizontal: 24.0,
                          //     ),
                          //   ),
                          // ),
                          TextFormField(
                        cursorColor: AppTheme.textColor2,
                        focusNode: _descriptionFocus,
                        controller: textController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.multiline,
                        validator: (val) {
                          if (val.isEmpty) {
                            return 'Please enter note   ';
                          } else {
                            return null;
                          }
                        },
                        style: TextStyle(
                          color: AppTheme.textColor1,
                          fontFamily: 'SF UI Display Bold',
                          fontSize: globals.deviceType == "phone" ? 16.0 : 24,
                        ),
                        decoration: InputDecoration(
                          // border: OutlineInputBorder(
                          //   borderRadius: BorderRadius.circular(25.0),
                          // ),
                          labelText: 'Enter Description of the Note...',
                          labelStyle: TextStyle(
                            fontSize: globals.deviceType == "phone" ? 16.0 : 24,
                            fontFamily: 'SF UI Display Bold',
                            color: AppTheme.textColor1,
                          ),

                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: AppTheme.textColor2,
                              width: 1.5,
                            ),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: AppTheme.subHeadingTextColor,
                              width: 1.5,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 60),
                      child: InkWell(
                        onTap: () {
                          // _submit();
                          final form = _formKey.currentState;

                          if (form.validate()) {
                            form.save();

                            Utility.showSnackBar(_scaffoldKey,
                                'Note added successfully', context);
                            Future.delayed(const Duration(seconds: 0), () {
                              Navigator.pop(context, textController.text);
                            });
                          }
                        },
                        child: buttonWidget(context, "Add Note"),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submit() {
    final form = _formKey.currentState;

    if (form.validate()) {
      if ((textController != null) && (textController.text.isNotEmpty)) {
        String item = textController.text;

        final log = MedicineModel(
          '',
          '',
          '',
          '',
          item,
        );
        addLog(log);
      } else {
        Utility.showSnackBar(
            _scaffoldKey, 'Please Enter Required Value ', context);
      }

      form.save();
    }
  }

  void addLog(MedicineModel log) async {
    bool isSuccess =
        await DbServices().addData(log, Strings.createMedicineName);

    if (isSuccess != null && isSuccess) {
      Utility.showSnackBar(_scaffoldKey, 'Note added successfully', context);
      Future.delayed(const Duration(seconds: 0), () {
        Navigator.pop(context, textController.text);
        // });
        // Navigator.push(context,
        //     MaterialPageRoute(builder: (context) => SymptomsListPage()));
        //   if (widget.fromHomePage != null && widget.fromHomePage) {
        //     Navigator.of(context).pop(1);
        //   } else {
        //     Navigator.of(context).pop(true);
        //   }
      });
    }
  }
}
