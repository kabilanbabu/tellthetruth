import 'dart:async';
import 'package:animated_widgets/widgets/translation_animated.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finite_coverflow/finite_coverflow.dart';
import 'package:tellthetruth/database_model/question_details.dart';
import 'package:tellthetruth/firebase/admobs.dart';
import 'package:tellthetruth/firebase/database.dart';
import 'package:tellthetruth/global_file/common_widgets/custom_alert_box.dart';
import 'package:flutter/material.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:tellthetruth/global_file/common_variables/app_fonts.dart';
import 'package:tellthetruth/global_file/common_variables/app_functions.dart';
import 'package:tellthetruth/global_file/common_widgets/offline_widgets/offline_widget.dart';
import '../../../landing_page.dart';

class ContentPreview extends StatelessWidget {
  ContentPreview({
    @required this.question,
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
      child: F_ContentPreview(
        question: question,
        optionOne: optionOne,
        optionTwo: optionTwo,
        optionThree: optionThree,
        optionFour: optionFour,
      ),
    );
  }
}

class F_ContentPreview extends StatefulWidget {
  F_ContentPreview({
    @required this.question,
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

  final TextEditingController _questionController = TextEditingController();

  int _questionCountIndex = 0;

  List<String> questions = [
    "",
    "who is the father of nation ?",
    "Can u touch ur feet ??",
    "Do u have corona ?",
  ];




  changeQuestion() {
    int questionCount = questions.length;

    setState(() {
      if (_questionCountIndex == questionCount - 1) {
        _questionCountIndex = 0;
      } else {
        _questionCountIndex += 1;
      }
      _questionController.text = questions[_questionCountIndex];
    });
  }
  String _optionOne;
  String _optionTwo;
  String _optionThree;
  String _optionFour;

  final FocusNode _optionOneFocusNode = FocusNode();
  final FocusNode _optionTwoFocusNode = FocusNode();
  final FocusNode _optionThreeFocusNode = FocusNode();
  final FocusNode _optionFourFocusNode = FocusNode();

  int _currentColorIndex = 0;
  bool isLoading = false;
  bool isAnonymous = true;
  bool isGangSelected = false;

  List _colors1 = [
    //Get list of colors
    '0XffFD8B1F',
    '0XffD152E0',
    '0Xff30D0DB',
  ];

  List _colors2 = [
    //Get list of colors
    '0Xff30DD76',
    '0XffFF871F',
    '0XffFF3FE0',
  ];
//
//  List gangIDs= ['2020-04-17 22:17:28.884711', '2020-04-17 22:19:09.291230','2020-04-17 22:17:28.884711', '2020-04-17 22:19:09.291230'];
//  List gangName = ['8 gang', 'Nara batch','8 gang', 'Nara batch'];

  List gangIDs = USER_GANG_ID;
  List gangName = USER_GANG_NAMES;
  String selectedGangID = '';

  Color selectGangBackgroundColor = Colors.black54;

  changeBackground() {
    //update with a new color when the user taps button
    int _colorCount = _colors1.length;

    setState(() {
      if (_currentColorIndex == _colorCount - 1) {
        _currentColorIndex = 0;
      } else {
        _currentColorIndex += 1;
      }
      print(_currentColorIndex);
    });
  }


  Future<void> _submit() async {
    setState(() {
      isLoading = true;
    });

    final createQuestion = QuestionDetails(
      createdAt: Timestamp.fromDate(DateTime.now()),
      createdBy: USER_ID,
      endsAt: Timestamp.fromDate(DateTime.now().add(Duration(days: 1))),
      options: [
        widget.optionOne,
        widget.optionTwo,
        widget.optionThree,
        widget.optionFour
      ],
      deleteAt: Timestamp.fromDate(DateTime.now().add(Duration(days: 2))),
      question: widget.question,
      isAnonymous: isAnonymous,
      viewCount: 0,
      optionTwoPolledCount: 0,
      optionThreePolledCount: 0,
      optionFourPolledCount: 0,
      optionOnePolledCount: 0,
      color1: _colors1[_currentColorIndex].toString(),
      color2: _colors2[_currentColorIndex].toString(),
      createByGender: USER_GENDER,
    );

    await DBreference.createQuestion(createQuestion, selectedGangID);
    setState(() {
      isLoading = false;
    });

    CustomAlertBox(context, 'Success', 'Question posted !!!!!', true, () {
      GoToPage(context, LandingPage());
    });
  }

  @override
  void initState() {
    setState(() {
      selectedGangID = gangIDs[0];
    });
//    Ads.hideBannerAd();
    super.initState();
  }

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

  Widget _buildContent(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: new BoxDecoration(
        gradient: LinearGradient(colors: <Color>[
          Color(int.parse(_colors1[_currentColorIndex])),
          Color(int.parse(_colors2[_currentColorIndex])),
        ], begin: Alignment.topLeft, end: Alignment.bottomRight),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            SizedBox(height: getDynamicHeight(50),),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15, top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  GestureDetector(
                    child: Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 30,
                    ),
                    onTap: () {
                      Navigator.pop(context, true);
                    },
                  ),
                  GestureDetector(
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: Text(
                            isAnonymous ? 'Anonymous mode' : 'Reveal identity',
                            style: mediumTextStyleLight,
                          )
                        ),
                        Text('Tap here to change',
                            style: verySmallTextStyleLight)
                      ],
                    ),
                    onTap: () {
                      setState(() {
                        isAnonymous = !isAnonymous;
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
                          color:
                          Colors.white, //                   <--- border color
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
            SizedBox(height: getDynamicHeight(20),),

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                height: getDynamicHeight(623),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20)
                ),
               child: Column(
                 children: [
                   Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: TextFormField(
                       controller: _questionController,
                       maxLines: 2,
                       textInputAction: TextInputAction.done,
                       autocorrect: true,
                       obscureText: false,
                       keyboardType: TextInputType.text,
                       keyboardAppearance: Brightness.light,
                       autofocus: true,
                      // focusNode: focusNode,
                      // onFieldSubmitted: onFieldSubmitted,
                       cursorColor: Colors.black54,
                       //efefrmaxLength: 64,
                      // onEditingComplete: onEditingComplete,
                       textAlign: TextAlign.center,
                       style: mediumTextStyleDark,
                       decoration:  InputDecoration(
                         counterStyle: TextStyle(
                             color: Colors.black,
                             fontFamily: mainFontFamily,
                             fontWeight: FontWeight.w600,
                             fontSize: getDynamicTextSize(20),decoration: TextDecoration.none),
                         focusedBorder: UnderlineInputBorder(
                           borderSide: const BorderSide(color: Colors.transparent),
                         ),
                         hintText: "Add your Question",
                         hintStyle: mediumTextStyleMedium,
                         enabledBorder: const OutlineInputBorder(
                           borderSide:
                           const BorderSide(color: Colors.transparent, width: 0.0),
                         ),
                       ),
                       validator: (value) {
                         print(value);
                         if (value.isEmpty) {
                           return "Please enter question";
                         }
                         return null;
                       },
                     ),
                   ),
                   Padding(
                     padding: const EdgeInsets.only(left:20.0,right: 20,),
                     child: Container(
                       height: getDynamicHeight(450),
                       width: MediaQuery.of(context).size.width,
                       decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(20)
                       ),
                       child: Column(
                         children: [
                           Container(
                             decoration: BoxDecoration(
                                 borderRadius: BorderRadius.only(topLeft: const Radius.circular(20.0),topRight: const Radius.circular(20.0)),
                               color: Colors.grey.withOpacity(0.4),
                             ),

                             child: Padding(
                               padding: const EdgeInsets.symmetric(horizontal: 20,),
                               child: TextFormField(
                                 //devgonChanged: (value) => _optionOne = value,
                                 maxLines: 1,
                                 textInputAction: TextInputAction.done,
                                 autocorrect: true,
                                 obscureText: false,
                                 keyboardType: TextInputType.text,
                                 keyboardAppearance: Brightness.light,
                                 autofocus: true,
                                 focusNode: _optionOneFocusNode,
                                 // focusNode: focusNode,
                                 // onFieldSubmitted: onFieldSubmitted,
                                 cursorColor: Colors.black54,
                                 //efefrmaxLength: 64,
                                 // onEditingComplete: onEditingComplete,
                                 //textAlign: TextAlign.center,
                                 style: mediumTextStyleMedium,
                                 decoration:  InputDecoration(
                                   counterStyle: TextStyle(
                                       color: Colors.black,
                                       fontFamily: mainFontFamily,
                                       fontWeight: FontWeight.w600,
                                       fontSize: getDynamicTextSize(20),decoration: TextDecoration.none),
                                   focusedBorder: UnderlineInputBorder(
                                     borderSide: const BorderSide(color: Colors.transparent),
                                   ),
                                   hintText: "Add your Option",
                                   hintStyle: mediumTextStyleMedium,
                                   enabledBorder: const OutlineInputBorder(
                                     borderSide:
                                     const BorderSide(color: Colors.transparent, width: 0.0),
                                   ),
                                 ),
                                 validator: (value) {
                                   print(value);
                                   if (value.isEmpty) {
                                     return "Add your Options";
                                   }
                                   return null;
                                 },
                               ),
                             ),
                           ),
                           SizedBox(height: getDynamicHeight(2),),
                           Container(

                             color: Colors.grey.withOpacity(0.4),

                             child: Padding(
                               padding: const EdgeInsets.symmetric(horizontal: 20),
                               child: TextFormField(
                                 //devgonChanged: (value) => _optionOne = value,
                                 //maxLines: 1,
                                 textInputAction: TextInputAction.done,
                                 autocorrect: true,
                                 obscureText: false,
                                 keyboardType: TextInputType.text,
                                 keyboardAppearance: Brightness.light,
                                 autofocus: true,
                                 focusNode: _optionTwoFocusNode,
                                 // focusNode: focusNode,
                                 // onFieldSubmitted: onFieldSubmitted,
                                 cursorColor: Colors.black54,
                                 //efefrmaxLength: 64,
                                 // onEditingComplete: onEditingComplete,
                                 //textAlign: TextAlign.center,
                                 style: mediumTextStyleMedium,
                                 decoration:  InputDecoration(
                                   counterStyle: TextStyle(
                                       color: Colors.black,
                                       fontFamily: mainFontFamily,
                                       fontWeight: FontWeight.w600,
                                       fontSize: getDynamicTextSize(20),decoration: TextDecoration.none),
                                   focusedBorder: UnderlineInputBorder(
                                     borderSide: const BorderSide(color: Colors.transparent),
                                   ),
                                   hintText: "Add your Option",
                                   hintStyle: mediumTextStyleMedium,
                                   enabledBorder: const OutlineInputBorder(
                                     borderSide:
                                     const BorderSide(color: Colors.transparent, width: 0.0),
                                   ),
                                 ),
                                 validator: (value) {
                                   print(value);
                                   if (value.isEmpty) {
                                     return "Add your Options";
                                   }
                                   return null;
                                 },
                               ),
                             ),
                           ),
                           SizedBox(height: getDynamicHeight(2),),
                           Container(
                             color: Colors.grey.withOpacity(0.4),
                             child: Padding(
                               padding: const EdgeInsets.symmetric(horizontal: 20),
                               child: TextFormField(
                                 //devgonChanged: (value) => _optionOne = value,
                                 maxLines: 1,
                                 textInputAction: TextInputAction.done,
                                 autocorrect: true,
                                 obscureText: false,
                                 keyboardType: TextInputType.text,
                                 keyboardAppearance: Brightness.light,
                                 autofocus: true,
                                 focusNode: _optionThreeFocusNode,
                                 // focusNode: focusNode,
                                 // onFieldSubmitted: onFieldSubmitted,
                                 cursorColor: Colors.black54,
                                 //efefrmaxLength: 64,
                                 // onEditingComplete: onEditingComplete,
                                 //textAlign: TextAlign.center,
                                 style: mediumTextStyleMedium,
                                 decoration:  InputDecoration(
                                   counterStyle: TextStyle(
                                       color: Colors.black,
                                       fontFamily: mainFontFamily,
                                       fontWeight: FontWeight.w600,
                                       fontSize: getDynamicTextSize(20),decoration: TextDecoration.none),
                                   focusedBorder: UnderlineInputBorder(
                                     borderSide: const BorderSide(color: Colors.transparent),
                                   ),
                                   hintText: "Add your Option",
                                   hintStyle: mediumTextStyleMedium,
                                   enabledBorder: const OutlineInputBorder(
                                     borderSide:
                                     const BorderSide(color: Colors.transparent, width: 0.0),
                                   ),
                                 ),
                                 validator: (value) {
                                   print(value);
                                   if (value.isEmpty) {
                                     return "Add your Options";
                                   }
                                   return null;
                                 },
                               ),
                             ),
                           ),
                           SizedBox(height: getDynamicHeight(2),),
                           Container(
                             decoration: BoxDecoration(
                               borderRadius: BorderRadius.only(bottomRight: const Radius.circular(20.0),bottomLeft: const Radius.circular(20.0)),
                               color: Colors.grey.withOpacity(0.4),
                             ),

                             child: Padding(
                               padding: const EdgeInsets.symmetric(horizontal: 20),
                               child: TextFormField(
                                 //devgonChanged: (value) => _optionOne = value,
                                 maxLines: 1,
                                 textInputAction: TextInputAction.done,
                                 autocorrect: true,
                                 obscureText: false,
                                 keyboardType: TextInputType.text,
                                 keyboardAppearance: Brightness.light,
                                 autofocus: true,
                                 focusNode: _optionFourFocusNode,
                                 // focusNode: focusNode,
                                 // onFieldSubmitted: onFieldSubmitted,
                                 cursorColor: Colors.black54,
                                 //efefrmaxLength: 64,
                                 // onEditingComplete: onEditingComplete,
                                // textAlign: TextAlign.center,
                                 style: mediumTextStyleMedium,
                                 decoration:  InputDecoration(
                                   counterStyle: TextStyle(
                                       color: Colors.black,
                                       fontFamily: mainFontFamily,
                                       fontWeight: FontWeight.w600,
                                       fontSize: getDynamicTextSize(20),decoration: TextDecoration.none),
                                   focusedBorder: UnderlineInputBorder(
                                     borderSide: const BorderSide(color: Colors.transparent),
                                   ),
                                   hintText: "Add your Option",
                                   hintStyle: mediumTextStyleMedium,
                                   enabledBorder: const OutlineInputBorder(
                                     borderSide:
                                     const BorderSide(color: Colors.transparent, width: 0.0),
                                   ),
                                 ),
                                 validator: (value) {
                                   print(value);
                                   if (value.isEmpty) {
                                     return "Add your Options";
                                   }
                                   return null;
                                 },
                               ),
                             ),
                           ),

                         ],

                       )

                     ),
                   )
                 ],
               ),

              ),
            ),

