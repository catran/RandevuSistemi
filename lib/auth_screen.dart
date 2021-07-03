import 'package:chat_application/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  static const routeName = '/auth';

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  FirebaseAuth mAuth = FirebaseAuth.instance;
  FirebaseFirestore mFireStore = FirebaseFirestore.instance;

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _hakkimdaController = TextEditingController();
  TextEditingController _cinsiyetController = TextEditingController();
  TextEditingController _dogTarController = TextEditingController();
  TextEditingController _UzmanlikController = TextEditingController();
  final _loginForm = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _isSignUp = false;

  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _hakkimdaController.dispose();
  }

  Future<void> _saveForm() async {
    if (!_loginForm.currentState.validate()) return;
    _loginForm.currentState.save();
    setState(() {
      _isLoading = true;
    });

    UserCredential result;

    try {
      if (!_isSignUp) {
        result = await mAuth.signInWithEmailAndPassword(
            email: _emailController.text, password: _passwordController.text);
      } else {
        result = await mAuth.createUserWithEmailAndPassword(
            email: _emailController.text, password: _passwordController.text);

        await result.user.updateProfile(displayName: _nameController.text);
        await mFireStore.collection('users').doc(result.user.uid).set({
          'name': _nameController.text,
          'Cinsiyet': _cinsiyetController.text,
          'DogumTarihi': _dogTarController.text,
          'UzmanlikAlani': _UzmanlikController.text,
          "Hakkımda": _hakkimdaController.text,
        });
      }

      if (result != null && result.user != null)
        Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
    } catch (error) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Error'),
          content: Text(error.toString()),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Okay'),
            ),
          ],
        ),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(_isSignUp ? 'Sign Up' : 'Sign In'),
      ),
      body: Center(
        child: _isLoading
            ? CircularProgressIndicator()
            : SingleChildScrollView(
                child: Form(
                  key: _loginForm,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Center(
                          child: Text(
                            'Chat ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                              color: Colors.red.shade400,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          controller: _emailController,
                          maxLines: 1,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            icon: Icon(Icons.mail),
                            labelText: 'Email',
                            filled: true,
                            fillColor: Colors.white,
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.all(16),
                          ),
                          validator: (value) => value.characters.contains('@')
                              ? null
                              : 'Email is invalid',
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          controller: _passwordController,
                          maxLines: 1,
                          obscureText: true,
                          textInputAction: _isSignUp
                              ? TextInputAction.next
                              : TextInputAction.done,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                            icon: Icon(Icons.shield),
                            labelText: 'Password',
                            filled: true,
                            fillColor: Colors.white,
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.all(16),
                          ),
                          validator: (value) =>
                              value.isEmpty ? 'Password cannot be empty' : null,
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        _isSignUp
                            ? TextFormField(
                                controller: _nameController,
                                maxLines: 1,
                                textInputAction: TextInputAction.done,
                                keyboardType: TextInputType.visiblePassword,
                                decoration: InputDecoration(
                                  icon: Icon(Icons.person),
                                  labelText: 'Ad Soyad:',
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: InputBorder.none,
                                  contentPadding: const EdgeInsets.all(16),
                                ),
                                validator: (value) => value.isEmpty
                                    ? 'İsim soyisim boş olamaz.'
                                    : null,
                              )
                            : Container(),
                        SizedBox(
                          height: 16,
                        ),
                        _isSignUp
                            ? TextFormField(
                                controller: _dogTarController,
                                maxLines: 1,
                                textInputAction: TextInputAction.done,
                                keyboardType: TextInputType.visiblePassword,
                                decoration: InputDecoration(
                                  icon: Icon(Icons.person),
                                  labelText: 'Doğum Tarihiniz:',
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: InputBorder.none,
                                  contentPadding: const EdgeInsets.all(16),
                                ),
                                validator: (value) => value.isEmpty
                                    ? 'Doğum tarihiniz boş olamaz.'
                                    : null,
                              )
                            : Container(),
                        SizedBox(
                          height: 16,
                        ),
                        _isSignUp
                            ? TextFormField(
                                controller: _cinsiyetController,
                                maxLines: 1,
                                textInputAction: TextInputAction.done,
                                keyboardType: TextInputType.visiblePassword,
                                decoration: InputDecoration(
                                  icon: Icon(Icons.person),
                                  labelText: 'Cinsiyet',
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: InputBorder.none,
                                  contentPadding: const EdgeInsets.all(16),
                                ),
                                validator: (value) => value.isEmpty
                                    ? 'Cinsiyet boş olamaz.'
                                    : null,
                              )
                            : Container(),
                        SizedBox(
                          height: 16,
                        ),
                        _isSignUp
                            ? TextFormField(
                                controller: _hakkimdaController,
                                maxLines: 1,
                                textInputAction: TextInputAction.done,
                                keyboardType: TextInputType.visiblePassword,
                                decoration: InputDecoration(
                                  icon: Icon(Icons.person),
                                  labelText: 'Hakkımda',
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: InputBorder.none,
                                  contentPadding: const EdgeInsets.all(16),
                                ),
                                validator: (value) => value.isEmpty
                                    ? 'Hakkımda boş olamaz.'
                                    : null,
                              )
                            : Container(),
                        SizedBox(
                          height: 16,
                        ),
                        _isSignUp
                            ? TextFormField(
                                controller: _UzmanlikController,
                                maxLines: 1,
                                textInputAction: TextInputAction.done,
                                keyboardType: TextInputType.visiblePassword,
                                decoration: InputDecoration(
                                  icon: Icon(Icons.person),
                                  labelText:
                                      'Uzmanlik Alanı:(Danışansanız danışan yazınız.)',
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: InputBorder.none,
                                  contentPadding: const EdgeInsets.all(16),
                                ),
                                validator: (value) => value.isEmpty
                                    ? 'Uzmanlık alanı boş olamaz.'
                                    : null,
                              )
                            : Container(),
                        SizedBox(
                          height: 16,
                        ),
                        Container(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _saveForm,
                            child: Text(_isSignUp ? 'Sign Up' : 'Login'),
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        TextButton(
                          onPressed: () =>
                              setState(() => _isSignUp = !_isSignUp),
                          child: Text(_isSignUp
                              ? 'Sign in instead'
                              : 'Sign up instead'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
