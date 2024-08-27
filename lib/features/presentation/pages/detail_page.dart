import 'package:flutter/material.dart';

import '../../domain/entities/product_entity.dart';

class DetailPage extends StatefulWidget {
  final ProductEntity product;

  const DetailPage({
    super.key,
    required this.product,
  });

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool isExpanded = false;
  int count = 1;
  @override
  Widget build(BuildContext context) {
    final args = widget.product;
    final discount = args.price - args.discount;

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
            child: Column(
          children: [
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      decoration: BoxDecoration(
                          color: const Color(0xb3000000),
                          borderRadius: BorderRadius.circular(18)),
                      height: 280,
                      width: double.infinity,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: Image.network(
                          args.imageUrl,
                          fit: BoxFit.cover,
                        ),
                      )),
                ),
                Positioned(
                  top: 12,
                  left: 15,
                  child: DecoratedBox(
                    decoration: const BoxDecoration(
                        color: Colors.white, shape: BoxShape.circle),
                    child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back_ios_new)),
                  ),
                ),
                Positioned(
                  bottom: 18,
                  right: 15,
                  child: DecoratedBox(
                    decoration: const BoxDecoration(
                        color: Colors.white, shape: BoxShape.circle),
                    child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.favorite_border_rounded,
                          color: Colors.red,
                        )),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 18, bottom: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        reusableText(args.title, FontWeight.w600, 24),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Row(
                      children: [
                        Visibility(
                          visible: discount != 0,
                          child: Text(
                            "£ ${args.discount + args.price} ",
                            style: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 20,
                                color: Color(0xff989DA3),
                                decoration: TextDecoration.lineThrough),
                          ),
                        ),
                        reusableText("£ ${args.price} ", FontWeight.w600, 22,
                            const Color(0xffFF6347)),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Icon(Icons.star_rate_rounded,
                          color: Color(0xffFFC700), size: 24),
                      reusableText(
                        "${args.rating}",
                        FontWeight.w600,
                        16,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: reusableText(
                            "(1.205)", FontWeight.w400, 16, Colors.grey),
                      ),
                      const Spacer(),
                      const Text(
                        "See all review",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            decoration: TextDecoration.underline,
                            color: Color(0xff697079)),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 18.0, bottom: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          args.description,
                          maxLines: isExpanded ? null : 3,
                          overflow: isExpanded
                              ? TextOverflow.visible
                              : TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 16),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                isExpanded = !isExpanded;
                              });
                            },
                            child: Text(
                              isExpanded ? "Show less" : "Show more",
                              style: const TextStyle(
                                color: Color(0xff697079),
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  reusableText("Additional Options : ", FontWeight.w600, 18),
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.2,
                    child: ListView.builder(
                        itemCount: args.options.length,
                        itemBuilder: (context, index) {
                          final option = args.options[index];
                          return Row(
                            children: [
                              reusableText(option.name, FontWeight.w400, 16),
                              const Spacer(),
                              reusableText(
                                  "+ £${option.price}", FontWeight.w400, 16),
                              Checkbox(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4)),
                                value: false,
                                onChanged: (value) {},
                              )
                            ],
                          );
                        }),
                  )
                ],
              ),
            )
          ],
        )),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(9.0),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 3,
          child: SizedBox(
            height: 77,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
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
                          border: Border.all(color: Colors.black)),
                      child: const Padding(
                        padding: EdgeInsets.all(6.0),
                        child: Center(child: Icon(Icons.add)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: reusableText("$count", FontWeight.w400, 22),
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
                          border: Border.all(color: Colors.black)),
                      child: const Padding(
                        padding: EdgeInsets.all(6.0),
                        child: Center(child: Icon(Icons.remove)),
                      ),
                    ),
                  ),
                  const Spacer(),
                  DecoratedBox(
                    decoration: BoxDecoration(
                        color: const Color(0xffFF6347),
                        borderRadius: BorderRadius.circular(22)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.shopping_bag_outlined,
                            color: Colors.white,
                          ),
                          reusableText("Add to Basket", FontWeight.w600, 16,
                              Colors.white)
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
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
