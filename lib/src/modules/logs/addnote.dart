import 'package:flutter/material.dart';
import 'package:mobile_app/src/styles/theme.dart';
import 'package:mobile_app/src/globals.dart' as globals;
import 'package:mobile_app/src/utils/utility.dart';

class AddNote extends StatefulWidget {
  @override
  _AddNoteState createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  FocusNode _descriptionFocus;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    _descriptionFocus = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textController = TextEditingController();
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
            Icons.close,
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
                        focusNode: _descriptionFocus,
                        controller: textController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.multiline,
                        validator: (val) {
                          if (val.isEmpty) {
                            return 'Please Enter Note   ';
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

                          // focusedBorder: OutlineInputBorder(
                          //   borderRadius: BorderRadius.circular(25.0),
                          //   borderSide: BorderSide(
                          //     color: Color(0xff463DC7),
                          //   ),
                          // ),
                          // enabledBorder: OutlineInputBorder(
                          //   borderRadius: BorderRadius.circular(25.0),
                          //   borderSide: BorderSide(
                          //     color: Colors.grey,
                          //     width: 2.0,
                          //   ),
                          // ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 20, right: 20, top: 100),
                      child: InkWell(
                        onTap: () {
                          final form = _formKey.currentState;

                          if (form.validate()) {
                            form.save();

                            Utility.showSnackBar(_scaffoldKey,
                                'Note Added Successfully', context);
                            Future.delayed(const Duration(seconds: 2), () {
                              Navigator.pop(context, textController.text);
                            });
                          }
                        },
                        child: new Container(
                          padding: const EdgeInsets.all(16),
                          alignment: Alignment.center,
                          color: Theme.of(context).primaryColor,
                          child: new Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                new Text(
                                  "Add Note",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "SF UI Display",
                                    color: Colors.white,
                                    fontSize:
                                        globals.deviceType == "phone" ? 17 : 25,
                                  ),
                                )
                              ]),
                        ),
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

  void _submit() {}
}
