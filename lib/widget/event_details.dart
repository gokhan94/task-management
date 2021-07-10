import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EventDetails extends StatefulWidget {
  @override
  _EventDetailsState createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
                height: size.height,
                child: Stack(
                  children: [
                    EventBackdrop(size: size),
                    Container(
                      margin: EdgeInsets.only(top: size.height * 0.3),
                      width: double.infinity,
                      height: size.height * 0.7,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30)),
                          color: Colors.white),
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                "Volunteer at ST. Georga Mara-thon 2021 ( Gökhan )",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22,
                                    color: Colors.black)),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: Colors.grey, width: 1)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Date(),
                                  buildLine(),
                                  Participants(size: size),
                                ],
                              ),
                            ),
                            eventAboutTitle(),
                            EventContent(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }

  Padding eventAboutTitle() {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: Container(
        child: Text("About Event",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.black87)),
      ),
    );
  }

  Container buildLine() {
    return Container(
      width: double.infinity,
      child: Divider(
        thickness: 1,
        color: Colors.grey,
      ),
    );
  }
}

class EventContent extends StatelessWidget {
  const EventContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 10),
          child: Container(
            child: Text(
                "Lorem Ipsum, dizgi ve baskı endüstrisinde kullanılan mıgır metinlerdir. Lorem Ipsum, adı bilinmeyen bir matbaacının bir hurufat numune kitabı oluşturmak üzere bir yazı galerisini alarak karıştırdığı 1500'lerden beri endüstri standardı sahte metinler olarak kullanılmıştır. Beşyüz yıl boyunca varlığını sürdürmekle kalmamış, aynı zamanda pek değişmeden elektronik dizgiye de sıçramıştır. 1960'larda Lorem Ipsum pasajları da içeren Letraset yapraklarının yayınlanması ile ve yakın zamanda Aldus PageMaker gibi Lorem Ipsum sürümleri içeren masaüstü yayıncılık yazılımları ile popüler olmuştur.",
                style: TextStyle(
                    height: 1.4, fontSize: 19, color: Colors.black87)),
          ),
        ),
      ),
    );
  }
}

class Participants extends StatelessWidget {
  const Participants({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.only(left: 30),
            child: Text("Going",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black87)),
          ),
        ),
        Expanded(
          child: Container(
            width: size.width * .30,
            height: 50,
            child: Stack(
              children: [
                ...List.generate(3, (index) {
                  return Positioned(
                      left: (30 * index).toDouble(),
                      child: ClipOval(
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.white, width: 2)),
                          child: Image.asset(
                            "assets/images/coffee_time.png",
                            height: 40,
                            width: 40,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ));
                }),
              ],
            ),
          ),
        ),
        Expanded(
          child: Text("+20 Going",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.blueAccent.shade400)),
        ),
      ],
    );
  }
}

class Date extends StatelessWidget {
  const Date({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.only(left: 25, right: 40),
            child: Text("Date",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black87)),
          ),
          Expanded(
            child: Text("Thursday, July 24, 2021\n 8.30 AM - 11.30 AM",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 19,
                    color: Colors.black54)),
          ),
        ],
      ),
    );
  }
}

class EventBackdrop extends StatelessWidget {
  const EventBackdrop({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            height: size.height * 0.4,
            width: size.width,
            decoration: BoxDecoration(
                image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage("assets/images/header.png"),
            )))
      ],
    );
  }
}
