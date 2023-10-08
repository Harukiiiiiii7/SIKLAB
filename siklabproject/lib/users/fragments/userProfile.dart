import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../userPreferences/current_user.dart';

class UserProfile extends StatelessWidget{

  final CurrentUser _currentUser = Get.put(CurrentUser());
  
  Widget userInfoItemProfile(IconData iconData, String userData){
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12,),
        color: Colors.grey,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: Row(
        children: [
          Icon(
            iconData,
            size: 30,
            color: Colors.black,
          ),
          const SizedBox(width:16),
          Text(
            userData,
            style: const TextStyle(
              fontSize: 15,
            ),
          ),
        ],
      )
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(32,),
      children: [
        Center(
          child: Image.network(
            "https://i.imgur.com/nTKKdMR.png",
            width: 240,
          ),
        ),

        const SizedBox(height:20,),

        userInfoItemProfile(Icons.person, _currentUser.user.username),

        const SizedBox(height:20,),

        userInfoItemProfile(Icons.home, _currentUser.user.barangay),

        const SizedBox(height:20,),

        userInfoItemProfile(Icons.numbers, _currentUser.user.contactNum),

      ],
    );

  }// Widget








}