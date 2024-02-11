import 'package:flutter/material.dart';
import 'package:graduation_project/commen_component/app_colors/color_extension.dart';

class UserDataComponent extends StatelessWidget {
  final String labelText;
  final String userData;
  final IconData icon ;

  const UserDataComponent({
    Key? key,
    required this.labelText,
    required this.userData,
    required this.icon
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              width: 65,
              height: 55,
              decoration: BoxDecoration(
                color: TColor.primaryColor1,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
              ),
              child: Icon(
                icon  ,
                size: 35,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(width: 20,),
          Expanded(
            flex: 2,
            child: Text(
              labelText,
              style:  TextStyle(
                color: TColor.secondaryColor1,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          Expanded(
            child: Text(
              ":",
              style: TextStyle(
                color: TColor.secondaryColor1,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          Expanded(
            flex:2,
            child: Text(
              userData,
              maxLines: 1,
              style: TextStyle(

                overflow: TextOverflow.ellipsis,
                color: TColor.secondaryColor1,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
