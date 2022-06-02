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
  const DetailMakeup({Key? key, required this.data, required this.index}) : super(key: key);

  @override
  _DetailMakeupState createState() => _DetailMakeupState();
}

class _DetailMakeupState extends State<DetailMakeup> {
  final HiveDatabase _hive = HiveDatabase();

  TextEditingController _reviewController = TextEditingController();
  String dropdownvalueskin = 'Oily';
  String dropdownvalueusage = 'Less than 1 week';
  final skin_type = ['Oily', 'Dry', 'Normal', 'Combination'];
  final usage_period = ['Less than 1 week', '1 week - 1 month', '1 month - 3 months', '3 months - 6 months', '6 months - 1 year', 'More than 1 year'];

  // print(_hive.getReview(widget.data[widget.index].id!));
  // print(_hive.getLengthReview(widget.data[widget.index].id!));
  // print(_hive.getLengthReviewAll());

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text("Makeup List"),
          backgroundColor: Color(0xff885566),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 30),
            child: Row(
                children: [
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
                  IconButton(
                    onPressed: () {
                      SharedPreference().setLogout();
                      Navigator.pushAndRemoveUntil(context,
                        MaterialPageRoute(builder: (context) => HomePage()),(route) => false);
                    },
                    icon: Icon(Icons.logout, size: 30),
                  ),
               ]
            ),
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
          Row(
          children: [
            Image.network("${widget.data[widget.index].apiFeaturedImage}", width: 200, height: 200,),
            Container(
              margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
              width: 200,
              child: Column(
                children: [
                  // Text("${review[1].review}"),
                  Text("${widget.data[widget.index].name}"),
                  Text("${widget.data[widget.index].price}"),
                  Text("${widget.data[widget.index].description}",
                  // maxLines: 2,
                  // overflow: TextOverflow.ellipsis
                  ),
                ],
              ),
            )
          ],
          ),
          Expanded(
            child: _buildReviewList()
          ),
          //review
          Container(
            child: _buildReviewForm()
          ),
        ],
      ),
    );
  }

  Widget _buildReviewList(){
    List<ReviewModel> review = _hive.getReview(widget.data[widget.index].id!);

    return Container(
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: review.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  child: Column(
                    children: [
                      Text("${review[index].username}"),
                      Text("${review[index].review}"),
                      Text("${review[index].skin_type}"),
                      Text("${review[index].usage_period}"),
                    ],
                  )
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _buildReviewForm(){
    return Column(
      children: [
        Container(
          child: TextFormField(
            minLines: 3,
            maxLines: 5,
            controller: _reviewController,
            decoration: const InputDecoration(
              contentPadding: const EdgeInsets.all( 20.0),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.pinkAccent, width: 2.0),
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
              ),
              fillColor: Colors.white,
              filled: true,
              hintText: "Write your review",
            ),
            validator: (value) => value!.isEmpty ? 'Review cannot be blank' : null,
          ),
        ),
        //skin_type
        DropdownButton(
          value: dropdownvalueskin,
          icon: Icon(Icons.keyboard_arrow_down),
          items:skin_type.map((String items) {
            return DropdownMenuItem(
                value: items,
                child: Text(items)
            );
          }
          ).toList(),
          onChanged: (newValue){
            setState(() {
              dropdownvalueskin = newValue.toString();
            });
          },
        ),
        DropdownButton(
          value: dropdownvalueusage,
          icon: Icon(Icons.keyboard_arrow_down),
          items:usage_period.map((String items) {
            return DropdownMenuItem(
                value: items,
                child: Text(items)
            );
          }
          ).toList(),
          onChanged: (newValue){
            setState(() {
              dropdownvalueusage = newValue.toString();
            });
          },
        ),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0),),
                primary: Color(0xFFF8BBD0),
                textStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold)),
            child: Text("Submit"),
            onPressed: () async {
              int id_user = await SharedPreference().getIdUser();
              String username = await SharedPreference().getUsername();
              int i = _hive.getLengthReview(widget.data[widget.index].id!);
              if (_reviewController.text.isNotEmpty) {
                _hive.addDataReview(
                    ReviewModel(
                        id: i,
                        id_product: widget.data[widget.index].id!,
                        id_user: id_user,
                        username: username,
                        review: _reviewController.text,
                        skin_type: dropdownvalueskin,
                        usage_period: dropdownvalueusage
                    )
                );
                _reviewController.clear();
                setState(() {});
                // Navigator.pop(context);
              }else{}
            }
        )
      ],
    );
  }
}