//            Container(
//              child: Column(
//                children: <Widget>[
//                  Padding(
//                    padding: const EdgeInsets.all(20.0),
//                    child: Container(
//                      width: getDynamicWidth(MediaQuery.of(context).size.width),
//                      decoration: BoxDecoration(
//                        color: Colors.white,
//                        borderRadius: BorderRadius.circular(5),
//                      ),
//                      child: Padding(
//                        padding: const EdgeInsets.all(20.0),
//                        child: Column(
//                          mainAxisAlignment: MainAxisAlignment.center,
//                          children: <Widget>[
//                            GradientText(
//                              widget.question,
//                              textAlign: TextAlign.center,
//                              style: foregroundTextStyleLight,
//                              gradient: LinearGradient(
//                                colors: [
//                                  Color(0XffFD8B1F),
//                                  Color(0XffD152E0),
//                                  Color(0Xff30D0DB),
//                                ],
//                                begin: Alignment.topLeft,
//                                end: Alignment.bottomRight,
//                              ),
//                            ),
//                          ],
//                        ),
//                      ),
//                    ),
//                  ),
//                  Padding(
//                    padding: const EdgeInsets.all(20.0),
//                    child: Column(
//                      children: <Widget>[
//                        TranslationAnimatedWidget(
//                          enabled: true,
//                          duration: Duration(
//                              seconds:
//                              2), //// update this boolean to forward/reverse the animation
//                          values: [
//                            Offset(0, -250), // disabled value value
//                            Offset(0, -250), //intermediate value
//                            Offset(0, 0) //enabled value
//                          ],
//                          child: OptionCard(context, widget.optionOne),
//                        ),
//                        SizedBox(
//                          height: getDynamicHeight(8),
//                        ),
//                        TranslationAnimatedWidget(
//                          enabled: true,
//                          duration: Duration(
//                              seconds:
//                              2), //// update this boolean to forward/reverse the animation
//                          values: [
//                            Offset(-200, 250), // disabled value value
//                            Offset(-200, 250), //intermediate value
//                            Offset(0, 0) //enabled value
//                          ],
//                          child: OptionCard(context, widget.optionTwo),
//                        ),
//                        SizedBox(
//                          height: getDynamicHeight(8),
//                        ),
//                        TranslationAnimatedWidget(
//                          enabled: true,
//                          duration: Duration(
//                              seconds:
//                              2), //// update this boolean to forward/reverse the animation
//                          values: [
//                            Offset(400, -250), // disabled value value
//                            Offset(400, -250), //intermediate value
//                            Offset(0, 0) //enabled value
//                          ],
//                          child: OptionCard(
//                              context, widget.optionThree), /* your widget */
//                        ),
//                        SizedBox(
//                          height: getDynamicHeight(8),
//                        ),
//                        TranslationAnimatedWidget(
//                          enabled: true,
//                          duration: Duration(
//                              seconds:
//                              2), //// update this boolean to forward/reverse the animation
//                          values: [
//                            Offset(0, 250), // disabled value value
//                            Offset(0, 250), //intermediate value
//                            Offset(0, 0) //enabled value
//                          ],
//                          child: OptionCard(
//                              context, widget.optionFour), /* your widget */
//                        ),
//                      ],
//                    ),
//                  ),
//                ],
//              ),
//            ),
            SizedBox(height: getDynamicHeight(20),),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Select Gang",
                    style: mediumTextStyleLight,),
                  SizedBox(height: getDynamicHeight(10),),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    height: getDynamicHeight(140),
                    width: getDynamicWidth(380),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Flex(
                        direction: Axis.horizontal,
                        children: <Widget>[
                          Expanded(
                            child: SizedBox(
                              height:100,
                              child: getVariableScaleCrousel(gangName),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: getDynamicHeight(30),),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  child: Container(
                    width: getDynamicWidth(180.0),
                    padding: EdgeInsets.only(left: 15.0, right: 15.0,top: 5, bottom: 5),
                    child: Center(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(),
                              GradientText(
                                'Ask',
                                style: foregroundTextStyleLight,
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
                        borderRadius: BorderRadius.circular(45.0),
                      ),
                  ),
                  onTap: () {
                    _submit();
                  },
                ),
              ],
            ),
            SizedBox(height: getDynamicHeight(30),),
          ],
        ),
      ),
    );
  }

  Widget getVariableScaleCrousel(gangName) {
    return FinitePager(
      scaleX: 0.8,
      scaleY: 0.7,
      rotationY: 30,
      scrollDirection: Axis.vertical,
      onPageChanged: (index){
        setState(() {
          selectedGangID = gangIDs[index];
        });
        print(selectedGangID);
      },
      children: <Widget>[
        for (var name in gangName)
          _buildImage(name),

      ],
    );
  }


  Widget _buildImage(String gangName) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.4), borderRadius: BorderRadius.circular(10)),
      height: getDynamicHeight(50),
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(gangName,style:mediumTextStyleMedium)
//              GradientText(
//                gangName,
//                style: foregroundTextStyleLight,
//                gradient: LinearGradient(
//                  colors: [
//                    Color(0XffFD8B1F),
//                    Color(0XffD152E0),
//                    Color(0Xff30D0DB),
//                  ],
//                  begin: Alignment.topLeft,
//                  end: Alignment.bottomRight,
//                ),
//              ),
            ]),
      ),
    );
  }
}

