import 'package:flutter/material.dart';

class Slide {
  final String imageUrl;
  final String title;
  final String description;

  Slide({
    @required this.imageUrl,
    @required this.title,
    @required this.description,
  });
}

final slideList = [
  Slide(
    imageUrl: 'https://assets10.lottiefiles.com/packages/lf20_M9wchH.json',
    title: 'Anonymous Q&A',
    description: "- Add polls\n- Make friends\n- Reveal identity\n- Share your Q&A result",
  ),
  Slide(
    imageUrl: 'https://assets4.lottiefiles.com/packages/lf20_y1wVa2.json',
    title: 'Polling',
    description: 'Poll questions, the words will move and grow as more responses are entered, creating a lively interactive presentation. The cluster of words and colors are a fun way to illustrate your audience’s thoughts.',
  ),
  Slide(
    imageUrl: 'https://assets8.lottiefiles.com/packages/lf20_bb4Swi.json',
    title: 'Build your Gangs',
    description: 'Create your own gang with multiple friends,families and others. Shoot your questions and bring the truth by them, Share your knowledge in fun environment.',
  ),
];
