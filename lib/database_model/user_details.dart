import 'package:cloud_firestore/cloud_firestore.dart';
class UserDetails{
  UserDetails({
    this.username,
    this.gender,
    this.joinedDate,
    this.userID,
    this.emailID,
    this.password,
    this.dateOfBirth,
    this.empty,

  });

  final String username;
  final String gender;
  final Timestamp joinedDate;
  final String userID;
  final String emailID;
  final String password;
  final Timestamp dateOfBirth;
  final Null empty;



  factory UserDetails.fromMap(Map<String, dynamic> data, String documentID){
    if(data == null){
      return null;
    }
    final String userID = documentID;

    final String username = data['username'];
    final String gender = data['gender'];
    final Timestamp dateOfBirth = data['date_of_birth'];
    final Timestamp joinedDate = data['join_date'];
    final String emailID = data['email_id'];
    final String password = data['password'];
    final Null empty = data['empty'];


    return UserDetails(
      username: username,
      gender: gender,
      dateOfBirth: dateOfBirth,
      joinedDate: joinedDate,
      userID: userID,
      emailID: emailID,
      password: password,
      empty: empty,

    );
  }

  Map<String, dynamic> toMap(){
    return {
      username != null ? 'username': 'empty' : username,
      gender != null ? 'gender': 'empty' : gender,
      dateOfBirth != null ? 'date_of_birth': 'empty' : dateOfBirth,
      joinedDate != null ? 'join_date': 'empty' : joinedDate,
      emailID != null ? 'email_id':'empty' :  emailID,
      password != null ? 'password':'empty' :  password,
    };
  }

}