//class LabelText extends StatelessWidget {
//  LabelText({this.label, this.value});
//
//  final String label;
//  final String value;
//
//  @override
//  Widget build(BuildContext context) {
//    return Container(
//      margin: EdgeInsets.symmetric(horizontal: 5),
//      padding: EdgeInsets.all(10),
//      decoration: BoxDecoration(
//        borderRadius: BorderRadius.circular(15),
//        color: Colors.white,
//      ),
//      child: Column(
//        mainAxisSize: MainAxisSize.min,
//        children: <Widget>[
//          GradientText(
//            '$value',
//            textAlign: TextAlign.center,
//            style: boldStyle,
//            gradient: LinearGradient(
//              colors: [
//                Color(0XffFD8B1F),
//                Color(0XffD152E0),
//                Color(0Xff30D0DB),
//              ],
//              begin: Alignment.topLeft,
//              end: Alignment.bottomRight,
//            ),
//          ),
//          GradientText(
//            '$label',
//            style: answerStyle,
//            gradient: LinearGradient(
//              colors: [
//                Color(0XffFD8B1F),
//                Color(0XffD152E0),
//                Color(0Xff30D0DB),
//              ],
//              begin: Alignment.topLeft,
//              end: Alignment.bottomRight,
//            ),
//          ),
//        ],
//      ),
//    );
//  }
//}

Widget OptionCard(BuildContext context, String Option) {
  return Container(
    //height: getDynamicHeight(55),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(5),
    ),
    child: Padding(
      padding:
          const EdgeInsets.only(left: 15.0, right: 15.0, top: 20, bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            width: getDynamicWidth(MediaQuery.of(context).size.width / 1.3),
            child: GradientText(
              Option,
              style: mediumTextStyleLight,
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
          ),
        ],
      ),
    ),
  );
}
