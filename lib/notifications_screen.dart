import 'package:flutter/material.dart';

import 'commen_component/app_widgets/request_friend_card.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {

  List friendsRequests = [
   Friend(
     friendName: "abanob"
   ),
    Friend(
      friendName: "Farah"
    ),
    Friend(
      friendName: "ahmed abokhatoa"
    ),
    Friend(
      friendName: "taha"
    ),
    Friend(
        friendName: "abanob"
    ),
    Friend(
        friendName: "Farah"
    ),
    Friend(
        friendName: "ahmed abokhatoa"
    ),
    Friend(
        friendName: "taha"
    )
  ] ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Requests",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
      ),
      body:  Padding(
        padding:const EdgeInsets.only(left: 5,right: 5,bottom: 5,top: 5),
        child: ListView.builder(
            itemCount: friendsRequests.length ,
            itemBuilder:( BuildContext context , int index ){
              return  friendCard(index);
            }
        )
      ),
    );
  }
  Widget friendCard (index){
    return FriendCard(friendName: friendsRequests[index].friendName);
  }
}


class Friend {
    String friendName ;
    Friend({ required this.friendName});

}
