import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:news/constants.dart';
import 'package:news/models/Blog.dart';
import 'package:news/responsive.dart';
import 'package:http/http.dart' as http;
import 'package:news/screens/home/detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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

  void filterSearchResults(String query) {
    if (query.isNotEmpty) {
      setState(() {
        blogPosts!.clear();
        finalresults!.forEach((item) {
          if (item['title'].contains(query)) {
            blogPosts!.add(item);
          }
        });
      });
    } else {
      setState(() {
        blogPosts!.addAll(finalresults!);
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fecthDataUsers();
  }

  @override
  Widget build(BuildContext context) {
    return blogPosts == null
        ? Center(child: CircularProgressIndicator())
        : Column(
            children: [
              Container(
                color: Colors.white,
                child: TextField(
                  onChanged: (value) {
                    filterSearchResults(value);
                  },
                  decoration: InputDecoration(
                    hintText: "Type Here ...",
                    suffixIcon: Padding(
                      padding: const EdgeInsets.all(kDefaultPadding / 2),
                      child:
                          SvgPicture.asset("assets/icons/feather_search.svg"),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(kDefaultPadding / 2),
                      ),
                      borderSide: BorderSide(color: Color(0xFFCCCCCC)),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 5,
                    child: Column(
                      children: List.generate(
                        blogPosts!.length,
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
                                padding: const EdgeInsets.symmetric(
                                    vertical: kDefaultPadding),
                                child: Text(
                                  blogPosts![index]['title'],
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize:
                                        Responsive.isDesktop(context) ? 32 : 24,
                                    fontFamily: "Raleway",
                                    color: kDarkBlackColor,
                                    height: 1.3,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              SizedBox(height: kDefaultPadding),
                              Row(
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => DetailScreen(
                                                  body: blogPosts![index]
                                                      ['body'],
                                                  title: blogPosts![index]
                                                      ['title'],
                                                )),
                                      );
                                    },
                                    child: Container(
                                      padding: EdgeInsets.only(
                                          bottom: kDefaultPadding / 4),
                                      decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                              color: kPrimaryColor, width: 3),
                                        ),
                                      ),
                                      child: Text(
                                        "Read More",
                                        style:
                                            TextStyle(color: kDarkBlackColor),
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  IconButton(
                                    icon: SvgPicture.asset(
                                        "assets/icons/feather_thumbs-up.svg"),
                                    onPressed: () {},
                                  ),
                                  IconButton(
                                    icon: SvgPicture.asset(
                                        "assets/icons/feather_message-square.svg"),
                                    onPressed: () {},
                                  ),
                                  IconButton(
                                    icon: SvgPicture.asset(
                                        "assets/icons/feather_share-2.svg"),
                                    onPressed: () {},
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (!Responsive.isMobile(context))
                    SizedBox(width: kDefaultPadding),
                  // Sidebar
                  if (!Responsive.isMobile(context))
                    Expanded(
                      child: Column(
                        children: [],
                      ),
                    ),
                ],
              ),
            ],
          );
  }
}
