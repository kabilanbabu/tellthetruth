import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:finite_coverflow/finite_coverflow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:lottie/lottie.dart';
import 'package:simple_animations/simple_animations/controlled_animation.dart';
import 'package:tellthetruth/common_variables/app_colors.dart';
import 'package:tellthetruth/common_variables/app_fonts.dart';
import 'package:tellthetruth/common_variables/app_functions.dart';
import 'package:tellthetruth/common_widgets/loading_page.dart';
import 'package:tellthetruth/common_widgets/offline_widgets/offline_widget.dart';
import 'package:tellthetruth/database_model/common_files_model.dart';
import 'package:tellthetruth/database_model/gang_details.dart';
import 'package:tellthetruth/firebase/database.dart';
import 'package:tellthetruth/home/home_page.dart';
import 'package:tellthetruth/landing_page.dart';

class AddGangIcon extends StatelessWidget {
  AddGangIcon({@required this.gangCode,@required this.gangName});
  String gangCode;
  String gangName;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: F_AddGangIcon(gangCode: gangCode, gangName: gangName,),
    );
  }
}

class F_AddGangIcon extends StatefulWidget {
  F_AddGangIcon({@required this.gangCode,@required this.gangName});
  String gangCode;
  String gangName;

  @override
  _F_AddGangIconState createState() => _F_AddGangIconState();
}

class _F_AddGangIconState extends State<F_AddGangIcon> {

  final GlobalKey<FabCircularMenuState> fabKey = GlobalKey();

  bool isLoading = false;
  String selectedIcon;

  Future<void> _submit() async {

    setState(() {
      isLoading = true;
    });

    if (selectedIcon != null) {

      final createGang = GangDetails(
        gangCode: widget.gangCode,
        gangIconURL: selectedIcon,
        gangName: widget.gangName,
        createdAt: Timestamp.fromDate(DateTime.now()),
        createBy: USER_ID,
        gangUserIDS: [USER_ID],
      );

      final updateInsights = CommonFiles(
        groupsCount: int.parse(widget.gangCode)
      );

      await DBreference.createGang(createGang);
      await DBreference.updateInsights(updateInsights);



      GoToPage(context, LandingPage());


      setState(() {
        isLoading = false;
      });

    }else{
      setState(() {
        isLoading = false;
      });
    }
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

  @override
  Widget _buildContent(BuildContext context) {
    return StreamBuilder<CommonFiles>(
        stream: DBreference.getAnimations(),
        builder: (context, snapshot) {
          final animationsData = snapshot.data;
          selectedIcon = animationsData != null ? animationsData.iconsURL[0] : 'https://assets7.lottiefiles.com/packages/lf20_O2YdXL.json';

          return TransparentLoading(
            loading: isLoading,
            child: ControlledAnimation(
              playback: Playback.MIRROR,
              tween: tween,
              duration: tween.duration,
              builder: (context, animation) {
                return Container(
                  child: new Scaffold(
                      body: Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [animation["color1"], animation["color2"],animation["color3"], animation["color4"]])),
                        child: Container(
                          color: Colors.transparent,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(20, 50, 20, 40),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          IconButton(
                                            icon: Icon(Icons.clear,color: Colors.white,size: 30,),
                                            color: Colors.white,
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: getDynamicHeight(20),
                                      ),
                                      TyperAnimatedTextKit(
                                        onTap: () {
                                          print("Tap Event");
                                        },
                                        text: [
                                          "${widget.gangCode} is your gang code.\nSelect a dodo for your gang ...!",
                                        ],
                                        textStyle: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Montserrat',
                                            fontWeight: FontWeight.w700,
                                            fontSize: getDynamicTextSize(26),decoration: TextDecoration.none),
                                        textAlign: TextAlign.start,
                                        alignment: AlignmentDirectional.topStart,
                                        isRepeatingAnimation: false,// or Alignment.topLeft
                                      ),
//
                                    ],
                                  ),
                                ),

                                Expanded(
                                  child:SizedBox(
                                    child: getVariableScaleCrousel(animationsData != null ? animationsData.iconsURL : []),
                                  ),
                                ),


                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    GestureDetector(
                                      child: Container(
                                        width: getDynamicWidth(200.0),
                                        padding: EdgeInsets.all(15.0),
                                        child: Center(
                                            child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                                children: <Widget>[
                                                  Container(),
                                                  GradientText(
                                                    'Create',
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
                          ),
                        ),
                      ),
                  ),
                );
              },
            ),
          );
        }
    );
  }

  Widget getVariableScaleCrousel(icons) {
    return icons != null ? FinitePager(
      scaleX: 0.8,
      scaleY: 0.7,
      scrollDirection: Axis.horizontal,
      onPageChanged: (index){
        selectedIcon = icons[index];
      },
      children: <Widget>[
        for (var iconURL in icons)
    Lottie.network(iconURL,height: getDynamicHeight(200),width: getDynamicWidth(200))
      ],
    ) : Container(child: Text('Loading'),);
  }

}