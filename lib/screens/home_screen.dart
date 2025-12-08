import 'dart:convert';
import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gpt_markdown/gpt_markdown.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/screens/profile_screen.dart';

import 'home screen pages/movie_screen.dart';
import 'home screen pages/search_screen.dart';
import 'home screen pages/watch_list_screen.dart';
import 'login_screen.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final NotchBottomBarController _controller = NotchBottomBarController(index: 0);
  final TextEditingController chatController = TextEditingController();

  final List<Widget> pages = [
    MoviesScreen(),
    SearchScreen(),
    WatchListScreen(),
  ];
  late String name;
  late String email;

  Future<void> loadUserData() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;

    final doc = await FirebaseFirestore.instance
        .collection("Users")
        .doc(uid)
        .get();

    final data = doc.data();
    if (data == null) return;
    name = data["Name"];
    email = data["Email"];

  }

  Future<void>Logout() async {

    await FirebaseAuth.instance.signOut();
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context){return LoginScreen();}),
            (Route){return false;});
  }

  List<Map<String, String>> messages = [];
  String? responseText;

  void addMessageFromUser(String text) {
    messages.add({"Role": "User", "text": text});
  }

  void addMessageFromAI(String text) {
    messages.add({"Role": "AI", "text": text});
  }

  Future<void> getResponse(String userText, Function setStateDialog) async {
    const String apiKey = "AIzaSyClaJ9abDhfvqTlIWb7jFQlM-L3SjkzA58";
    const String apiLink =
        "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=$apiKey";

    final bodyData = {
      "contents": [
        {
          "parts": [
            {"text": userText}
          ]
        }
      ]
    };

    try {
      final response = await http.post(
        Uri.parse(apiLink),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(bodyData),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final text = data['candidates']?[0]?['content']?['parts']?[0]?['text'] ?? "No text";
        setStateDialog(() {
          responseText = text;
          addMessageFromAI(text);
        });
      } else {
        setStateDialog(() {
          responseText = "Error: ${response.statusCode}";
        });
      }
    } catch (e) {
      setStateDialog(() {
        responseText = "Error: $e";
      });
    }
  }
  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  Widget showAlertBox(BuildContext context) {
    final ScrollController _scrollController = ScrollController();

    void scrollDown() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_scrollController.hasClients) {
          _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
        }
      });
    }

    return StatefulBuilder(
      builder: (context, setStateDialog) {
        scrollDown(); // auto-scroll after each rebuild

        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Text("My AI Chat"),
          content: SizedBox(
            width: double.maxFinite,
            height: 400,
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    controller: _scrollController, // <-- added controller
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final mess = messages[index];
                      final isUser = mess['Role'] == "User";
                      return Align(
                        alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                        child: Container(
                          constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.6),
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: isUser ? Colors.blue[200] : Colors.grey[300],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: GptMarkdown(
                            mess['text']!,
                            overflow: TextOverflow.visible,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: chatController,
                        decoration: const InputDecoration(
                          hintText: "Type a message...",
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.send),
                      onPressed: () {
                        final text = chatController.text.trim();
                        if (text.isNotEmpty) {
                          setStateDialog(() {
                            addMessageFromUser(text);
                          });
                          chatController.clear();
                          getResponse(text, setStateDialog);
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void showProfile() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.white,
        insetPadding: EdgeInsets.zero,
        child: SizedBox(
          height: 490,
          child: Column(
            children: [
              const SizedBox(height: 12),
              const Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 68.0),
                  child: Text("Profile", style: TextStyle(fontFamily: "Dongle", fontSize: 47)),
                ),
              ),
              const SizedBox(height: 20),
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(38.0),
                    child: Container(
                      height: 300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: const Color(0xff305973),
                      ),
                      child: Column(
                        children: [
                          const SizedBox(height: 88),
                          Text(name, style: TextStyle(fontFamily: "Quicksand", fontSize: 25, color: Colors.black)),
                          Text(email, style: TextStyle(fontFamily: "Quicksand", fontSize: 20, color: Colors.black)),
                          const SizedBox(height: 35),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('assets/images/movie_details/Vector(8).png', height: 25, width: 25),
                              const SizedBox(width: 5),
                              InkWell(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfileScreen()));
                                },
                                child: const Text("Edit Profile", style: TextStyle(fontSize: 22, fontFamily: "Quicksand")),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset("assets/images/movie_details/Group.png", height: 25, width: 25),
                              const SizedBox(width: 5),
                              InkWell(
                                  onTap: (){
                                    Logout();
                                  },
                                  child: Text("LogOut", style: TextStyle(fontSize: 22, fontFamily: "Quicksand"))),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 140,
                    bottom: 255,
                    child: SizedBox(
                      height: 120,
                      width: 120,
                      child: CircleAvatar(
                        backgroundImage: AssetImage("assets/images/movie_details/Ellipse14.png"),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: SizedBox(
        height: 80,
        child: AnimatedNotchBottomBar(
          notchBottomBarController: _controller,
          notchColor: const Color(0xFF305973),
          bottomBarWidth: MediaQuery.of(context).size.width,
          removeMargins: true,
          kIconSize: 24.0,
          kBottomRadius: 0.0,
          color: const Color(0xFF305973),
          onTap: (index) {
            if (index == 3) {
              showProfile();
            } else {
              setState(() => _controller.index = index);
            }
          },
          bottomBarItems: [
            BottomBarItem(
              inActiveItem: Image.asset("assets/images/Vector.png", width: 24, height: 24, color: const Color(0xffF6F7D3)),
              activeItem: Image.asset("assets/images/Vector.png", width: 24, height: 24, color: const Color(0xffF6F7D3)),
              itemLabel: 'Movies',
            ),
            BottomBarItem(
              inActiveItem: Image.asset("assets/images/search.png", width: 24, height: 24, color: const Color(0xffF6F7D3)),
              activeItem: Image.asset("assets/images/search.png", width: 24, height: 24, color: const Color(0xffF6F7D3)),
              itemLabel: 'Search',
            ),
            BottomBarItem(
              inActiveItem: Image.asset("assets/images/bookmark.png", width: 24, height: 24, color: const Color(0xffF6F7D3)),
              activeItem: Image.asset("assets/images/bookmark.png", width: 24, height: 24, color: const Color(0xffF6F7D3)),
              itemLabel: 'Saved',
            ),
            BottomBarItem(
              inActiveItem: Image.asset("assets/images/profile.png", width: 24, height: 24, color: const Color(0xffF6F7D3)),
              activeItem: Image.asset("assets/images/profile.png", width: 24, height: 24, color: const Color(0xffF6F7D3)),
              itemLabel: 'Profile',
            ),
          ],
        ),
      ),
      appBar: AppBar(
        toolbarHeight: 100,
        title: const Padding(
          padding: EdgeInsets.only(top: 48.0),
          child: Text("MOVIES", style: TextStyle(fontSize: 35, color: Color(0xff305973), fontFamily: "Dongle")),
        ),
        backgroundColor: Colors.white,
        actions: const [
          Padding(
            padding: EdgeInsets.only(top: 38.0, right: 20),
            child: CircleAvatar(
              backgroundImage: AssetImage("assets/images/mask_island.png"),
              radius: 30,
            ),
          )
        ],
      ),
      body: _controller.index < 3 ? pages[_controller.index] : null,
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialog(context: context, builder: (context) => showAlertBox(context)),
        shape: const CircleBorder(),
        child: const Text("AI"),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
