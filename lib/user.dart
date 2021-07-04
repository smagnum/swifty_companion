import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


import 'package:flutter_vector_icons/flutter_vector_icons.dart';


class userPage extends StatefulWidget {
  final String Login;
  const userPage({Key? key, required this.Login}) : super(key: key);

  @override
  _userPageState createState() => _userPageState();
}

late Map MyToken = {'access_token' : '', 'expires_in' : '', 'created_time' : ''};

class _userPageState extends State<userPage> {
  late Map response = {'email' : '', 'image_url' : '', 'first_name' : '', 'cursus_users' : ''};


  Future<String> get_token() async {
    print ('test');
   // if (MyToken['access_token'] == '') { print ('khawi a khay ') ; } else { print ('haaaahuwa'); print (MyToken['access_token']);}

    final int current_time = DateTime.now().millisecondsSinceEpoch;

    //final double token_int = double.parse(MyToken['access_token']);
    /*final int token_int = MyToken['created_time'].toInt();
    print (token_int);
    print(token_int.runtimeType);*/

    print ('==============PROCCESS=============');
    //print (MyToken['created_time'].toInt());
    print (MyToken['expires_in']);
    print (DateTime.now().millisecondsSinceEpoch);
    print ('==============PROCCESS=============');
// 1625323891665 1625323941164



    if ( MyToken['created_time'] == '' || (MyToken['created_time'].toInt() + int.parse(MyToken['expires_in'])) <= DateTime.now().millisecondsSinceEpoch)
      {

        print ('new token ++++++++++++++');
        var url = Uri.parse('https://api.intra.42.fr/oauth/token');
        var response = await http.post(url, body: {'grant_type': 'client_credentials', 'client_id': '7f072254ee374c9e68d9a62c74e3acd68e61df7113233f65aa16042afd45ccec', 'client_secret' : 'd304e273384b2607ee14904c8580445b5dae413b43e9d7b507bb5e6425dc207e'});

        Map token = json.decode(response.body);

        MyToken['access_token'] = token['access_token'];
        MyToken['expires_in'] = token['expires_in'].toString() + '000';
        MyToken['created_time'] = DateTime.now().millisecondsSinceEpoch;
      }

    //print ('TOKEN FINRAK');
    //print (MyToken);
    print (MyToken['access_token']);
    return MyToken['access_token'];
  }



  Future<Map> get_user(String Login) async {

    String token = await get_token() as String;

    var url = Uri.parse('https://api.intra.42.fr/v2/users/${Login}');
    var response = await http.get(url,
    headers: {
      HttpHeaders.authorizationHeader: 'Bearer ${token}',
    }
    );


    Map info = json.decode(response.body);

    if (response.statusCode == 200) {
      Map info = json.decode(response.body);

    } else {
      //json.decode("{'test':'test'}");
       Map info = {0:0};
    }

    print ('------------------');
    print (response.statusCode);
    print ('------------------');
  print (info);
    return info;


  }


  @override
  void initState() {

    super.initState();

    get_user(widget.Login).then((value) =>
        setState(() { response = value;
        print ('this is what im looking for ');
        print (response.length);
        })
    );

  }

  @override


