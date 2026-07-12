import 'package:flutter/material.dart';

import 'product.dart';
import 'product_details.dart';

// ================= Category Products Page =================
class CategoryProductsPage extends StatefulWidget {
  final String title;
  final List<ProductModel> products;

  const CategoryProductsPage({
    super.key,
    required this.title,
    required this.products,
  });

  @override
  State<CategoryProductsPage> createState() => _CategoryProductsPageState();
}

class _CategoryProductsPageState extends State<CategoryProductsPage> {
  int? selectedIndex;
  bool isGridView = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text(
          widget.title,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.shopping_bag_outlined,
                    color: Colors.black,
                  ),
                  onPressed: () {},
                ),
                const Positioned(
                  right: 4,
                  top: 4,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(4),
                      child: Text(
                        '6',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // ===== Sort by / Filter / View toggle =====
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildTopBarButton(
                  icon: Icons.unfold_more,
                  label: 'Sort by',
                  onTap: () {},
                ),
                Row(
                  children: [
                    _buildTopBarButton(
                      icon: Icons.tune,
                      label: 'Filter',
                      onTap: () {},
                    ),
                    const SizedBox(width: 16),
                    IconButton(
                      icon: Icon(
                        Icons.grid_view_rounded,
                        color: isGridView ? Colors.black : Colors.grey,
                      ),
                      onPressed: () {
                        setState(() => isGridView = true);
                      },
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.people_outline,
                        color: Colors.grey,
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),

          // ===== Products Grid =====
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: widget.products.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 20,
                crossAxisSpacing: 12,
                childAspectRatio: 0.62,
              ),
              itemBuilder: (context, index) {
                final product = widget.products[index];
                final isSelected = selectedIndex == index;

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ProductDetailsPage(product: product),
                      ),
                    );
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ===== Product Image =====
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(4),
                            border: isSelected
                                ? Border.all(color: Colors.blueAccent, width: 2)
                                : null,
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              Image.asset(product.imagePath, fit: BoxFit.cover),
                              if (isSelected)
                                Positioned.fill(
                                  child: CustomPaint(
                                    painter: _DashedBorderPainter(),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),

                      // ===== Name =====
                      Text(
                        product.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 4),

                      // ===== Price + Favorite =====
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '£${product.price.toStringAsFixed(0)}',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                product.isFavorite = !product.isFavorite;
                              });
                            },
                            child: Icon(
                              product.isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              size: 20,
                              color: product.isFavorite
                                  ? Colors.red
                                  : Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopBarButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon, size: 18, color: Colors.black),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

// ===== Dashed border painter =====
class _DashedBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blueAccent
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    const dashWidth = 6.0;
    const dashSpace = 4.0;
    final path = Path()..addRect(Rect.fromLTWH(0, 0, size.width, size.height));

    for (final metric in path.computeMetrics()) {
      double distance = 0;
      while (distance < metric.length) {
        canvas.drawPath(
          metric.extractPath(distance, distance + dashWidth),
          paint,
        );
        distance += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
