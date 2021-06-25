// import 'package:firebase/firebase.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import '/Flutter projects/myapplication/lib/database.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _mainCollection = _firestore.collection('users');

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _uname = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _number = TextEditingController();
  TextEditingController _account = TextEditingController();
  TextEditingController _ifsc = TextEditingController();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  var _formkey = GlobalKey<FormState>();

  get future => null;

  get builder => null;

  static Future<void> addItem({
    required String name,
    required String email,
    required String account,
    required String phone,
    required String ifsc,
  }) async {
    DocumentReference documentReferencer =
        _mainCollection.doc().collection('users').doc();

    Map<String, dynamic> data = <String, dynamic>{
      "name": name,
      "email": email,
      "account": account,
      "ifsc": ifsc,
      "phone": phone,
    };

    await documentReferencer
        .set(data)
        .whenComplete(
          () => print("Notes item added to the database"),
        )
        .catchError((e) => print(e));
  }

  @override
  Widget build(BuildContext context) {
    // CollectionReference<Map<String, dynamic>> users;
    return Material(
      // body: Padding(
      //       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 100),
      color: Colors.white,
      child: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              Image.asset(
                "images/home.png",
                fit: BoxFit.cover,
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                "Welcome",
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.deepPurple,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 16.0, horizontal: 30.0),
                child: Column(
                  children: [
                    TextFormField(
                      controller: _uname,
                      decoration: InputDecoration(
                        hintText: "Enter Full Name",
                        labelText: "Full Name",
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "This field is required";
                        }

                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _number,
                      decoration: InputDecoration(
                        hintText: "Enter phone number",
                        labelText: "Phone",
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "This field is required";
                        }

                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _email,
                      decoration: InputDecoration(
                        hintText: "Enter your email",
                        labelText: "Email",
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "This field is required";
                        }

                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _account,
                      decoration: InputDecoration(
                        hintText: "Enter account number",
                        labelText: "Account Number",
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "This field is required";
                        }

                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _ifsc,
                      decoration: InputDecoration(
                        hintText: "Enter ifsc code",
                        labelText: "IFSC Code",
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "This field is required";
                        }

                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            child: Text("Submit"),
                            style: TextButton.styleFrom(
                                backgroundColor: Colors.deepPurple),
                            onPressed: () => {
                                  if (!_formkey.currentState!.validate())
                                    {}
                                  else
                                    {
                                      addItem(
                                          name: _uname.text,
                                          email: _email.text,
                                          account: _account.text,
                                          phone: _number.text,
                                          ifsc: _ifsc.text),
                                    },
                                  showAlertDialog(context)
                                }),
                        SizedBox(
                          width: 10.0,
                        ),
                        ElevatedButton(
                          child: Text("Reset"),
                          style: TextButton.styleFrom(
                              backgroundColor: Colors.lightBlue),
                          onPressed: () {
                            _uname.clear();
                            _account.clear();
                            _ifsc.clear();
                            _email.clear();
                            _number.clear();
                          },
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    // ignore: deprecated_member_use
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pushReplacementNamed(context, '/');
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Successfully Submitted"),
      content: Text("Your is stored at Google firestore"),
      actions: [
        okButton,
      ],
    );

    // To show the dialog, when data submitted.
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
