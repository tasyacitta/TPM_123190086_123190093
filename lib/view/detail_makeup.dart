import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prak_b_123190086_123190093/api/model/products_model.dart';
import 'package:prak_b_123190086_123190093/helper/hive_database.dart';
import 'package:prak_b_123190086_123190093/helper/shared_preference.dart';
import 'package:prak_b_123190086_123190093/model/review_model.dart';
import 'dashboard.dart';
import 'homepage.dart';

class DetailMakeup extends StatefulWidget {
  final List<ProductsModel> data;
  final int index;
  const DetailMakeup({Key? key, required this.data, required this.index})
      : super(key: key);

  @override
  _DetailMakeupState createState() => _DetailMakeupState();
}

class _DetailMakeupState extends State<DetailMakeup> {
  final HiveDatabase _hive = HiveDatabase();

  TextEditingController _reviewController = TextEditingController();
  String dropdownvalueskin = 'Oily';
  String dropdownvalueusage = 'Less than 1 week';
  final skin_type = ['Oily', 'Dry', 'Normal', 'Combination'];
  final usage_period = [
    'Less than 1 week',
    '1 week - 1 month',
    '1 month - 3 months',
    '3 months - 6 months',
    '6 months - 1 year',
    'More than 1 year'
  ];
  bool _canShowButton = true;
  void hideWidget() {
    setState(() {
      _canShowButton = !_canShowButton;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Makeup Detail"),
        backgroundColor: Color(0xff885566),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 30),
            child: Row(children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => Dashboard(),
                    ),
                  );
                },
                icon: Icon(Icons.account_circle_outlined, size: 30),
              ),
              SizedBox(width: 50),
            ]),
          ),
        ],
      ),
      body: _buildDetailMakeup(),
    );
  }

  Widget _buildDetailMakeup() {
    return Container(
      margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Column(
        children: [
          //detail
          Container(
            // margin: new EdgeInsets.symmetric(horizontal: 20.0),
            padding: new EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.pink[50],
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              children: [
                Image.network(
                  "${widget.data[widget.index].apiFeaturedImage}",
                  width: 200,
                  height: 200,
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(20, 20, 0, 0),
                  width: 200,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text(
                        "${widget.data[widget.index].name}",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Raleway'),
                      ),
                      Container(
                          child: Row(
                        children: [
                          const Text(
                            "\$",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Raleway',
                                fontSize: 16),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "${widget.data[widget.index].price}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Raleway'),
                          ),
                        ],
                      )),
                      SizedBox(height: 20),
                      Text(
                        "${widget.data[widget.index].description}",
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                            fontWeight: FontWeight.w100, fontFamily: 'Raleway'),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(child: _buildReviewForm()),
          SizedBox(
            height: 20,
          ),
          Expanded(child: _buildReviewList()),
          //review
        ],
      ),
    );
  }

  Widget _buildReviewList() {
    List<ReviewModel> review = _hive.getReview(widget.data[widget.index].id!);

    return Container(
      child: Column(
        children: [
          Divider(),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: review.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                    child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 20, 0, 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new SizedBox(
                        height: 10.0,
                        child: new Center(
                          child: new Container(
                            margin: new EdgeInsetsDirectional.only(start: 1.0, end: 1.0),
                            height: 2.0,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.account_circle,
                            size: 20,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            "${review[index].username}",
                            style: TextStyle(fontFamily: "Lato"),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 40),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Skin Type: ",
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.6)),
                                ),
                                Text("${review[index].skin_type}"),
                              ],
                            ),
                            SizedBox(height: 5,),
                            Row(
                              children: [
                                Text(
                                  "Usage Period: ",
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.6)),
                                ),
                                Text("${review[index].usage_period}"),
                              ],
                            ),
                            SizedBox(height: 5,),
                                Text(
                                  "Review: ",
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.6)),
                                ),
                                    SizedBox(width: 5,),
                                    Text("${review[index].review}", textAlign: TextAlign.justify,),
                          ],
                        ),
                      ),

                    ],
                  ),
                ));
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _buildReviewForm() {
    return Container(
      child: !_canShowButton
          ? const SizedBox.shrink()
          : Column(
              children: [
                Row(
                  children: [
                    const Text(
                      "Skin Type: ",
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(
                      width: 35,
                    ),
                    DropdownButton(
                      value: dropdownvalueskin,
                      icon: Icon(Icons.keyboard_arrow_down),
                      items: skin_type.map((String items) {
                        return DropdownMenuItem(
                            value: items, child: Text(items));
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          dropdownvalueskin = newValue.toString();
                        });
                      },
                    ),
                  ],
                ),
                //skin_type
                Row(
                  children: [
                    const Text(
                      "Usage Period: ",
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    DropdownButton(
                      value: dropdownvalueusage,
                      icon: Icon(Icons.keyboard_arrow_down),
                      items: usage_period.map((String items) {
                        return DropdownMenuItem(
                            value: items, child: Text(items));
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          dropdownvalueusage = newValue.toString();
                        });
                      },
                    ),
                  ],
                ),
                Container(
                  child: TextFormField(
                    minLines: 3,
                    maxLines: 5,
                    controller: _reviewController,
                    decoration: const InputDecoration(
                      contentPadding: const EdgeInsets.all(20.0),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.pinkAccent, width: 2.0),
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.lightBlueAccent, width: 2.0),
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      ),
                      fillColor: Colors.white,
                      filled: true,
                      hintText: "Write your review",
                    ),
                    validator: (value) =>
                        value!.isEmpty ? 'Review cannot be blank' : null,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                !_canShowButton
                    ? const SizedBox.shrink()
                    : ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0),
                            ),
                            primary: Color(0xFFF8BBD0),
                            textStyle: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold)),
                        child: Text("Submit"),
                        onPressed: () async {
                          int id_user = await SharedPreference().getIdUser();
                          String username =
                              await SharedPreference().getUsername();
                          int i = _hive
                              .getLengthReview(widget.data[widget.index].id!);
                          if (_reviewController.text.isNotEmpty) {
                            _hive.addDataReview(ReviewModel(
                                id: i,
                                id_product: widget.data[widget.index].id!,
                                id_user: id_user,
                                username: username,
                                review: _reviewController.text,
                                skin_type: dropdownvalueskin,
                                usage_period: dropdownvalueusage));
                            _reviewController.clear();
                            setState(() {});
                            hideWidget();
                            // Navigator.pop(context);
                          } else {}
                        })
              ],
            ),
    );
  }
}
