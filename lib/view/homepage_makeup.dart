import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prak_b_123190086_123190093/api/source/data_source.dart';
import 'package:prak_b_123190086_123190093/api/model/products_model.dart';
import 'package:prak_b_123190086_123190093/view/dashboard.dart';
import 'package:prak_b_123190086_123190093/view/detail_makeup.dart';
import 'package:prak_b_123190086_123190093/view/search.dart';
import 'package:prak_b_123190086_123190093/widget/SearchWidget.dart';

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
              child: Row(children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => Dashboard(),
                      ),
                    );

                  },
                  // padding: EdgeInsets.only(right: 50),
                  icon: Icon(Icons.account_circle_outlined, size: 30),
                ),
                SizedBox(width: 20),
                 IconButton(onPressed: () { Navigator.of(context).push(
                   MaterialPageRoute(
                     builder: (context) => Search(),
                   ),
                 );
                   }, icon: Icon(Icons.search,size: 30))
              ]),
            ),
          ],
        ),
        body: _buildListMakeupBody()
    );
  }

  Widget _buildListMakeupBody() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: <Widget>[
          // Widget buildSearch(),
          //All Product
          Expanded(
            child: FutureBuilder(
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
                  } else {
                    return _buildEmptySection();
                  }
                }
                return _buildLoadingSection();
              },
            ),
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
    return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: 0,
          crossAxisCount: 2,
        ),
        itemCount: data!.length,
        itemBuilder: (BuildContext context, int index) {
          return _buildItemMakeup(data, index, "${data[index].brand}", "${data[index].name}", "${data[index].price}", "${data[index].apiFeaturedImage}");
        },
    );
  }

  Widget _buildItemMakeup(List<ProductsModel> data, int index, String brand, String name, String price, String image) {
     return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => DetailMakeup(data: data, index: index),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.4),
                      spreadRadius: 2,
                      blurRadius: 3,
                      offset: const Offset(8.0, 8.0)
                    ),
                    BoxShadow(
                      color: Colors.white,
                      offset: const Offset(0.0, 0.0),
                      blurRadius: 0.0,
                      spreadRadius: 0.0,
                    )
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15)
              ),
                child: Column(
                  children: [
                    Expanded(
                        child: Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            child: Image.network(image, height: 160, fit: BoxFit.fill)
                        )
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: Text(brand,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Color(0xFF6E3D4E),
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(

                      ),
                    ),
                    Text("\$"+price,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(

                      ),
                    ),
                  ],
                ),
            ),
      ),
    );
  }

}
