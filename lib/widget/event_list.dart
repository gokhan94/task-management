import 'package:flutter/material.dart';

class EventList extends StatelessWidget {
  const EventList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .30,
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: 10,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              width: MediaQuery.of(context).size.width * .40,
              child: Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Design Team",
                        style: TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                            fontSize: 20)),
                    SizedBox(
                      height: 10,
                    ),
                    Text("4 People",
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 18)),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: double.infinity,
                      height: 40,
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
              ),
              // height: 200,
            );
          }),
    );
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