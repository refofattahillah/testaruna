import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:news/constants.dart';
import 'package:news/models/Blog.dart';
import 'package:news/responsive.dart';
import 'package:http/http.dart' as http;

class DetailScreen extends StatefulWidget {
  final String? title;
  final String? body;
  
  const DetailScreen({
   this.title, this.body, Key? key
  }) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  List<dynamic>? blogPosts;
  List<dynamic>? finalresults;
  final String apiUrl = "https://jsonplaceholder.typicode.com/posts";

  Future<List<dynamic>> _fecthDataUsers() async {
    var result = await http.get(Uri.parse(apiUrl));
    // print(result.body);
     setState(() {
       blogPosts = json.decode(result.body);
       finalresults = json.decode(result.body);
     });
    return json.decode(result.body);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fecthDataUsers();
  }
  @override
  Widget build(BuildContext context) {
    

    return Column(
      children: [
      SizedBox(height: 10,),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 5,
              child: Column(
                children: List.generate(
                  1,
                  (index) => Container(
                padding: EdgeInsets.all(kDefaultPadding),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(vertical: kDefaultPadding),
                      child: Text(
                        widget.title!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: Responsive.isDesktop(context) ? 32 : 24,
                          fontFamily: "Raleway",
                          color: kDarkBlackColor,
                          height: 1.3,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(vertical: kDefaultPadding),
                      child: Text(
                        widget.body!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: "Raleway",
                          color: kDarkBlackColor,
                          height: 1.3,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(height: kDefaultPadding),
                  ],
                ),
              ),
                ),
              ),
            ),
            if (!Responsive.isMobile(context)) SizedBox(width: kDefaultPadding),
            // Sidebar
            if (!Responsive.isMobile(context))
              Expanded(
                child: Column(
                  children: [
                  ],
                ),
              ),
          ],
        ),
      ],
    );
  }
}
