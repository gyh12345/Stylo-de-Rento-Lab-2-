import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:styloderento/registerscreen.dart';
import 'package:styloderento/mainscreen.dart';

void main() => runApp(LoginScreen());
bool rememberMe = false;

class LoginScreen extends StatefulWidget{
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _pwdController = new TextEditingController();
  String loginUrl = "https://lilbearandlilpanda.com/styloderento/php/login_user.php";

  void initState() {
      super.initState();
      loadPreference();
  }

  Widget build(BuildContext context) {
    return WillPopScope(onWillPop: _exitApp,
        child: Scaffold(resizeToAvoidBottomPadding: false,
          body: Stack(children: <Widget>[
            Container(decoration: BoxDecoration(image:DecorationImage
              (image:AssetImage("assets/images/login.png"),fit: BoxFit.cover)),
            ),
              Container(
                child: Column(children: <Widget>[
                  SizedBox(height: 320,),
                  Card( elevation: 10,        
                    child: Container(padding: EdgeInsets.all(20),
                      child: Column(children: <Widget>[
                        Align(alignment: Alignment.center,
                          child:Text("Member Login",
                          style: TextStyle(fontSize:20, fontWeight:FontWeight.w700,)),
                        ),
                        SizedBox(height: 10),
                        TextField(
                          controller:_emailController, keyboardType:TextInputType.emailAddress,
                          decoration: InputDecoration(
                            hintText:"Email", icon:Icon(Icons.email),
                          ),
                        ),
                        TextField(
                          controller: _pwdController, 
                          decoration: InputDecoration(
                            labelText:"Password", icon:Icon(Icons.lock)),
                            obscureText: true,
                        ),
                        SizedBox(height: 20,),
                        Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,
                          children:<Widget>[
                            Checkbox(value: rememberMe, onChanged: (bool value){
                              _rememberMeChged(value);
                            }),
                            Text("Remember Me",style: TextStyle(fontSize:17, fontWeight:FontWeight.bold)),
                            SizedBox(width: 72,),
                            MaterialButton(
                                onPressed: _loginUser,
                                shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(5.0)),
                                minWidth: 100, height: 50,
                                child: Text("Login", style: TextStyle(fontSize:17, fontWeight:FontWeight.bold),),
                                color: Colors.lightBlue, 
                                elevation: 10,
                            ),
                      ],),
                  ],)
                ),
              ),
              Container(
                child: Column(
                  children:<Widget>[
                    SizedBox(height: 20),
                    Row(mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Don't have an account ?  ", style: TextStyle(fontSize: 16.0)),
                        GestureDetector(
                          onTap:() { Navigator.push(context, 
                            MaterialPageRoute(builder: (BuildContext context) => RegisterScreen()));},
                          child: Text("Create an account", style:TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        ),
                      ],),
                    SizedBox(height:5),
                    Row(mainAxisAlignment: MainAxisAlignment.center,
                      children:<Widget>[
                        Text("Forgot your password ?  ", style:TextStyle(fontSize: 16.0,)),
                        GestureDetector(
                          onTap: _forgotPwd,
                          child: Text("Reset password",
                            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold))
                      )
                    ])
                  ]
                )
              )
            ],),
         ),
        ],)
      )
    );
  }

  void _loginUser() {
      String email = _emailController.text;
      String password = _pwdController.text;

      http.post(loginUrl, body: {
        "email": email,
        "password": password,
      }).then((res) {
        if (res.body == "success") {
          Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) => MainScreen()));
          Toast.show("Login success", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      } else {
          Toast.show("Login failed", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      }
      }).catchError((err) {
      print(err);
      });
  }

  void _forgotPwd() {
    TextEditingController phoneController = TextEditingController();
    showDialog(context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Reset Password"),
          content: Container(
            height: 100,
            child:Column(children:<Widget>[
              Text("Please enter your recovery email:",
              ),
              SizedBox(height: 20,),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  icon: Icon(Icons.email),
                )
              ),
            ]
            )
          ),
          actions: <Widget>[
            new FlatButton(
              child: Text("Enter"),
              onPressed: () {
                Navigator.of(context).pop();
                print(
                  phoneController.text,);
              },
            ),
            new FlatButton(
              child: Text("Cancel"),
              onPressed: (){
                Navigator.of(context).pop();
              },
            )
          ]
        );  
      }
    );
  }

  void _rememberMeChged(bool value) => setState((){
      rememberMe = value;
      print(rememberMe);
      if (rememberMe){
        savePreference(true);
      }
      else{
        savePreference(false);
      }
  });

  void savePreference(bool save) async {
      String email = _emailController.text;
      String pwd = _pwdController.text;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if(save == true){//save preference
          await prefs.setString('email', email);
          await prefs.setString('pass', pwd);
          Toast.show("REMEMBERING YOU...", context,
            duration: Toast.LENGTH_SHORT, gravity:Toast.BOTTOM);
      } else {//delete preference
          await prefs.setString("email", "");
          await prefs.setString("pass", "");
          setState(() {
            _emailController.text = '';
            _pwdController.text = '';
            rememberMe = false;
          });
          Toast.show("FORGETTING YOU...", context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
      }
  }

  void loadPreference() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String email = (prefs.getString("email"))??"";
      String pwd = (prefs.getString("pass"))??"";
      if(email.length > 1) {
        setState((){
          _emailController.text = email;
          _pwdController.text = pwd;
          rememberMe = true;
        });
      }
  }

  Future<bool> _exitApp() {
    return showDialog(context: context, builder: (context) => new AlertDialog(
        title: Text("Are you sure?"),content: Text("Do you want to exit this app?"),
        actions: <Widget>[
            MaterialButton(onPressed:() {SystemChannels.platform.invokeMethod('SystemNavigator.pop');},
              child: Text("Exit"),),
            MaterialButton(onPressed:() {Navigator.of(context).pop(false);},
              child: Text("Cancel")),
        ],
      ),
    ) ?? false;
  }
}