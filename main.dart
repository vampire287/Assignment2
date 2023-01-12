import 'package:assignment2/bottomsheet.dart';
import 'package:assignment2/providers/list_change_notifier.dart';
import 'package:assignment2/textfield.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final listVa = ListNotifier()..name = 'newly-created-instance';
  
    return ChangeNotifierProvider<ListNotifier>(
      create: (context) => listVa,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.orange,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  get myFocusNode => null;
  bool valuefirst = false;
  bool valuesecond = false;
  List<String> selectedString = [];
  List<String> deletionString = [];
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      body: SingleChildScrollView(
        child: Consumer<ListNotifier>(builder: (context, selectionList, child) {
          return Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(8.0),
                child: const Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    'Sign Up',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: RichText(
                    text: const TextSpan(
                      text: 'Let\'s create your ',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                      children: [
                        TextSpan(
                          text: 'Account',
                          style: TextStyle(
                            color: Colors.orange,
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const Field('First Name*'),
              const SizedBox(
                height: 10,
              ),
              const Field('Last Name*'),
              const SizedBox(
                height: 20,
              ),
              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Mobile No*',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              IntlPhoneField(
                style: const TextStyle(
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      width: 2,
                      color: Colors.white,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                initialCountryCode: 'IN',
              ),
              const SizedBox(height: 10),
              const Field('Email*'),
              const SizedBox(height: 10),
              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Genres',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              selectedString.isNotEmpty
                  ? Align(
                      alignment: Alignment.topCenter,
                      child: ChipsChoice<String>.multiple(
                        choiceStyle: const C2ChipStyle(
                            backgroundColor: Colors.orange,
                            foregroundColor: Colors.orange),
                        wrapped: true,
                        value: [],
                        onChanged: (val) => setState(() {
                          deletionString = val;
                          for (var i in val) {
                            selectedString.remove(i);
                          }
                        }),
                        choiceItems: C2Choice.listFrom<String, String>(
                          source: selectedString,
                          value: (i, v) => v,
                          label: (i, v) => v,
                        ),
                        trailing: GestureDetector(
                          onTap: () async {
                            showModalBottomSheet(
                                    isDismissible: false,
                                    context: context,
                                    builder: (context) => GenreBottomSheet(
                                        prevSelections: selectedString))
                                .then((value) {
                              selectedString = value;
                              setState(() {});
                            });
                          },
                          child: const SizedBox(
                            height: 50,
                            width: 50,
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    )
                  : Builder(
                      builder: (context) {
                        return Column(
                          children: [
                            GestureDetector(
                              onTap: () async {
                                setState(() {
                                  isLoading = true;
                                });
                                Future.delayed(Duration(seconds:2),(){
                                  setState((){
                                    isLoading=false;
                                  });
                                  showModalBottomSheet(
                                        isDismissible: false,
                                        context: context,
                                        builder: (context) => GenreBottomSheet(
                                            prevSelections: selectedString))
                                    .then((value) {
                                  selectedString = value;
                                  setState(() {});
                                    });
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                  border: Border.all(width: 1, color: Colors.white),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                  color: Colors.grey[850],
                                ),
                                height: 45,
                                width: MediaQuery.of(context).size.width * 0.95,
                                child: const Align(
                                  alignment: Alignment.centerRight,
                                  child: Icon(Icons.arrow_downward_outlined,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                            isLoading?const CircularProgressIndicator():Container(),
                          ],
                        );
                      },
                    ),
              const SizedBox(height: 20),
              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Performance Type*',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: <Widget>[
                  const SizedBox(width: 5),
                  Checkbox(
                    checkColor: Colors.grey[850],
                    activeColor: Colors.orange,
                    value: valuefirst,
                    onChanged: (value) {
                      setState(() {
                        valuefirst = value!;
                      });
                    },
                  ),
                  const SizedBox(width: 30),
                  const Text(
                    'In Person',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 40),
                  Checkbox(
                      checkColor: Colors.grey[850],
                      activeColor: Colors.orange,
                      value: valuesecond,
                      onChanged: (value) {
                        setState(() {
                          valuesecond = value!;
                        });
                      }),
                  const SizedBox(width: 30),
                  const Text(
                    'Virtual',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              
                 ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    primary:Colors.orange,
                    elevation:3,
                    shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(10.0),),
                    minimumSize: Size(MediaQuery.of(context).size.width*0.95,40),
                  ),
                  child: const Text(
                    'Submit',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              
              const SizedBox(height: 10),
            ],
          );
        }),
      ),

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}


