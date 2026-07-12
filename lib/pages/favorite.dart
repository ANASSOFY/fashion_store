import 'package:flutter/material.dart';

import 'product.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    final allProducts = <ProductModel>[]
      ..addAll(menProducts)
      ..addAll(kidsProducts);

    final favorites = allProducts.where((p) => p.isFavorite).toList();

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
        title: const Text(
          'Favorite',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: favorites.isEmpty
          ? const Center(
              child: Text(
                'No favorites yet',
                style: TextStyle(color: Colors.black54),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(16),
              child: GridView.builder(
                itemCount: favorites.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 12,
                  childAspectRatio: 0.62,
                ),
                itemBuilder: (context, index) {
                  final product = favorites[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                            ),
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                Image.asset(
                                  product.imagePath,
                                  fit: BoxFit.cover,
                                ),
                                Positioned(
                                  right: 8,
                                  top: 8,
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        product.isFavorite = false;
                                      });
                                    },
                                    child: const Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        product.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 6),
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
                          const SizedBox.shrink(),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
    );
  }
}
