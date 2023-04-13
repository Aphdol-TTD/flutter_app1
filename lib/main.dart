import 'package:flutter/material.dart';

import 'common/constants.dart';
import 'common/loading.dart';

void main() {
  runApp(const myApp_Flutter());
}

class myApp_Flutter extends StatefulWidget {
  const myApp_Flutter({super.key});
  @override
  State<myApp_Flutter> createState() => _HomeScreenState();
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class _HomeScreenState extends State<myApp_Flutter> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    LoginPag(),
    SettingsPage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        /* appBar: AppBar(
          title: const Text('HOME PAGE'),
        ),*/
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: Color.fromARGB(255, 11, 130, 228),
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.login,
                color: Color.fromARGB(255, 14, 226, 22),
              ),
              label: 'Login',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.settings,
                color: Color.fromARGB(255, 241, 28, 13),
              ),
              label: 'Paramètres',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.blue,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HOME PAGE'),
      ),
      body: Stack(
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Image.network(
                """https://media.licdn.com/dms/image/D4E03AQEU7oqrd16A2w/profile-displayphoto-shrink_200_200/0/1681385915294?e=1686787200&v=beta&t=Y_7k_EzT2prrGkMdjyBSl0cm2a12c3Q7uDn0IwkROtk""",
                fit: BoxFit.cover,
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width / 2,
              ),
              Container(
                decoration: const BoxDecoration(
                  //color: Colors.black,
                  image: DecorationImage(
                    image: AssetImage('assets/images/hacking-blog-image.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width / 2,
              ),
            ],
          ),
          const Positioned(
            bottom: 1,
            left: 1,
            right: 1,
            child: Text(
              'TETEDE Aphdol Alabi',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.amber),
            ),
          )
        ],
      ),
    );
    // const SizedBox (height: 20.0),

    //   ],
    // );
  }
}

class LoginPag extends StatefulWidget {
  const LoginPag({super.key});

  @override
  State<LoginPag> createState() => _LoginPagState();
}

class _LoginPagState extends State<LoginPag> {
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;
  bool show = false;
  String _email = '';
  String _password = '';

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool showSignIn = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void toggleView() {
    setState(() {
      emailController.text = '';
      passwordController.text = '';
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              title: const Text('LOGIN PAGE'),
            ),
            backgroundColor: Colors.white,
            body: Center(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        controller: emailController,
                        decoration:
                            textInputDecoration.copyWith(hintText: 'Email'),
                        validator: (value) =>
                            value!.isEmpty ? "Enter an email" : null,
                      ),
                      SizedBox(height: 10.0),
                      TextFormField(
                        controller: passwordController,
                        decoration: textInputDecoration.copyWith(
                            hintText: 'Password',
                            suffix: IconButton(
                                onPressed: () {
                                  setState(() {
                                    show = !show;
                                  });
                                },
                                icon: Icon(show
                                    ? Icons.visibility
                                    : Icons.visibility_off))),
                        obscureText: show,
                        validator: (value) =>
                            value!.length < 4 ? "Enter an password" : null,
                      ),
                      SizedBox(height: 10.0),
                      ElevatedButton(
                        child: Text(
                          showSignIn ? "S'authentifier" : "Register",
                          //style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          setState(() {
                            _password = passwordController.text;
                            _email = emailController.text;
                          });

                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('INFORMATION !'),
                                backgroundColor: Colors.amberAccent,
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Email : $_email'),
                                    SizedBox(height: 8.0),
                                    Text('Password : $_password'),
                                  ],
                                ),
                                actions: [
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    style: ElevatedButton.styleFrom(
                                        primary: Color.fromRGBO(255, 17, 0, 1)),
                                    child: Text('Fermer'),
                                  ),
                                ],
                              );
                            },
                          );
                        },

                        style: ElevatedButton.styleFrom(
                          primary: const Color(0xFF007C91),
                        ),
                        //child: Text('S\'authentifier'),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}

class SettingsPage extends StatefulWidget {
  SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  Color _selectedColor = Colors.blue;

  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      backgroundColor: _selectedColor,
      title: Text('SETTINGS PAGE'),
    ),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Choisissez une couleur pour votre appBar',
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(height: 20),
          DropdownButton<Color>(
            value: _selectedColor,
            onChanged: (color) {
              setState(() {
                _selectedColor = color!;
              });
            },
            items: <Color>[
              Colors.green,
              Colors.yellow,
              Colors.red,
              Colors.blue,
              Colors.black,
            ].map<DropdownMenuItem<Color>>((Color value) {
              return DropdownMenuItem<Color>(
                value: value,
                child: Container(
                  width: 50,
                  height: 50,
                  color: value,
                ),
              );
            }).toList(),
          ),
        ],
      ),
    ),
  );
}

}
