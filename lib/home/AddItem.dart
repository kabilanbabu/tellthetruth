import 'dart:io';
import 'dart:typed_data';

import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_page_transition/flutter_page_transition.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:interactive_add_button_layout/interactive_add_button_layout.dart';
import 'package:screenshot/screenshot.dart';
import 'package:swipe_up_menu/swipe_up_menu.dart';
import 'package:tellthetruth/common_variables/app_colors.dart';
import 'package:tellthetruth/common_variables/app_fonts.dart';
import 'package:tellthetruth/common_variables/app_functions.dart';
import 'package:tellthetruth/common_widgets/custom_appbar_widget/custom_app_bar.dart';
import 'package:tellthetruth/common_widgets/offline_widgets/offline_widget.dart';
import 'package:tellthetruth/home/AddGroup.dart';
import 'package:tellthetruth/home/groupMembers.dart';

class AddItemPage extends StatelessWidget {
  //ProfilePage({@required this.database});
  //Database database;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: F_AddItemPage(),
    );
  }
}

class F_AddItemPage extends StatefulWidget {
  // F_ProfilePage({@required this.database});
  // Database database;

  @override
  _F_AddItemPageState createState() => _F_AddItemPageState();
}

class _F_AddItemPageState extends State<F_AddItemPage> {
  final GlobalKey<FabCircularMenuState> fabKey = GlobalKey();

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
    final primaryColor = Theme.of(context).primaryColor;
    return Container(
      decoration: new BoxDecoration(
          gradient: new LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0XffC60000),
              Color(0XffCF1129),
              Color(0XffD42863),
              Color(0XffD93D9D),
              Color(0XffDE4EC7),
            ],
          )),
      child: Column(
       // mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
           Center(
            child: SizedBox(
              width: getDynamicWidth(300),
              height: getDynamicHeight(300),
              child: Container(
                  child: FlareActor("images/welcome.flr",
                      alignment: Alignment.center,
                      fit: BoxFit.contain,
                      animation: 'Animations')),
            ),
          ),
           Text("Good evening Vasanth, ready to create something new ?",style: questionStyleThin,textAlign: TextAlign.center,),
           SizedBox(height: getDynamicHeight(100),),
           Column(
             children: [
               GestureDetector(
                 onTap: (){},
                 child: Stack(
                   alignment: Alignment.center,
                   children: [
                     Container(
                       height: getDynamicHeight(150),
                     ),
                     Positioned(
                       top: 15,
                       child:Text("Question",style: backgroundText,),
                     ),
                     Positioned(
                       child: Text("Wanna ask a question?",style: questionStyle1,),
                     )
                   ],
                 ),
               ),
               GestureDetector(
                 onTap: (){},
                 child: Stack(
                   alignment: Alignment.center,
                   children: [
                     Container(
                       height: getDynamicHeight(150),
                     ),
                     Positioned(
                       top: 15,
                       child:Text("Gang",style: backgroundText,),
                     ),
                     Positioned(
                       child: Text("Create a new gang & have fun.",style: questionStyle1,),
                     )
                   ],
                 ),
               ),
             ],
           )
        ],
      ),
    );
  }


}



//
//////////
//////////////
     //Please dont clear this
//////////////
/////////
//


//ScreenshotController screenshotController = ScreenshotController();
//File _imageFile;
//
//
//@override
//Widget build(BuildContext context) {
//  return Screenshot(child: offlineWidget(context), controller: screenshotController,);
//}

//Widget _buildContent(BuildContext context) {
//  return new MaterialApp(
//    debugShowCheckedModeBanner: false,
//    home: new Scaffold(
//        backgroundColor:Colors.white,
//        body: Row(
//          children: <Widget>[
//            Container(
//              decoration: new BoxDecoration(
//                  gradient: new LinearGradient(
//                    begin: Alignment.topCenter,
//                    end: Alignment.bottomCenter,
//                    colors: [
//                      Color(0XffFD8B1F),
//                      Color(0XffD152E0),
//                      Color(0Xff30D0DB),
//                    ],
//                  )),
//            ),
//            InkWell(onTap: (){
//              screenshotController.capture().then((File image) {
//                //Capture Done
//                setState(() {
//                  print(_imageFile);
//                  _imageFile = image;
//                  print(_imageFile);
//                  final result = ImageGallerySaver.saveImage(_imageFile.readAsBytesSync());
//                  print(result);
//                });
//              }).catchError((onError) {
//                print(onError);
//              });
//            },
//              child: Text('take screenshot'),),
//
//            _imageFile != null ? Image.file(_imageFile) : Container(height: 10,width: 10,color: Colors.red,),
//
//          ],
//        )
//    ),
//  );
//}