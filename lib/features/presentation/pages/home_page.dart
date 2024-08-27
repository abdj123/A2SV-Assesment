import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:groceries_app/features/presentation/widgets/shimmer_effect.dart';

import '../../domain/entities/product_entity.dart';
import '../bloc/product_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    final productBloc = BlocProvider.of<ProductBloc>(context);

    productBloc.add(GetAllProductEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(22)),
                child: const SizedBox(
                  height: 42,
                  width: 42,
                )),
            Row(
              children: [
                Image.asset("assets/Food Category.png"),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: reusableText("Burger", FontWeight.w600, 22),
                )
              ],
            ),
            const SizedBox()
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22.0),
          child: Column(
            children: [
              Container(
                height: 50,
                width: MediaQuery.sizeOf(context).width,
                margin:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                padding: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(13),
                ),
                child: const Center(
                  child: TextField(
                    decoration: InputDecoration(
                      fillColor: Colors.black,
                      hintText: "Search ",
                      hintStyle: TextStyle(color: Color(0xffC1C1C1)),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 16,
                      ),
                      isDense: true,
                      prefixIcon: Icon(
                        Icons.search_rounded,
                        size: 25,
                        color: Colors.grey,
                      ),
                      suffixIcon: Icon(
                        CupertinoIcons.slider_horizontal_3,
                        size: 24,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              BlocConsumer<ProductBloc, ProductState>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (state is GetAllProductState) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisExtent: 228,
                          crossAxisSpacing: 22.0,
                          mainAxisSpacing: 20.0,
                          childAspectRatio: 0.8,
                        ),
                        itemCount: state.allProducts.length,
                        itemBuilder: (context, index) {
                          final product = state.allProducts[index];
                          final discount = product.price - product.discount;

                          return GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, '/detail_page',
                                  arguments: ProductEntity(
                                      id: product.id,
                                      title: product.title,
                                      description: product.description,
                                      imageUrl: product.imageUrl,
                                      rating: product.rating,
                                      price: product.price,
                                      discount: product.discount,
                                      options: product.options));
                            },
                            child: Stack(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.shade400,
                                        blurRadius: 0.5,
                                        offset: const Offset(0, 3.6),
                                      ),
                                    ],
                                    color: const Color(0xffF8F8F8),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Align(
                                        alignment: Alignment.topCenter,
                                        child: ClipRRect(
                                          borderRadius:
                                              const BorderRadius.vertical(
                                                  top: Radius.circular(15)),
                                          child: FadeInImage(
                                            placeholderFit: BoxFit.fill,
                                            height: 120,
                                            fit: BoxFit.cover,
                                            width: double.infinity,
                                            placeholder: const AssetImage(
                                                "assets/Image Burger (1).png"),
                                            image: NetworkImage(
                                              product.imageUrl,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10.0, bottom: 2),
                                              child: Text(
                                                product.title,
                                                maxLines: 2,
                                                style: const TextStyle(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  fontSize: 15,
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                const Icon(
                                                    Icons.star_rate_rounded,
                                                    color: Color(0xffFFC700),
                                                    size: 24),
                                                reusableText(
                                                  product.rating.toString(),
                                                  FontWeight.w600,
                                                  16,
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 6, top: 8),
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Row(
                                                  children: [
                                                    Visibility(
                                                      visible: discount != 0,
                                                      child: Text(
                                                        "£ ${product.discount + product.price} ",
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 20,
                                                            color: Color(
                                                                0xff989DA3),
                                                            decoration:
                                                                TextDecoration
                                                                    .lineThrough),
                                                      ),
                                                    ),
                                                    Text(
                                                      "£ ${product.price} ",
                                                      style: const TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color:
                                                            Color(0xffFF6347),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 8.0, right: 6),
                                  child: Align(
                                    alignment: Alignment.topRight,
                                    child: DecoratedBox(
                                      decoration: const BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle),
                                      child: IconButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          icon: const Icon(
                                            Icons.favorite_border_rounded,
                                            color: Colors.red,
                                          )),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  }

                  if (state is LoadingState) {
                    return const ShimmerEffect();
                  } else {
                    return Center(
                      child: reusableText(
                          "No Product Found!!", FontWeight.w600, 18),
                    );
                  }
                },
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
