import 'package:app/models/User.dart';
import 'package:app/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthPage extends StatefulWidget {
  AuthPage({Key key}) : super(key: key);

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  String _email;
  String _password;
  bool showLogin = true;

  AuthService _authService = AuthService();

  void _loginUser() async {
    _email = _emailController.text;
    _password = _passwordController.text;

    if (_email.isEmpty || _password.isEmpty) {
      return;
    }

    User user = await _authService.signInWithEmapAndPassword(
        _email.trim(), _password.trim());
    if (user == null) {
      Fluttertoast.showToast(
          msg: "Please check your email and password :)",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      _emailController.clear();
      _passwordController.clear();
    }
  }

  void _registerUser() async {
    _email = _emailController.text;
    _password = _passwordController.text;

    if (_email.isEmpty || _password.isEmpty) {
      return;
    }
    User user = await _authService.registerWithEmapAndPassword(
        _email.trim(), _password.trim());
    if (user == null) {
      Fluttertoast.showToast(
          msg: "Can't register you. Check inputs.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      _emailController.clear();
      _passwordController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(
        children: <Widget>[
          _buildLogo(),
          Center(
              child: Container(
            margin: EdgeInsets.only(top: 25.0),
            child: Text('Messenger',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 28.0,
                    fontWeight: FontWeight.normal)),
          )),
          (showLogin
              ? Column(
                  children: <Widget>[
                    _buildForm('LOGIN', _loginUser),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: GestureDetector(
                        child: Text(
                          'Not registered yet? Register.',
                          style: TextStyle(fontSize: 16.0, color: Colors.white),
                        ),
                        onTap: () {
                          setState(() {
                            showLogin = false;
                          });
                        },
                      ),
                    )
                  ],
                )
              : Column(
                  children: <Widget>[
                    _buildForm('REGISTER', _registerUser),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: GestureDetector(
                        child: Text(
                          'Already registered? Log in.',
                          style: TextStyle(fontSize: 16.0, color: Colors.white),
                        ),
                        onTap: () {
                          setState(() {
                            showLogin = true;
                          });
                        },
                      ),
                    )
                  ],
                )),
          _buildBottomWave()
        ],
      ),
    );
  }

  Widget _buildLogo() {
    return Padding(
      padding: EdgeInsets.only(top: 100.0),
      child: Align(
        child: Container(
          width: 100.0,
          height: 100.0,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image:
                      new ExactAssetImage('assets/images/messenger-logo.png'),
                  fit: BoxFit.cover)),
        ),
      ),
    );
  }

  Widget _buildForm(String label, void func()) {
    return Center(
      child: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 20.0, top: 10.0),
              child: _buildInput(
                  Icon(Icons.email), "E-mail", _emailController, false),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 20.0),
              child: _buildInput(
                  Icon(Icons.lock), "Password", _passwordController, true),
            ),
            SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 50.0),
              child: Container(
                height: 50.0,
                width: MediaQuery.of(context).size.width,
                child: _buildButton(label, func),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildInput(
      Icon icon, String hint, TextEditingController controller, bool obsecure) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30.0),
      child: TextField(
        controller: controller,
        obscureText: obsecure,
        style: TextStyle(fontSize: 16.0, color: Colors.white),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.all(5.0),
            hintStyle: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 16.0,
                color: Colors.white30),
            hintText: hint,
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 3.0)),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white54, width: 1.0)),
            prefixIcon: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: IconTheme(
                data: IconThemeData(color: Colors.white, size: 20.0),
                child: icon,
              ),
            )),
      ),
    );
  }

  Widget _buildButton(String label, void func()) {
    return RaisedButton(
      onPressed: () {
        func();
      },
      splashColor: Theme.of(context).primaryColor,
      highlightColor: Theme.of(context).primaryColor,
      color: Colors.white,
      child: Text(label,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
              fontSize: 20.0)),
    );
  }

  Widget _buildBottomWave() {
    return Expanded(
        child: Align(
      child: ClipPath(
        child: Container(
          color: Colors.white,
          height: 200,
        ),
        clipper: BottomWaveClipper(),
      ),
      alignment: Alignment.bottomCenter,
    ));
  }
}

class BottomWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(size.width, 0.0);
    path.lineTo(size.width, size.height);
    path.lineTo(0.0, size.height);
    path.lineTo(0.0, size.height + 5.0);
    var secondControlPoint = Offset(size.width - (size.width / 6), size.height);
    var secondEndPoint = Offset(size.width, 0.0);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
