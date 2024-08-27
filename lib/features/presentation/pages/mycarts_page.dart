import 'package:flutter/material.dart';

class MyCArtsPage extends StatefulWidget {
  const MyCArtsPage({super.key});

  @override
  State<MyCArtsPage> createState() => _MyCArtsPageState();
}

class _MyCArtsPageState extends State<MyCArtsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            reusableText("My Basket", FontWeight.w600, 22),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22.0),
          child: Column(
            children: [
              Row(
                children: [
                  reusableText("Order Summary", FontWeight.w600, 16),
                  const Spacer(),
                  DecoratedBox(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 3.0, horizontal: 8),
                        child: reusableText("Add Items", FontWeight.w400, 16),
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.red)))
                ],
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    int count = 1;

                    return Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.asset(
                                        "assets/Image Burger (1).png")),
                                Padding(
                                  padding: const EdgeInsets.only(left: 18.0),
                                  child: Column(
                                    children: [
                                      const Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: 10.0, bottom: 2),
                                            child: Text(
                                              "Ramen Noodles",
                                              style: TextStyle(
                                                overflow: TextOverflow.ellipsis,
                                                fontSize: 15,
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                bottom: 6, top: 8),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "£ 12 ",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 15,
                                                        color:
                                                            Color(0xff989DA3),
                                                        decoration:
                                                            TextDecoration
                                                                .lineThrough),
                                                  ),
                                                  Text(
                                                    "£ ${12} ",
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Color(0xffFF6347),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                count += 1;
                                              });
                                            },
                                            child: DecoratedBox(
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                      color: Colors.black)),
                                              child: const Padding(
                                                padding: EdgeInsets.all(4.0),
                                                child: Center(
                                                    child: Icon(Icons.add)),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                            child: reusableText(
                                                "$count", FontWeight.w400, 22),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              if (count > 0) {
                                                setState(() {
                                                  count -= 1;
                                                });
                                              }
                                            },
                                            child: DecoratedBox(
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                      color: Colors.black)),
                                              child: const Padding(
                                                padding: EdgeInsets.all(4.0),
                                                child: Center(
                                                    child: Icon(Icons.remove)),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const Spacer(),
                                const Icon(Icons.close)
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Text reusableText(String text, FontWeight wight, double size,
    [Color color = Colors.black]) {
  return Text(
    text,
    overflow: TextOverflow.clip,
    style: TextStyle(fontWeight: wight, fontSize: size, color: color),
  );
}
