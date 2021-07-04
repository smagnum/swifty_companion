import 'package:flutter/material.dart';
import 'package:test00/user.dart';
import 'package:test00/profile.dart';


import 'soon.dart';

/*print ('test');
  var url = Uri.parse('https://api.intra.42.fr/oauth/token');
  var response = await http.post(url, body: {'grant_type': 'client_credentials', 'client_id': '7f072254ee374c9e68d9a62c74e3acd68e61df7113233f65aa16042afd45ccec', 'client_secret' : 'd304e273384b2607ee14904c8580445b5dae413b43e9d7b507bb5e6425dc207e'});
  print('Response status: ${response.statusCode}');
  print('Response body: ${response.body}');*/

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}



class _HomeState extends State<Home> {


  /*return Scaffold(
  appBar: AppBar(
  title: Image.asset(
  "assets/images/logo_light.png",
  fit: BoxFit.contain,
  height: 72,
  ),
  toolbarHeight: 88,
  actions: [
  IconButton(onPressed: () => {}, icon: Icon(Icons.search)),
  ],
  ),
  );*/


  @override
  Widget build(BuildContext context) {
    Image appLogo = new Image(
        image: new ExactAssetImage("assets/img/header.png"),
        height: 1000.0,
        width: 1000.0,

       // alignment: FractionalOffset.center
        );

    TextEditingController nameController = TextEditingController();
    String Login = '';
    final ButtonStyle style =
    ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));
    return  Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(300.0),
            child: AppBar(
              //title: appLogo,
              flexibleSpace: Container(
                decoration:
                BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/img/header2.jpeg'
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              backgroundColor: Colors.transparent,
              title: Text("Intra in your hand"),
            ),
          ),
          body: Center(child: Column(children: <Widget>[
            Container(
           //   padding: EdgeInsets.symmetric(vertical: 200.0, horizontal: 8.0),
              margin: EdgeInsets.all(20),
              child: Column(
                children: [
                  TextField(
                    controller: nameController,

                    decoration: InputDecoration(

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(90.0)),
                        borderSide: BorderSide(
                          color: Colors.transparent
                        ),
                      ),
                      labelText: 'Enter Login',
                    ),
                    onChanged: (text) {
                      Login = text;
                    },
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                   //style: style,

                    style: ElevatedButton.styleFrom(
                      shape: StadiumBorder(),
                      primary: Colors.blue,
                    ),

                    onPressed: () {
                      print ('Search button pressed');
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => userPage(Login:Login)),
                      );
                    },
                    child: const Text('Search'),
                  ),
                ],

              ),

            ),
            Container(
              margin: EdgeInsets.all(20),
              child: Text(Login),
            )
          ])),
    );
  }
}
