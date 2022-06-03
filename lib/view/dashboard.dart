import 'package:flutter/material.dart';
import 'package:prak_b_123190086_123190093/helper/shared_preference.dart';
import 'package:prak_b_123190086_123190093/view/homepage.dart';
import 'package:prak_b_123190086_123190093/view/homepage_makeup.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        backgroundColor: Color(0xff885566),
        elevation: 1,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => HomePageMakeup()));
            },
            icon: Icon(Icons.arrow_back)),
        actions: [
          IconButton(
            onPressed: () {
              SharedPreference().setLogout();
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                      (route) => false);
            },
            padding: EdgeInsets.only(right: 50),
            icon: Icon(
              Icons.logout,
              size: 30,
            ),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Center(
            child: Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 30),
                  width: 130,
                  height: 130,
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: 4,
                          color: Theme.of(context).scaffoldBackgroundColor),
                      boxShadow: [
                        BoxShadow(
                            spreadRadius: 2,
                            blurRadius: 10,
                            color: Colors.black.withOpacity(0.1),
                            offset: Offset(0, 10))
                      ],
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            "https://images.unsplash.com/photo-1618641986557-1ecd230959aa?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80"),
                      )),
                ),
              ],
            ),
          ),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              width: 500,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Username"),
                  FutureBuilder(

                    future: SharedPreference().getUsername(),
                    builder:
                        (BuildContext context, AsyncSnapshot<String> snapshot) {
                      return TextField(
                        decoration: InputDecoration(
                          labelText: "${snapshot.data}",
                          labelStyle:
                          TextStyle(fontSize: 20, color: Colors.black),
                          enabled: false,
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Text(
                            "Review",
                            style: TextStyle(
                              fontFamily: 'Nunito',
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            "13",
                            style: TextStyle(
                              fontFamily: 'Nunito',
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 20,),
                      Icon(Icons.comment),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          height: 40,
                          width: 5,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Colors.grey),
                        ),
                      ),
                      Column(
                        children: [
                          Text(
                            "Love",
                            style: TextStyle(
                              fontFamily: 'Nunito',
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            "45",
                            style: TextStyle(
                              fontFamily: 'Nunito',
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 20,),
                      Icon(Icons.favorite, color: Colors.pinkAccent,),
                    ],
                  ),
                  SizedBox(height: 30),
                  Text("About", style: TextStyle(
                    fontSize: 16,
                  ),),
                  Divider(),
                  SizedBox(height: 20,),
                  Text(
                      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                      textAlign: TextAlign.justify,
                      textWidthBasis: TextWidthBasis.longestLine,
                      style: TextStyle(fontFamily: 'Raleway', fontSize: 16)),
                  SizedBox(height: 20,),
                  Divider(),
                ],
              )),
        ],
      ),
    );
  }
}