  /*Widget build(BuildContext context) {

    return Scaffold(
      body: response.length != 0
          ? Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,

              children: [

                  response['image_url'] == '' ? Text('Loading ...') : Image.network(response['image_url'])  ,
                Text(response['email'] + '  ' + response['first_name']),
              ],),
          )
        : Center(

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
            children: [
            Text('Data not found'),

            ],
            ),
        ),
    );

  }*/


  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromRGBO(4, 9, 35, 1),
                Color.fromRGBO(39, 105, 171, 1),
              ],
              begin: FractionalOffset.bottomCenter,
              end: FractionalOffset.topCenter,
            ),
          ),
        ),
        Builder(
          builder: (context) {
            final condition = response.length >= 10;
            return condition
              ? Scaffold(


              backgroundColor: Colors.transparent,
              body: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 73),
                  child: Column(

                    children: [



                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton.icon(
                  icon: Icon(
                  AntDesign.arrowleft,
                    color: Colors.white,
                    size: 24.0,
                  ),
                  label: Text('Back'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(20.0),
                    ),
                  ),
                )],
                          /*Icon(

                            AntDesign.arrowleft,
                            color: Colors.white,

                          ),*/


                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        response['login'],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 34,
                          fontFamily: 'Nisebuschgardens',
                        ),
                      ),
                      SizedBox(
                        height: 22,
                      ),
                      Container(
                        height: height * 0.43,
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            double innerHeight = constraints.maxHeight;
                            double innerWidth = constraints.maxWidth;
                            return Stack(
                              fit: StackFit.expand,
                              children: [
                                Positioned(
                                  bottom: 0,
                                  left: 0,
                                  right: 0,
                                  child: Container(
                                    height: innerHeight * 0.72,
                                    width: innerWidth,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: Colors.white,
                                    ),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 80,
                                        ),
                                        Text(
                                          response['displayname'],
                                          style: TextStyle(
                                            color: Color.fromRGBO(39, 105, 171, 1),
                                            fontFamily: response['last_name'],
                                            fontSize: 37,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            Column(
                                              children: [
                                                Text(
                                                  'Grade',
                                                  style: TextStyle(
                                                    color: Colors.grey[700],
                                                    fontFamily: 'Nunito',
                                                    fontSize: 25,
                                                  ),
                                                ),
                                                Container(
                                                  child: (response['cursus_users'].length >= 3)
                                                  ? Text(
                                                    response['cursus_users'][2]['grade'],
                                                    style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          39, 105, 171, 1),
                                                      fontFamily: 'Nunito',
                                                      fontSize: 25,
                                                    ),
                                                  )
                                                      : Text(
                                                    response['cursus_users'][0]['grade'] == null ? 'No grade' : response['cursus_users'][0]['grade'],
                                                    style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          39, 105, 171, 1),
                                                      fontFamily: 'Nunito',
                                                      fontSize: 25,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(
                                                horizontal: 25,
                                                vertical: 8,
                                              ),
                                              child: Container(
                                                height: 50,
                                                width: 3,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.circular(100),
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ),
                                            Column(
                                              children: [
                                                Text(
                                                  'Level',
                                                  style: TextStyle(
                                                    color: Colors.grey[700],
                                                    fontFamily: 'Nunito',
                                                    fontSize: 25,
                                                  ),
                                                ),
                                                Container(
                                                  child: (response['cursus_users'].length >= 3)
                                                    ? Text(
                                                    response['cursus_users'][2]['level'].toString(),
                                                    style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          39, 105, 171, 1),
                                                      fontFamily: 'Nunito',
                                                      fontSize: 25,
                                                    ),
                                                  )
                                                  : Text(
                                                    response['cursus_users'][0]['level'].toString(),
                                                    style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          39, 105, 171, 1),
                                                      fontFamily: 'Nunito',
                                                      fontSize: 25,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),

                                Positioned(
                                  top: 0,
                                  left: 0,
                                  right: 0,
                                  child: Center(
                                    child: Container(
                                      width: 120,
                                      margin: EdgeInsets.all(10),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(100),
                                        child: Image.network(

                                          response['image_url'],
                                          width: innerWidth * 0.45,
                                          fit: BoxFit.fitWidth,
                                        ),
                                      ),

                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Column(
                        children: [
                          Container(
                            height: 850,
                            width: width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    'Skills',
                                    style: TextStyle(
                                      color: Color.fromRGBO(39, 105, 171, 1),
                                      fontSize: 27,
                                      fontFamily: 'Nunito',
                                    ),
                                  ),
                                  Divider(
                                    thickness: 2.5,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    height: 750,
                                    width: 500,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(30),
                                    ),

                                    child: Column(
                                      children: List.generate(response['cursus_users'][0]['skills'].length, (index){

                                        return Column(
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.all(7.0),
                                              /*width: 48.0,
                                              height: 48.0,*/
                                              child: Text(
                                                  response['cursus_users'][0]['skills'][index]['name'].toString() + ': ' + response['cursus_users'][0]['skills'][index]['level'].toString()
                                              ),

                                            ),

                                            Container(
                                              margin: const EdgeInsets.all(7.0),
                                              child : LinearProgressIndicator(
                                                value: response['cursus_users'][0]['skills'][index]['level'] / 21,
                                                semanticsLabel: 'Linear progress indicator',
                                              ),
                                              /*child: DecoratedBox(
                                                    decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    border: Border.all(width: 10.0, color: Colors.green),
                                                    ),
                                              ),*/
                                            )
                                          ],
                                        );
                                      }),
                                        /*Text(
                                          'WEB EXP : ' + response['cursus_users'][0]['skills'][0]['level'].toString(),
                                        ),*/

                                    ),
                                  ),

                                ],
                              ),
                            ),
                          ),







                          Container(
                            child: new Container(
                              decoration: new BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: new BorderRadius.only(
                                    topLeft: const Radius.circular(30.0),
                                    topRight: const Radius.circular(30.0),
                                    bottomLeft: const Radius.circular(30.0),
                                    bottomRight: const Radius.circular(30.0),
                                  )
                              ),



                            child: Column(
                              children: [

                              Text(
                                'Projects',
                                style: TextStyle(

                                  //color: response['projects_users'][index]['validated?'] == true ? Color.fromRGBO(39, 105, 171, 1) : Color.fromRGBO(39, 105, 171, 1),
                                  color : Color.fromRGBO(39, 105, 171, 1),
                                  fontSize: 27,
                                  fontFamily: 'Nunito',
                                ),
                              ),

                                Divider(
                                  thickness: 2.5,
                                ),

                                Column(
                                  children : List.generate(response['projects_users'].length, (index){
                                    return Column (children: [
                                      ListTile(

                                        leading: GestureDetector(
                                          behavior: HitTestBehavior.translucent,
                                          onTap: () {},
                                          child: Container(
                                            width: 48,
                                            height: 48,
                                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                                            alignment: Alignment.center,
                                            child: Builder(
                                              builder: (context) {
                                                final condition = response['projects_users'][index]['status'] == 'finished';
                                                return condition
                                                    ? CircleAvatar(
                                                       backgroundColor : response['projects_users'][index]['validated?'] == true ? Colors.green : Colors.red,
                                                     )

                                                     : CircleAvatar(
                                                         backgroundColor : Colors.yellow,
                                                     );

                                              },
                                            ),
                                          ),
                                        ),
                                        title: Text(
                                            response['projects_users'][index]['project']['name'].toString()
                                        ),
                                        trailing: Text(
                                            response['projects_users'][index]['status'] == 'finished' ? response['projects_users'][index]['final_mark'].toString() : 'in_progress',
                                        ),
                                        dense: false,
                                      ),
                                    ]
                                    );
                                  }

                                ),

                                )
                              ],
                            ),

                          ),
                          ),







                        ],
                      )
                    ],
                  ),
                ),
              ),
            )
                : response.length == 0 ?  Scaffold(
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

                body: Center(
                    child: ElevatedButton.icon(
                      icon: Icon(
                        AntDesign.arrowleft,
                        color: Colors.white,
                        size: 24.0,
                      ),
                      label: Text('User not found'),
                      onPressed: () {
                          Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(20.0),
                        ),
                      ),
                    ))) :  Scaffold(
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

                body: Center(
                    child: ElevatedButton.icon(
                      icon: Icon(
                        AntDesign.clockcircle,
                        color: Colors.white,
                        size: 24.0,
                      ),
                      label: Text('Loading ...'),
                      onPressed: () {
                       print ('Wait');
                      },
                      style: ElevatedButton.styleFrom(
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(20.0),
                        ),
                      ),
                    )));
          }
        )
      ],
    );
  }
}




/*ElevatedButton.icon(
icon: Icon(
AntDesign.arrowleft,
color: Colors.white,
),
label: Text('Back'), onPressed: () { Navigator.pop(context); },), */


class OpenPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint1 = Paint()
      ..color = Color(0xff116530)
      ..style = PaintingStyle.fill;
    canvas.drawRect(Offset(0, 0) & const Size(10, 10), paint1);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
