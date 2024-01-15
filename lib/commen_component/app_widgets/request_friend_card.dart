import 'package:flutter/material.dart';

class FriendCard extends StatelessWidget {
  final String friendName;

  const FriendCard({
    Key? key,
    required this.friendName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      shape: BeveledRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              const CircleAvatar(
                backgroundColor: Colors.grey,
                radius: 30,
              ),
             const  SizedBox(width: 30),
              Text(
                friendName,
                style:const  TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
