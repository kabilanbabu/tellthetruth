import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:lottie/lottie.dart';
import 'package:tellthetruth/global_file/common_variables/app_fonts.dart';
import 'package:tellthetruth/global_file/common_variables/app_functions.dart';

class EmptyQuestions extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(left:20.0,right: 20,top: 10),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Lottie.network("https://assets4.lottiefiles.com/private_files/lf30_YWyaYi.json",height: getDynamicHeight(250),width: getDynamicWidth(250)),
              GradientText(
                'You don\'t have any questions to play.',
                style: boldStyle,
                textAlign: TextAlign.center,
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
              SizedBox(height: getDynamicHeight(20.0),),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
//                  Text('How to ask question?', style: answerStyleBlur1),
//                  SizedBox(height: getDynamicHeight(10.0),),
//                  Text('     - Go to + tab below.', style: answerStyleBlur),
//                  SizedBox(height: getDynamicHeight(10.0),),
//                  Text('     - Click on Wanna ask a question.', style: answerStyleBlur),
//                  SizedBox(height: getDynamicHeight(10.0),),
//                  Text('     - Add question & options and also select in which gang you need to ask this question.', style: answerStyleBlur),
//                  SizedBox(height: getDynamicHeight(10.0),),
//                  Text('     - That\'s it..!!! Your question will be posted.', style: answerStyleBlur),
                  SizedBox(height: getDynamicHeight(20.0),),
                  Text('Rules :', style: answerStyleBlur1),
                  SizedBox(height: getDynamicHeight(10.0),),
                  Text('     - After 24hrs of add question polling will be closed. But questions can be viewed for 48hrs. After that questions will be removed.', style: answerStyleBlur,),
                  SizedBox(height: getDynamicHeight(10.0),),
                  Text('     - By default questioned & polled users identity will anonymous.', style: answerStyleBlur),
                  SizedBox(height: getDynamicHeight(10.0),),
                  Text('     - If you want you can reveal your identity any time while answering or while adding question.', style: answerStyleBlur),
                  SizedBox(height: getDynamicHeight(10.0),),
                  Text('     - You can share the question status directly to whatsapp, facebook, instagram stories from our app itself.', style: answerStyleBlur,),
                  SizedBox(height: getDynamicHeight(40.0),),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
