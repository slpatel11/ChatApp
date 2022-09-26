import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
   AuthForm(this.submitFn) ;
 final void Function (String email,String pwd,String username,bool isLogin,BuildContext ctx)submitFn;
  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey=GlobalKey<FormState>();
  var _isLogin=true;
  String _userEmail='';
  String _userName='';
  String _userPassword='';
  void _trySubmit(){
    final isValid=_formKey.currentState?.validate();
    FocusScope.of(context).unfocus();
    if(isValid!=null){
      _formKey.currentState?.save();
      print(_userEmail);
      print(_userPassword);
      print(_userName);
      widget.submitFn(_userEmail,_userPassword,_userName,_isLogin,context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  key: ValueKey('email'),
                  validator: (value){
                    if(value!.isEmpty ||!value.contains('@'))
                      {
                        return 'Please enter valid email adddress';
                      }
                    return  null;
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(labelText: 'Email Address'),
                  onSaved: (value){
                    _userEmail=value!;
                  },
                ),
                if(!_isLogin)
                TextFormField(
                  key: ValueKey('username'),
                  validator: (value){
                    if(value!.isEmpty||value.length<4)
                    {
                      return 'Please enter  at least 4 characters long';
                    }
                    return null;
                  },
                  decoration: InputDecoration(labelText: 'User Name'),
                  onSaved: (value){
                    _userName=value!;
                  },
                ),
                TextFormField(
                  key: ValueKey('password'),
                  validator: (value){
                    if(value!.isEmpty||value.length<7)
                    {
                      return 'Password must be at least 7 characters long';
                    }
                    return null;
                  },
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  onSaved: (value){
                    _userPassword=value!;
                  },
                ),
                SizedBox(
                  height: 12,
                ),
                ElevatedButton(
                  child: Text(_isLogin?'Login':'SignUp'),
                  onPressed: () {
                    _trySubmit();
                  },
                ),
                TextButton(
                  child: Text(
                    _isLogin?"Create New Account":'I already have an account',
                    style: TextStyle(
                      color: Colors.purple,
                    ),
                  ),
                  onPressed: () {
                    setState((){
                      _isLogin= !_isLogin;
                    });

                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
