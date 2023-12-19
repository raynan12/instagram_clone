// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, unused_field, use_build_context_synchronously

import 'package:blog/layout/responsive_layout.dart';
import 'package:blog/mobile/mobile_screen.dart';
// import 'package:blog/res/auth_method.dart';
import 'package:blog/screen/login_screen.dart';
import 'package:blog/theme/colors.dart';
import 'package:blog/utils/utils.dart';
import 'package:blog/web/web_screen.dart';
import 'package:blog/widgets/text_field.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

import '../resources/auth_methods.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  Uint8List? _image;
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _usernameController.dispose();
  }

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });
      String res = await AuthMethods().signUpUser(
        email: _emailController.text, 
        password: _passwordController.text, 
        username: _usernameController.text, 
        bio: _bioController.text,
        file: _image!,
    );      
    setState(() {
      _isLoading = false;
    });
    if(res != 'success') {
      // showsnackBar(res, context);
    } else {
       
    }
  }

  void navigateToLogin() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => LoginScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(child: Container(), flex: 2),
              SvgPicture.asset(
                'assets/ic_instagram.svg',
                color: primaryColor,
                height: 64,
              ),
              SizedBox(
                height: 64,
              ),
              Stack(
                children: [ 
                  _image != null
                  ? CircleAvatar(
                    radius: 64,
                    backgroundImage: MemoryImage(_image!),
                  ) 
                  : CircleAvatar(
                    radius: 64,
                    backgroundImage: NetworkImage(
                      'data:image/jpeg;base64,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',),
                ),
                Positioned(
                  bottom: -10,
                  left: 80,
                  child: IconButton(
                    onPressed: selectImage, 
                    icon: Icon(
                      Icons.add_a_photo,
                    ),
                  ),
                ),
              ],), 
              SizedBox(
                height: 64,
              ), 
              TextFieldInput(
                hintText: 'Enter your username',
                textInputType: TextInputType.text, 
                textEditingController: _usernameController, 
              ),
              SizedBox(height: 24),
              TextFieldInput(
                hintText: 'Enter your email',
                textInputType: TextInputType.emailAddress, 
                textEditingController: _emailController, 
              ),
              SizedBox(height: 24),
              TextFieldInput(
                hintText: 'Enter your password',
                textInputType: TextInputType.text, 
                textEditingController: _passwordController,
                isPass: true, 
              ),
              SizedBox(
                height: 24,
              ),
              TextFieldInput(
                hintText: 'Enter your bio',
                textInputType: TextInputType.text, 
                textEditingController: _bioController, 
              ),
              SizedBox(
                height: 24,
              ),
              InkWell(
                onTap: signUpUser,
                child: Container(
                  child: _isLoading ? Center(child: CircularProgressIndicator(color: primaryColor,),) : Text('Sign up'),
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(vertical: 12),
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(4),
                      ),
                    ),
                    color: blueColor,
                  ),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Flexible(child: Container(), flex: 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Text("Don't have an account?"),
                    padding: EdgeInsets.symmetric(
                      vertical: 8,
                    ),
                  ),
                  GestureDetector(
                    onTap: navigateToLogin,
                    child: Container(
                      child: Text(
                        'Login Screen',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: 8,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}