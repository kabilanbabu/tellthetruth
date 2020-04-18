import 'dart:async';
import 'package:animated_widgets/widgets/translation_animated.dart';
import 'package:animations/animations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tellthetruth/database_model/question_details.dart';
import 'package:tellthetruth/firebase/database.dart';
import 'package:tellthetruth/global_file/common_widgets/custom_alert_box.dart';
import 'package:tellthetruth/screens/home/feed/display_all_questions_page.dart';
import 'package:flutter/material.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:tellthetruth/global_file/common_variables/app_fonts.dart';
import 'package:tellthetruth/global_file/common_variables/app_functions.dart';
import 'package:tellthetruth/global_file/common_widgets/ExpandPageTransition.dart';
import 'package:tellthetruth/global_file/common_widgets/offline_widgets/offline_widget.dart';

import '../../../landing_page.dart';

class ContentPreview extends StatelessWidget {

  ContentPreview({@required this.question,
    @required this.optionOne,
    @required this.optionTwo,
    @required this.optionThree,
    @required this.optionFour,
  });

  String question;
  String optionOne;
  String optionTwo;
  String optionThree;
  String optionFour;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: F_ContentPreview(question: question,
        optionOne: optionOne,
        optionTwo: optionTwo,
        optionThree: optionThree,
        optionFour: optionFour,
      ),
    );
  }
}

class F_ContentPreview extends StatefulWidget {
  F_ContentPreview({@required this.question,
    @required this.optionOne,
    @required this.optionTwo,
    @required this.optionThree,
    @required this.optionFour,
  });

   String question;
   String optionOne;
   String optionTwo;
   String optionThree;
   String optionFour;

  @override
  _F_ContentPreviewState createState() => _F_ContentPreviewState();
}

class _F_ContentPreviewState extends State<F_ContentPreview> {

  int _currentColorIndex = 0;
  bool isLoading = false;
  bool isAnonymous = true;
  bool isGangSelected = false;

  List _colors1 = [ //Get list of colors
    '0XffFD8B1F',
    '0XffD152E0',
    '0Xff30D0DB',
  ];

  List _colors2 = [ //Get list of colors
    '0Xff30DD76',
    '0XffFF871F',
    '0XffFF3FE0',
  ];


  changeBackground() { //update with a new color when the user taps button
    int _colorCount = _colors1.length;

    setState(() {
      if (_currentColorIndex == _colorCount - 1) {
        _currentColorIndex = 0;
      } else {
        _currentColorIndex += 1;
      }
      print(_currentColorIndex);
    }
    );
  }
  

  Future<void> _submit() async {
    setState(() {
      isLoading = true;
    });


    final createQuestion = QuestionDetails(
      createdAt: Timestamp.fromDate(DateTime.now()),
      answeredCount: 0,
      createdBy: USER_ID,
      endsAt: Timestamp.fromDate(DateTime.now()),
      options: [widget.optionOne, widget.optionTwo, widget.optionThree, widget.optionFour],
      question: widget.question,
      revealIdentity: isAnonymous,
      viewCount: 0,
      color1: _colors1[_currentColorIndex].toString(),
      color2: _colors2[_currentColorIndex].toString(),
      createByGender: USER_GENDER,
    );

    await DBreference.createQuestion(createQuestion, '2020-04-17 22:17:28.884711');
    setState(() {
      isLoading = false;
    });

    CustomAlertBox(context,
        'Success',
        'Question posted !!!!!',
        true, (){
      GoToPage(context, LandingPage());
    });


  }
  
  @override
  Widget build(BuildContext context) {
    return offlineWidget( context );
  }

