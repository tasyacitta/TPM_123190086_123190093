import 'dart:js';

import 'package:flutter/material.dart';
import 'package:prak_b_123190086_123190093/api/model/products_model.dart';
import 'package:prak_b_123190086_123190093/api/source/data_source.dart';
import 'package:prak_b_123190086_123190093/api/source/base_network.dart';
import 'package:prak_b_123190086_123190093/view/detail_makeup.dart';


  @override
  Widget? buildLeading(BuildContext context) {
    IconButton(
      onPressed: () {},
      icon: Icon(Icons.arrow_back_ios, size: 30),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildListMakeupBody();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    throw UnimplementedError();
  }
  Widget _buildListMakeupBody() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
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
    return Center(child: Text("Data not Found"));
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
          // Navigator.of(context).push(
          //   MaterialPageRoute(
          //     builder: (context) => DetailMakeup(data: data, index: index),
          //   ),
          // );
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
// }

class Search extends StatefulWidget {
  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String query = '';
  TextEditingController _controller = TextEditingController();
  FocusNode _node = FocusNode();

  @override
  Widget build(BuildContext context) {
  return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff885566),
        title: Container(
          width: double.infinity,
          height: 40,
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFFF8BBD0),
              ),
              child: TextField(
                textCapitalization: TextCapitalization.words,
                focusNode: _node,
                autofocus: true,
                controller: _controller,
                onChanged: (text) {
                  this.query = text;
                },
                onEditingComplete: () => setState(() {}),
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.clear,
                      color: Colors.white,
                    ),
                    onPressed: () => _controller.clear(),
                  ),
                  hintText: 'Search product',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 20),
        child: FutureBuilder<List<ProductsModel>>(
          future: getQueriedModel(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasData) {
              List<ProductsModel>? productsModel = snapshot.data;
              if (snapshot.data!.isNotEmpty) {
                return _buildSuccessSection(productsModel);
              } else {
                return _buildEmptySection();
              }
            }
            return Container();
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    this._controller.dispose();
    this._node.dispose();
    super.dispose();
  }

  Future<List<ProductsModel>> getQueriedModel() async {
    this._node.unfocus();
    String query = this._controller.text;
    if (query.isEmpty) return [];
    return await DataSource.instance.getModelBySearchQuery(query);
  }
}
