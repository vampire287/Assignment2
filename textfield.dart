import 'package:flutter/material.dart';
class Field extends StatelessWidget {
  final String text1;
  const Field(this.text1, {super.key});
  
  get myFocusNode => null;
  @override
  Widget build(BuildContext context) {
    return Container(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                 Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    text1,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  focusNode: myFocusNode,
                  style:const TextStyle(color:Colors.white),
                  decoration: InputDecoration(
                    fillColor: Colors.grey.shade100,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(width:2,color: Colors.white),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}