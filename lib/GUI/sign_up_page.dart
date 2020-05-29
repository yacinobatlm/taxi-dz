import 'package:flutter/material.dart';
//import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;
import 'home_page.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final FocusNode _firstNameFocus = FocusNode();
  final FocusNode _lastNameFocus = FocusNode();
  final FocusNode _numberFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  // ------------------------- Google SignIN -------------------------------------//

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<FirebaseUser> _signIn(BuildContext context) async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);

    FirebaseUser userDetails =
        (await _firebaseAuth.signInWithCredential(credential)).user;
    ProviderDetails providerInfo = ProviderDetails(userDetails.providerId);

    List<ProviderDetails> providerData = List<ProviderDetails>();
    providerData.add(providerInfo);

    UserDetails details_google = UserDetails(
        userDetails.providerId,
        userDetails.displayName,
        userDetails.photoUrl,
        userDetails.email,
        userDetails.phoneNumber,
        providerData);

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => HomePage(detailsUser: details_google)));

    return userDetails;
  }

  // ------------------------- Google SignIN -------------------------------------//

  // ------------------------- Facebook SignIN -------------------------------------//
  /*

  bool _isLoggedIn = false;
  Map userProfile;
  final facebookLogin = FacebookLogin();
  // Erreur : la fonction logInWithReadPermissions()
  _loginWithFB() async {
    final result = await facebookLogin.logInWithReadPermissions(['email']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final token = result.accessToken.token;
        final graphResponse = await http.get(
            'https://graph.facebook.com/v2.12/me?fields=name,picture,email&access_token=${token}');
        final profile = JSON.jsonDecode(graphResponse.body);
        print(profile);
        setState(() {
          userProfile = profile;
          _isLoggedIn = true;
        });

        break;

      case FacebookLoginStatus.cancelledByUser:
        setState(() => _isLoggedIn = false);
        break;
      case FacebookLoginStatus.error:
        setState(() => _isLoggedIn = false);
        break;
    }

  }

  */
  // ------------------------- Facebook SignIN -------------------------------------//

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Créer un compte",
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 7,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              // Back to last page
            },
          ),
        ),
        body: ListView(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  constraints: BoxConstraints(
                    minWidth: 120,
                    maxWidth: 140,
                  ),
                  child: SignInButtonBuilder(
                    text: 'Google',
                    icon: FontAwesomeIcons.google,
                    onPressed: () {},
                    backgroundColor: Colors.blueAccent,
                  ),
                ),
                Container(
                  constraints: BoxConstraints(
                    minWidth: 120,
                    maxWidth: 140,
                  ),
                  child: SignInButtonBuilder(
                    text: 'Facebook',
                    icon: FontAwesomeIcons.facebookF,
                    onPressed: () {},
                    backgroundColor: Colors.blue,
                  ),
                ),
              ],
            ),
            Divider(
              color: Colors.black54,
              height: 30,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: <Widget>[
                  BuildTextFormField("Prénom", (value) {
                    _fieldFocusChanged(
                        context, _firstNameFocus, _lastNameFocus);
                  }, _firstNameFocus),
                  BuildTextFormField("Nom de famille", (value) {
                    _fieldFocusChanged(context, _lastNameFocus, _numberFocus);
                  }, _lastNameFocus),
                  BuildTextFormField(
                    "N° GSM",
                    (value) {
                      _fieldFocusChanged(context, _numberFocus, _emailFocus);
                    },
                    _numberFocus,
                    keyboardType: TextInputType.numberWithOptions(signed: true),
                    textInputAction: TextInputAction.next,
                    maxLength: 10,
                  ),
                  BuildTextFormField(
                    "Adresse E-Mail",
                    (value) {
                      _fieldFocusChanged(context, _emailFocus, _passwordFocus);
                    },
                    _emailFocus,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  BuildTextFormField(
                    "Mot de passe",
                    (value) {
                      _passwordFocus.unfocus();
                    },
                    _passwordFocus,
                    obscureText: true,
                    textInputAction: TextInputAction.done,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _fieldFocusChanged(
      BuildContext context, FocusNode currentNode, FocusNode nextNode) {
    currentNode.unfocus();
    FocusScope.of(context).requestFocus(nextNode);
  }
}

class BuildTextFormField extends StatelessWidget {
  TextInputAction textInputAction;
  TextInputType keyboardType;
  bool obscureText;
  Function onFieldSubmitted;
  String labelText;
  FocusNode focusNode;
  int maxLength;

  BuildTextFormField(this.labelText, this.onFieldSubmitted, this.focusNode,
      {this.textInputAction = TextInputAction.next,
      this.keyboardType = TextInputType.text,
      this.obscureText = false,
      this.maxLength});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: labelText,
        counterText: "",
      ),
      maxLength: maxLength,
      focusNode: focusNode,
      textInputAction: textInputAction,
      onFieldSubmitted: onFieldSubmitted,
      keyboardType: keyboardType,
      obscureText: obscureText,
    );
  }
}

// UserDetails pour stock les information de la personne connecte
class UserDetails {
  final String providerDetails;
  final String userName;
  final String photoUrl;
  final String userEmail;
  final String phoneNumber;
  final List<ProviderDetails> providerData;

  UserDetails(this.providerDetails, this.userName, this.photoUrl,
      this.userEmail, this.phoneNumber, this.providerData);
}

class ProviderDetails {
  ProviderDetails(this.providerDetails);

  final String providerDetails;
}
