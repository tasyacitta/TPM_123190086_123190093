import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prak_b_123190086_123190093/api/source/data_source.dart';
import 'package:prak_b_123190086_123190093/api/model/products_model.dart';
import 'package:prak_b_123190086_123190093/helper/shared_preference.dart';

import 'homepage.dart';

class HomePageMakeup extends StatefulWidget {
  const HomePageMakeup({Key? key}) : super(key: key);

  @override
  _HomePageMakeupState createState() => _HomePageMakeupState();
}

class _HomePageMakeupState extends State<HomePageMakeup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Makeup List"),
        backgroundColor: Color(0xff885566),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 50),
            child: IconButton(
              onPressed: () {
                SharedPreference().setLogout();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                        (route) => false);
              },
              // padding: EdgeInsets.only(right: 50),
              icon: Icon(Icons.logout, size: 30,),
            ),
          ),
        ],
      ),
      body: _buildDetailMakeupBody()
      // Column(
      //   children: [
      //     // _buildPref(),
      //     _buildDetailCountriesBody()
      //   ],
      // )
    );
  }

  Widget _buildPref(){
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(12),
      child: Column(
        children: [
          FutureBuilder(
            future: SharedPreference().getUsername(),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              return Text("Hello, ${snapshot.data}", style: TextStyle(fontSize: 24),);
            },
          ),
          Text("COba")
        ],
      ),
    );
  }

  Widget _buildDetailMakeupBody() {
    return Container(
      child: Column(
        children: [
          FutureBuilder(
            future: DataSource.instance.loadMakeup(),
            builder: (
                BuildContext context,
                AsyncSnapshot<dynamic> snapshot,
                ) {
              if (snapshot.hasError) {
                return _buildErrorSection();
              }
              if (snapshot.hasData) {
                List<ProductsModel>? productsModel = snapshot.data;
                if (snapshot.data!.isNotEmpty) {
                  return _buildSuccessSection(productsModel);
                }else{
                  return _buildEmptySection();
                }
              }
              return _buildLoadingSection();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildErrorSection() {
    return Text("Error");
  }

  Widget _buildEmptySection() {
    return Text("Data not Found");
  }

  Widget _buildLoadingSection() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildSuccessSection(List<ProductsModel>? data) {
      return Expanded(
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 350,
              childAspectRatio: 3/2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 20),
          itemCount: data!.length,
          itemBuilder: (BuildContext context, int index) {
            return _buildItemMakeup("${data[index].name}", "${data[index].price}", "${data[index].apiFeaturedImage}");
          },
        ),
      );
  }

  Widget _buildItemMakeup(String name, String price, String image) {
    return Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.white70,
            borderRadius: BorderRadius.circular(15)
        ),
        child: InkWell(
          onTap: (){

          },
          child: Column(
                children: [
                  Image.network(image, width: 80, height: 80, fit: BoxFit.cover),
                  Text(name),
                  Text(price),
            ],
          ),
        )
    );
  }
}