import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class WriteReview extends StatefulWidget {
  const WriteReview({super.key});

  @override
  State<WriteReview> createState() => _WriteReviewState();
}

class _WriteReviewState extends State<WriteReview> {
  var reviewController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 91 , top: 74),
            child: Text("Write your review" , style: TextStyle(fontWeight: FontWeight.w400, fontSize: 25 , fontFamily: "Quicksand"),),
          ),
          Positioned(
            right: 20,
            bottom: 30,
            child: FloatingActionButton(
              backgroundColor: Colors.green,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(55)
              ),
              onPressed: (){
                Navigator.pop;
              },
              child: Icon(Icons.done , size: 30 , color: Colors.white,),
            ),
          ),

          Positioned(
            top:160,
            left: 0 , right: 0 ,
            bottom: 100,
            child: Container(
              height: 500,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft:Radius.circular(10) , topRight:Radius.circular(10)),
                  color: Color(0xff394E5B)
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 22.0 , top: 20),
                    child: Align( alignment: Alignment.topLeft , child: Text("Saving Private Ryan , 1998" , style: TextStyle(fontSize: 20 , fontFamily: "Quicksand" , color: Colors.black),)),
                  ),
                  SizedBox(height: 5,),

                  Divider(thickness: 2 , color: Color(0xff837E7E),),

                  SizedBox(height: 5,),

                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: RatingBar.builder(
                        initialRating: 3,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemSize: 60,
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Colors.green,
                        ),
                        // act like on tap and store rated stars
                        onRatingUpdate: (rating) {
                          print(rating);
                        },
                      ),
                    ),
                  ),
                  Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 22.0),
                        child: Text("Rating" , style: TextStyle(fontFamily: "Dongle" ,
                            fontSize: 30 , fontWeight: FontWeight.bold),),
                      )),
                  SizedBox(height: 5,),
                  Divider(thickness: 2 , color: Color(0xff837E7E),),
                  SizedBox(height: 5,),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal:22.0),
                    child: TextField(
                      cursorColor: Colors.white,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: "Quicksand"
                      ),
                      controller: reviewController,
                      maxLines: 4,
                      decoration: InputDecoration(
                          hint: Text("Add text..." , style: TextStyle(fontSize: 20, fontFamily: "Quickstand"  , color: Color(0xff837E7E) , fontWeight: FontWeight.bold),),
                          border:InputBorder.none,
                          enabledBorder: InputBorder.none
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
