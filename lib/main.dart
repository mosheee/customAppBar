import 'dart:ui';

import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MaterialApp(
    home: SafeArea(
      child: Scaffold(
        body: Column(
          children: [CustomAppBar(group: myGroup,)],
        ),
      ),
    ),
  ));
}

class CustomAppBar extends StatefulWidget {
  final Group? group;
  const CustomAppBar({Key? key, this.group}) : super(key: key);
  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  bool showCircles = false;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 300),
        lowerBound: 70,
        upperBound: 130);
    _animationController?.addListener(() {
      setState(() {});
      _animationController!.status == AnimationStatus.completed
          ? showCircles = true
          : showCircles = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    print('the group which send to CustomAppBar${widget.group!.name}');
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Material(
        elevation: 10,
        child: Container(
          color: Theme.of(context).appBarTheme.backgroundColor,
          width: double.infinity,
          height: _animationController!.value,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: GestureDetector(
              onTap: () {
                _animationController!.status == AnimationStatus.completed
                    ? _animationController!.reverse()
                    : _animationController!.forward();
              },
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'the homies',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
                        ),
                      ),
                      Align(
                          alignment: Alignment.topRight,
                          child: Icon(Icons.keyboard_arrow_down))
                    ],
                  ),
                  showCircles == true
                      ? Align(
                          alignment: Alignment.bottomLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 7),
                            child: SizedBox(
                              height: 50,
                              child: ListView(
                                children: widget.group!.groupMembers
                                    .map((member) => circle(Random().nextBool(),
                                        member.profilePicture))
                                    .toList(),
                                scrollDirection: Axis.horizontal,
                              ),
                            ),
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget circle(bool didLike, String image) {
    return Padding(
      padding: const EdgeInsets.only(right: 7),
      child: SizedBox(
        height: 60,
        width: 60,
        child: Stack(children: [
          CircleAvatar(
            backgroundImage: AssetImage(image),
            radius: 25,
          ),
          Align(
              alignment: Alignment.bottomRight,
              child: CircleAvatar(
                backgroundColor: didLike ? Colors.green : Colors.red,
                radius: 12,
                child: didLike
                    ? const Icon(
                        Icons.done,
                        color: Colors.white,
                      )
                    : const Icon(
                        Icons.clear,
                        color: Colors.white,
                      ),
              ))
        ]),
      ),
    );
  }
}






class Group {
  Group({required this.name,required this.groupMembers});
  String name;
  List<User> groupMembers;
}

class User {
  User({required this.profilePicture,required this.name});
String profilePicture;
String name;
}

Group myGroup = Group(name: 'the homies', groupMembers: [User(name: 'barni',profilePicture: 'assets/barni.jpg'),User(name: 'donatelo',profilePicture: 'assets/donatelo.jpg'),User(name: 'micaelo',profilePicture: 'assets/micaelo.jpg')]) ;