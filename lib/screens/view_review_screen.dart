import 'package:flutter/material.dart';
import 'package:untitled/screens/write_review_screen.dart';

import '../ui_helper/api_helper.dart';
import '../ui_helper/global_data.dart';



class ViewReviewsScreen extends StatefulWidget {
  const ViewReviewsScreen({super.key});

  @override
  State<ViewReviewsScreen> createState() => _ViewReviewsScreenState();
}

class _ViewReviewsScreenState extends State<ViewReviewsScreen> {
  @override
  void initState() {
    super.initState();
    print("review function call...");
    fetchReviewDetails(movieId:24428);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 40,
        backgroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: UsersReviews.length,
            separatorBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              child: Divider(
                color: Colors.grey,
                thickness: 1,
              ),
            ),
            itemBuilder: (context, index) {
              var item = UsersReviews[index];
              return ListTile(
                title: Text(item["title"]),
                subtitle: Text(
                  item["description"],
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: Icon(Icons.star, color: Colors.amber),
              );
            },
          ),

          Positioned(
            right: 20,
            bottom: 30,
            child: FloatingActionButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context){return WriteReview();}));
              },
              backgroundColor: Colors.green,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(55)
              ),
              child: Icon(Icons.add , color: Colors.white , size: 30,),
            ),
          ),

        ],
      ),
    );
  }
}
