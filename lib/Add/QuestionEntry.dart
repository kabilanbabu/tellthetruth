import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:animations/animations.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_page_transition/flutter_page_transition.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:liquid_swipe/Helpers/Helpers.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:tellthetruth/Add/OptionEntry.dart';
import 'package:tellthetruth/common_variables/app_colors.dart';
import 'package:tellthetruth/common_variables/app_fonts.dart';
import 'package:tellthetruth/common_variables/app_functions.dart';
import 'package:tellthetruth/common_widgets/custom_appbar_widget/custom_app_bar.dart';
import 'package:tellthetruth/common_widgets/offline_widgets/offline_widget.dart';
import 'package:tellthetruth/common_widgets/platform_alert/platform_alert_dialog.dart';
import 'package:tellthetruth/firebase/auth.dart';
import '../common_widgets/ExpandPageTransition.dart';
import '../landing_page.dart';

class QuestionEntryPage extends StatelessWidget {
  //ProfilePage({@required this.database});
  //Database database;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: F_QuestionEntryPage(),
    );
  }
}

class F_QuestionEntryPage extends StatefulWidget {
  // F_ProfilePage({@required this.database});
  // Database database;

  @override
  _F_QuestionEntryPageState createState() => _F_QuestionEntryPageState();
}

class _F_QuestionEntryPageState extends State<F_QuestionEntryPage> {

  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return offlineWidget(context);
  }

  Widget offlineWidget(BuildContext context) {
    return CustomOfflineWidget(
      onlineChild: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: Scaffold(
          body: _buildContent(context),
        ),
      ),
    );
  }

  final PageController ctrl = PageController(viewportFraction: 0.2,);

  Widget _buildContent(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new Scaffold(
          backgroundColor:Colors.white,
          body: Padding(
            padding: const EdgeInsets.fromLTRB(15, 50, 15, 50),
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(),
                          IconButton(
                            icon: Icon(Icons.clear,color: Colors.black,size: 30,),
                            color: Colors.white,
                            onPressed: () {Navigator.pop(context, true);},
                          ),
                        ],
                      ),
                      Lottie.network("https://assets8.lottiefiles.com/packages/lf20_ssIwdK.json",height: getDynamicHeight(250),width: getDynamicWidth(250)),
                      SizedBox(
                        height: getDynamicHeight(20),
                      ),
                      TyperAnimatedTextKit(
                        onTap: () {
                          print("Tap Event");
                        },
                        text: [
                          "Good evening $USER_NAME, Let's create a new question.!",
                        ],
                        textStyle: TextStyle(
                            color: Colors.black.withOpacity(0.7),
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w700,
                            fontSize: getDynamicTextSize(26),decoration: TextDecoration.none),
                        textAlign: TextAlign.start,
                        alignment: AlignmentDirectional.topStart,
                        isRepeatingAnimation: false,// or Alignment.topLeft
                      ),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            height: getDynamicHeight(140),
                          ),
                          Positioned(
                            top: 18,
                            child:FadeAnimatedTextKit(
                                text: ["Question", "Frage", "Domanda","प्रश्न","Funso","Pertanyaan","Quaestio","Demando"],
                                textStyle: backgroundText,
                                textAlign: TextAlign.center,
                                alignment: AlignmentDirectional.center // or Alignment.topLeft
                            ),
                            //Text("Question",style: backgroundText,),
                          ),
                          Positioned(
                            child: GradientText(
                              'Add your Question...!',
                              style: questionStyle1,
                              gradient: LinearGradient(
                                colors: [
                                  Color(0XffFD8B1F),
                                  Color(0XffD152E0),
                                  Color(0Xff30D0DB),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                            ),
                          )
                        ],
                      ),
                      Form(
                        key: _formKey,
                        child: TextFormField(
                          //onChanged: (value) => _gangName = value,
                          textInputAction: TextInputAction.done,
                          autocorrect: true,
                          obscureText: false,
                          keyboardType: TextInputType.text,
                          keyboardAppearance: Brightness.dark,
                          autofocus: true,
                          cursorColor: Colors.black54,
                          maxLength: 100,
                          //onEditingComplete: _submit,
                          style: TextStyle(
                              color: Colors.black54,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w700,
                              fontSize: 26,decoration: TextDecoration.none),
                          decoration: const InputDecoration(
                            counterStyle: TextStyle(
                              color: Colors.black54,
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: const BorderSide(color: Colors.black54),
                            ),
                            hintText: 'Add your Question',
                            hintStyle: TextStyle(
                                color: Colors.black12,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w700,
                                fontSize: 26,decoration: TextDecoration.none),
                            enabledBorder: const OutlineInputBorder(
                              borderSide:
                              const BorderSide(color: Colors.transparent, width: 0.0),
                            ),
                          ),
                          validator: (value) {
                            print(value);
                            if (value.isEmpty) {
                              return 'Please enter Question';
                            }
                            return null;
                          },
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
//                                  Container(
//                                    child: Text(""),
//                                  ),
                          GestureDetector(
                            child: Container(
                              width: getDynamicWidth(180.0),
                              padding: EdgeInsets.all(15.0),
                              child: Center(
                                  child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(),
                                        GradientText(
                                          'Continue',
                                          style: mediumStyle,
                                          gradient: LinearGradient(
                                            colors: [
                                              Color(0XffFD8B1F),
                                              Color(0XffD152E0),
                                              Color(0Xff30D0DB),
                                            ],
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                          ),
                                        ),
                                        Icon(
                                          Icons.arrow_forward_ios,
                                          color: Colors.blue,
                                          size: getDynamicTextSize(30),
                                        ),
                                        Container(),
                                      ])),
                              decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.7),
//                            gradient: LinearGradient(
//                                colors: <Color>[
//                                Color(0XffFD8B1F),
//                            Color(0XffD152E0),
//                            Color(0Xff30D0DB),
//                            ], begin: Alignment.topLeft, end: Alignment.bottomRight),

                                  borderRadius: BorderRadius.circular(30.0),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey,
                                        offset: Offset(2, 1),
                                        blurRadius: 6.0,
                                        spreadRadius: 1.0),
                                  ]),
                            ),
                            onTap: () {
                              Navigator.push(context, PageTransition(type: PageTransitionType.rippleMiddle, duration: Duration(seconds: 2),alignment: Alignment.bottomCenter, child: OptionEntryPage()));
                            },
                          ),
                        ],
                      ),
                ],
              ),
            ),
          )
      ),
    );
  }
}