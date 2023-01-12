import 'package:assignment2/providers/list_change_notifier.dart';
import 'package:assignment2/utils/resources.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GenreBottomSheet extends StatefulWidget {
  final List<String> prevSelections;
  const GenreBottomSheet({required this.prevSelections, super.key});

  @override
  State<GenreBottomSheet> createState() => _GenreBottomSheetState();
}

class _GenreBottomSheetState extends State<GenreBottomSheet> {
  List<String> selections = [];

  @override
  void initState() {
    selections = widget.prevSelections;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        return false;
      },
      child: Container(
        height: MediaQuery.of(context).size.height * 0.8,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Align(
                alignment: Alignment.topCenter,
                child: ChipsChoice<String>.multiple(
                  wrapped: true,
                  value: selections,
                  onChanged: (val) => setState(() {
                    ListNotifier().updateList(val);
                    selections = val;
                  }),
                  choiceItems: C2Choice.listFrom<String, String>(
                    source: kItems,
                    value: (i, v) => v,
                    label: (i, v) => v,
                  ),
                ),
              ),
            ),
            Positioned(
                bottom: 0,
                right: 0,
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(selections);
                  },
                  child: const Text('Done'),
                ))
          ],
        ),
      ),
    );
    
  }
}
