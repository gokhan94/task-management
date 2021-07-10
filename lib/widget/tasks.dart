import 'package:flutter/material.dart';

class Tasks extends StatelessWidget {
  const Tasks({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(5.0),
        child: SizedBox(
          height: 150,
          child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: 4,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      height: 125,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Text("Meeting with Argir Bistanob",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.black87)),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 20, horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text("24 July",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Colors.yellowAccent.shade700)),
                                Text("+20 Going",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Colors.blueAccent)),
                                Container(
                                  width:
                                  MediaQuery.of(context).size.width * .30,
                                  height: 50,
                                  child: Stack(
                                    children: [
                                      ...List.generate(4, (index) {
                                        return Positioned(
                                            left: (30 * index).toDouble(),
                                            child: buildClipOval());
                                      }),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      )),
                );
              }),
        ));
  }

  ClipOval buildClipOval() {
    return ClipOval(
      child: Container(
        decoration:
        BoxDecoration(border: Border.all(color: Colors.white, width: 2)),
        child: Image.asset(
          "assets/images/coffee_time.png",
          height: 40,
          width: 40,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}