  Widget offlineWidget(BuildContext context) {
    return CustomOfflineWidget(
      onlineChild: Padding(
        padding: const EdgeInsets.fromLTRB( 0, 0, 0, 0 ),
        child: Scaffold(
          body: _buildContent( context ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Container(
      width: MediaQuery.of( context ).size.width,
      height: MediaQuery.of( context ).size.height,
      decoration: new BoxDecoration(
        gradient: LinearGradient(colors: <Color>[
          Color(int.parse(_colors1[_currentColorIndex])),
          Color(int.parse(_colors2[_currentColorIndex])),
        ], begin: Alignment.topLeft, end: Alignment.bottomRight),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left:15.0,right: 15,top:20 ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector( child: Icon(
                  Icons.close, color: Colors.white,size: 30, ),
                  onTap: () {
                    Navigator.pop( context, true );
                  },
                ),

                GestureDetector(
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: isAnonymous ? Text('Anonymous mode', style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w700,
                            fontSize: getDynamicTextSize(20),decoration: TextDecoration.none),)
                            :
                        Text('Reveal identity ', style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w700,
                            fontSize: getDynamicTextSize(20),decoration: TextDecoration.none),),
                      ),
                      Text('Tap here to change', style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w400,
                          fontSize: getDynamicTextSize(12),decoration: TextDecoration.none))
                    ],
                  ),
                  onTap: () {
                    setState(() {
                      isAnonymous ? isAnonymous = false : isAnonymous = true;
                    });
                  },
                ),

                GestureDetector(
                  child: Container(
                    width: getDynamicWidth(40),
                    height: getDynamicHeight(40),
                    padding: EdgeInsets.all(20.0),
                    decoration: BoxDecoration(

                      gradient: LinearGradient(colors: <Color>[
                        Color(int.parse(_colors1[_currentColorIndex])),
                        Color(int.parse(_colors2[_currentColorIndex])),
                      ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                      border: Border.all(
                        color: Colors.white, //                   <--- border color
                        width: getDynamicWidth(3),
                      ),
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  onTap: () {
                    changeBackground();
                  },
                ),

              ],
            ),
          ),
          Container(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    width: getDynamicWidth(MediaQuery.of(context).size.width),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular( 5 ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all( 10.0 ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          GradientText(
                            widget.question,
                            textAlign: TextAlign.center,
                            style: mediumStyle,
                            gradient: LinearGradient(
                              colors: [
                                Color( 0XffFD8B1F ),
                                Color( 0XffD152E0 ),
                                Color( 0Xff30D0DB ),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      TranslationAnimatedWidget(
                        enabled: true,
                        duration: Duration(seconds: 2),//// update this boolean to forward/reverse the animation
                        values: [
                          Offset(0, -250), // disabled value value
                          Offset(0, -250), //intermediate value
                          Offset(0, 0) //enabled value
                        ],
                        child: OptionCard(context ,widget.optionOne),
                      ),
                      SizedBox(height: getDynamicHeight(8),),
                      TranslationAnimatedWidget(
                        enabled: true,
                        duration: Duration(seconds: 2),//// update this boolean to forward/reverse the animation
                        values: [
                          Offset(-200, 250), // disabled value value
                          Offset(-200, 250), //intermediate value
                          Offset(0, 0) //enabled value
                        ],
                        child: OptionCard(context ,widget.optionTwo),
                      ),
                      SizedBox(height: getDynamicHeight(8),),
                      TranslationAnimatedWidget(
                        enabled: true,
                        duration: Duration(seconds: 2),//// update this boolean to forward/reverse the animation
                        values: [
                          Offset(400, -250), // disabled value value
                          Offset(400, -250),  //intermediate value
                          Offset(0, 0) //enabled value
                        ],
                        child: OptionCard(context ,widget.optionThree),/* your widget */
                      ),
                      SizedBox(height: getDynamicHeight(8),),
                      TranslationAnimatedWidget(
                        enabled: true,
                        duration: Duration(seconds: 2),//// update this boolean to forward/reverse the animation
                        values: [
                          Offset(0, 250), // disabled value value
                          Offset(0, 250), //intermediate value
                          Offset(0, 0) //enabled value
                        ],
                        child: OptionCard(context ,widget.optionFour),/* your widget */
                      ),
                    ],
                  ),
                ),

              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left:10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Select Gang",style: questionStyle1,),
                Container(
                    color: Colors.transparent,
                    height: getDynamicHeight(80.0) ,
                    width: MediaQuery.of(context).size.width ,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child:Row(
                        children: [
                          _buildImage(".Net 791"),
                          SizedBox(width: getDynamicWidth(8),),
                          _buildImage("Family",),
                          SizedBox(width: getDynamicWidth(8),),
                          _buildImage("LTI Pune",),
                          SizedBox(width: getDynamicWidth(8),),
                          _buildImage("Caseu",),
                          SizedBox(width: getDynamicWidth(8),),
                          _buildImage("rajaa",),
                          SizedBox(width: getDynamicWidth(8),),
                          _buildImage("eldooo",),
                          SizedBox(width: getDynamicWidth(8),),
                          _buildImage("sainath",),
                          SizedBox(width: getDynamicWidth(8),),
                          _buildImage("nanditha",),
                          SizedBox(width: getDynamicWidth(8),),
                        ],
                      ) ,
                    )
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
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
                              'Ask',
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
                              size: getDynamicTextSize(15),
                            ),
                            Container(),
                          ])),
                  decoration: BoxDecoration(
                      color: Colors.white,

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
                  _submit();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildImage( String description) {
    return GestureDetector(
      onTap: (){
        //GoToPage(context, QuestionsPage());
      },
      child: ExpandPageTransition(
        navigateToPage: AllQuestions(),
        transitionType: ContainerTransitionType.fade,
        closedBuilder: (BuildContext _, VoidCallback openContainer) {

          return
            Container(
              height: getDynamicHeight(50),
              child: Padding(
                padding: const EdgeInsets.only(left: 15,right: 15),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      GradientText(
                        description,
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
                    ]),
              ),
            );
        },
      ),
    );
  }


}

class LabelText extends StatelessWidget {
  LabelText({this.label, this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric( horizontal: 5 ),
      padding: EdgeInsets.all( 10 ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular( 15 ),
        color: Colors.white,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          GradientText(
            '$value',
            textAlign: TextAlign.center,
            style: boldStyle,
            gradient: LinearGradient(
              colors: [
                Color( 0XffFD8B1F ),
                Color( 0XffD152E0 ),
                Color( 0Xff30D0DB ),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          GradientText(
            '$label',
            style: answerStyle,
            gradient: LinearGradient(
              colors: [
                Color( 0XffFD8B1F ),
                Color( 0XffD152E0 ),
                Color( 0Xff30D0DB ),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ],
      ),
    );
  }
}

Widget OptionCard(BuildContext context ,String Option)
{
  return Container(
    height: getDynamicHeight(55),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular( 5 ),
    ),
    child: Padding(
      padding: const EdgeInsets.only( left: 15.0, right: 15.0 ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GradientText(
            Option,
            style: answerStyle,
            gradient: LinearGradient(
              colors: [
                Color( 0XffFD8B1F ),
                Color( 0XffD152E0 ),
                Color( 0Xff30D0DB ),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ],
      ),
    ),
  );

}