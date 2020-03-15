import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';
import 'package:styloderento/loginscreen.dart';

void main() => runApp(RegisterScreen());

class RegisterScreen extends StatefulWidget{
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _checked = false;
  String registrationUrl = "https://lilbearandlilpanda.com/styloderento/php/register_user.php";
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _phoneController = new TextEditingController();
  TextEditingController _passController = new TextEditingController();
  TextEditingController _passRetypeController = new TextEditingController();

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Stack(
          children: <Widget>[
            Container(decoration: BoxDecoration(image:DecorationImage
              (image:AssetImage("assets/images/register.png"),fit: BoxFit.cover)),
            ),
            Container(
              child:Column(
                children: <Widget>[
                  SizedBox(
                    height: 200,
                  ),
                  Card(
                    elevation:10,
                    child:Container(
                      padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child: Column(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Member Registration",
                              style: TextStyle(
                              color: Colors.black,
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextField(
                            controller: _nameController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              labelText: 'Name',
                              icon: Icon(Icons.person),
                            )
                          ),
                          TextField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              labelText: 'Email',
                              icon: Icon(Icons.email),
                            )
                          ),
                          TextField(
                            controller: _phoneController,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              labelText: 'Phone',
                              icon: Icon(Icons.phone),
                            )
                          ),
                          TextField(
                            controller: _passController,
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              icon: Icon(Icons.lock),
                            ),
                          ),
                          TextField(
                            controller: _passRetypeController,
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: 'Confirm Password',
                              icon: Icon(Icons.lock),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children:<Widget>[
                              Checkbox(
                                value: _checked,
                                onChanged: (bool value) {
                                 setState(() {
                                   _checked = value;
                                 });
                                },
                              ),
                              GestureDetector(
                                onTap: _showEULA,
                                child: Text('I agree to the Terms and Conditions.',
                                style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                              ),
                            ]
                          ),
                          MaterialButton(
                            shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                            minWidth: 115,
                            height: 50,
                            child: Text('Register', style: TextStyle(fontSize:16, fontWeight: FontWeight.bold),),
                            color: Colors.lightBlue,
                            textColor: Colors.black,
                            elevation: 10,
                            onPressed: _onRegister,
                          ),
                        ]
                      )
                    )
                  ),
                  SizedBox(height: 10,),
                  Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Already register? ", style: TextStyle(fontSize: 16.0)),
                      GestureDetector(
                        onTap: (){{Navigator.push(context,MaterialPageRoute(builder: (BuildContext context) => LoginScreen()));}},
                        child: Text(
                          "Login",
                          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  )
                ],
              )
            ),
          ],
        )
      )
    );
  }

    bool _validation(String phone, String password, String retypePassword, String email){// to validate if phone number is in correct format.
      List<String> alphabet = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"];
      bool wrongInput = false;
      for(int count = 0; count < 25; count++){
        if (phone.contains(alphabet[count]) || phone.contains(alphabet[count].toUpperCase()) ){
          wrongInput = true;
        }
      }
      if (password != retypePassword){
        wrongInput = true;
      }
      if ((email.contains("@") & email.contains(".com"))== false){
        wrongInput = true;
      }
      return wrongInput;
  }

  void _showEULA(){
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("End-user License Agreement"),
          content: new Container(
            height: 500,
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: new SingleChildScrollView(
                    child: RichText(
                      softWrap: true,
                      textAlign: TextAlign.justify,
                      text: TextSpan(
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12.0,
                          ),
                        text:
                        "This End-User License Agreement is a legal agreement between you and Lilbearandlilpanda. This EULA agreement governs your acquisition and use of our Stylo de Rento software (Software) directly from Lilbearandlilpanda or indirectly through a Lilbearandlilpanda authorized reseller or distributor (a Reseller).Please read this EULA agreement carefully before completing the installation process and using the Stylo de Rento software. It provides a license to use the Stylo de Rento software and contains warranty information and liability disclaimers. If you register for a free trial of the Stylo de Rento software, this EULA agreement will also govern that trial. By clicking accept or installing and/or using the Stylo de Rento software, you are confirming your acceptance of the Software and agreeing to become bound by the terms of this EULA agreement. If you are entering into this EULA agreement on behalf of a company or other legal entity, you represent that you have the authority to bind such entity and its affiliates to these terms and conditions. If you do not have such authority or if you do not agree with the terms and conditions of this EULA agreement, do not install or use the Software, and you must not accept this EULA agreement.This EULA agreement shall apply only to the Software supplied by Lilbearandlilpanda herewith regardless of whether other software is referred to or described herein. The terms also apply to any Lilbearandlilpanda updates, supplements, Internet-based services, and support services for the Software, unless other terms accompany those items on delivery. If so, those terms apply. This EULA was created by EULA Template for Stylo de Rento. Lilbearandlilpanda shall at all times retain ownership of the Software as originally downloaded by you and all subsequent downloads of the Software by you. The Software (and the copyright, and other intellectual property rights of whatever nature in the Software, including any modifications made thereto) are and shall remain the property of Lilbearandlilpanda. Lilbearandlilpanda reserves the right to grant licences to use the Software to third parties"
                      )
                    ),
                  ),
                )
              ],
            ),
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
}

  void _onRegister() {
    String name = _nameController.text;
    String email = _emailController.text;
    String phone = _phoneController.text;
    String password = _passController.text;
    String retypePwd = _passRetypeController.text;

    showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          title:new Text("Confirmation massage"),
            content:new Container(
            height: 50,
              child: Column(
                children: <Widget>[
                  Text(
                    "Are you sure you want to create account?",
                  ),
                ],
              ),
            ),
          actions: <Widget>[
            FlatButton(
              child:new Text ("Yes"),
              onPressed: () {
                Navigator.of(context).pop();
                if (!_checked) {
                  Toast.show("Please Accept Term", context,
                  duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                } else{
                  _createAcc(name, email, phone, password, retypePwd);
                } 
              }
            ),
            FlatButton(
              child:new Text("No"),
              onPressed: (){
                Navigator.of(context).pop();
              }
            )
          ]);
        }
      );
    }

  void _createAcc(String name, String email, String phone, String password, String retype){
    if((_validation(phone, password, retype, email)==false) == true){
        http.post(registrationUrl, body: {
        "name": name,
        "email": email,
        "phone": phone,
        "password": password,
        }).then((res) {
        if (res.body==( "success")) {
          Navigator.of(context).pop(
              MaterialPageRoute(
                builder: (BuildContext context) => LoginScreen()));
                Toast.show("Registration done", context,
              duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        } else {
          Toast.show("Registration failed", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        }
      }).catchError((err) {
        print(err);
      });
    }
    else{
      Toast.show("Registration failed, please check your email or phone number format.", context,
              duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
    }
      
  }
}