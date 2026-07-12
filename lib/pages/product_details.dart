import 'package:flutter/material.dart';

import 'cart.dart';
import 'cart_state.dart';
import 'favorite.dart';
import 'product.dart';


class ProductDetailsPage extends StatefulWidget {
  final ProductModel product;

  const ProductDetailsPage({super.key, required this.product});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  int selectedColorIndex = 0;
  int selectedSizeIndex = 1;

  final List<Color> colors = const [
    Colors.black,
    Colors.white,
    Colors.brown,
    Colors.grey,
  ];

  final List<String> sizes = const ['XS', 'S', 'M', 'L', 'XL'];

  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Backdrop large image
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            child: Image.asset(
              product.imagePath,
              fit: BoxFit.cover,
            ),
          ),
          // Top controls
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    iconSize: 22,
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        product.isFavorite = !product.isFavorite;
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const FavoritePage(),
                        ),
                      );
                    },
                    icon: Icon(
                      product.isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: product.isFavorite ? Colors.red : Colors.white,
                      size: 22,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Draggable info sheet
          DraggableScrollableSheet(
            initialChildSize: 0.56,
            minChildSize: 0.44,
            maxChildSize: 0.92,
            builder: (context, controller) {
              return Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                ),
                child: ListView(
                  controller: controller,
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
                  children: [
                    // handle
                    Center(
                      child: Container(
                        width: 56,
                        height: 5,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(999),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    Text(
                      product.name,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '£${product.price.toStringAsFixed(0)}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 18),

                    // Color selector
                    Row(
                      children: const [
                        Text(
                          'Color',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 38,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: colors.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 10),
                        itemBuilder: (context, index) {
                          final c = colors[index];
                          final selected = selectedColorIndex == index;
                          return GestureDetector(
                            onTap: () => setState(() => selectedColorIndex = index),
                            child: Container(
                              width: 34,
                              height: 34,
                              decoration: BoxDecoration(
                                color: c,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: selected ? Colors.black : Colors.transparent,
                                  width: 2,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Size selector
                    Row(
                      children: const [
                        Text(
                          'Size',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 10,
                      runSpacing: 8,
                      children: List.generate(sizes.length, (index) {
                        final selected = selectedSizeIndex == index;
                        return GestureDetector(
                          onTap: () => setState(() => selectedSizeIndex = index),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                            decoration: BoxDecoration(
                              color: selected ? Colors.black : Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Text(
                              sizes[index],
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: selected ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                        );
                      }),
                    ),

                    const SizedBox(height: 18),

                    // ADD TO BAG
                    SizedBox(
                      height: 52,
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            CartState.add(product);
                          });
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const CartPage(),
                            ),
                          );
                        },
                        child: const Text(
                          'ADD TO BAG',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.2,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Shipping info (simple tiles)
                    const _InfoRow(icon: Icons.local_shipping, text: 'Free shipping over £50'),
                    const SizedBox(height: 12),
                    const _InfoRow(icon: Icons.refresh, text: 'Easy returns within 30 days'),

                    const SizedBox(height: 14),

                    // Accordion sections
                    const _ExpandableTile(title: 'Product details', childText: 'Premium fabric with a clean, modern fit.'),
                    const _ExpandableTile(title: 'Brand', childText: 'Runway Collection'),
                    const _ExpandableTile(title: 'Size and Fit', childText: 'True to size. Designed for comfort and movement.'),
                    const _ExpandableTile(title: 'History', childText: 'Inspired by classic tailoring with contemporary styling.'),

                    const SizedBox(height: 16),

                    // Similar products
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'You might also like',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: 210,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _similarProducts.length,
                        itemBuilder: (context, index) {
                          final p = _similarProducts[index];
                          return Padding(
                            padding: const EdgeInsets.only(right: 12),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => ProductDetailsPage(product: p),
                                  ),
                                );
                              },
                              child: SizedBox(
                                width: 160,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: Container(
                                          color: Colors.grey.shade200,
                                          child: Stack(
                                            fit: StackFit.expand,
                                            children: [
                                              Image.asset(
                                                p.imagePath,
                                                fit: BoxFit.cover,
                                              ),
                                              Positioned(
                                                right: 8,
                                                top: 8,
                                                child: Icon(
                                                  p.isFavorite
                                                      ? Icons.favorite
                                                      : Icons.favorite_border,
                                                  color: p.isFavorite ? Colors.red : Colors.white,
                                                  size: 20,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      p.name,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      '£${p.price.toStringAsFixed(0)}',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w800,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }






  List<ProductModel> get _similarProducts {
    // Keep it deterministic and reuse existing data
    final all = <ProductModel>[]..addAll(menProducts)..addAll(kidsProducts);
    all.shuffle();
    return all.take(8).toList();
  }
}


class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const _InfoRow({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(icon, size: 18, color: Colors.black54),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ExpandableTile extends StatelessWidget {
  final String title;
  final String childText;

  const _ExpandableTile({required this.title, required this.childText});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 0),
        backgroundColor: Colors.transparent,
        collapsedBackgroundColor: Colors.transparent,
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w800,
            color: Colors.black,
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 12),
            child: Text(
              childText,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Colors.black54,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

