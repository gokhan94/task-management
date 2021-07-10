import 'package:flutter/material.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({
    Key? key,
  }) : super(key: key);

  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  int selectedCategory = 0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 10,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selectedCategory = index;
                  });
                },
                child: Container(
                  width: 120,
                  decoration: BoxDecoration(
                      color: index == selectedCategory
                          ? Colors.redAccent.shade200
                          : Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(10)),
                  child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Design",
                        style: TextStyle(
                            color: index == selectedCategory
                                ? Colors.white
                                : Colors.grey.shade700,
                            fontSize: 20,
                            fontWeight: FontWeight.w600),
                      )),
                ),
              ),
            );
          }),
    );
  }
}