import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../widgets/cuostom_appbar.dart';
import 'package:flutter/services.dart';
import 'product.dart';
import 'categories.dart';
import 'favorite.dart';
import 'cart.dart';
// عدّل المسار حسب مكان الملف عندك

// ================= Category Model =================
class CategoryModel {
  final String id;
  final String name;
  final String imagePath;

  const CategoryModel({
    required this.id,
    required this.name,
    required this.imagePath,
  });
}

final List<CategoryModel> categoriesList = [
  CategoryModel(
    id: 'women',
    name: 'Women',
    imagePath: 'assets/img/category/image (2).png',
  ),
  CategoryModel(
    id: 'men',
    name: 'Men',
    imagePath: 'assets/img/category/image.png',
  ),
  CategoryModel(
    id: 'kids',
    name: 'Kids',
    imagePath: 'assets/img/category/image (5).png',
  ),
];

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex = 0;
  int _favoriteCount = 0;

  void _toggleFavoriteAndRefresh(ProductModel product) {
    setState(() {
      product.isFavorite = !product.isFavorite;
      _favoriteCount++;
    });
  }

  late final VideoPlayerController _videoController;
  bool _videoReady = false;

  @override
  void initState() {
    super.initState();

    _videoController = VideoPlayerController.asset('assets/video/267241.mp4');

    _videoController
        .initialize()
        .then((_) {
          if (!mounted) return;

          setState(() {
            _videoReady = true;
          });

          _videoController.setLooping(true);
          _videoController.play();
        })
        .catchError((e) {
          if (mounted) {
            setState(() {
              _videoReady = false;
            });
          }
        });
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

  void _goToCategoryPage(CategoryModel category) {
    HapticFeedback.lightImpact();

    List<ProductModel> products;
    switch (category.id) {
      case 'men':
        products = menProducts;
        break;
      case 'kids':
        products = kidsProducts;
        break;
      // case 'women': products = womenProducts; break;
      default:
        products = menProducts; // مؤقتًا لحد ما تجهز الـ women
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>
            CategoryProductsPage(title: category.name, products: products),
      ),
    );
  }

  // ================= Categories Section (شكل الدوائر) =================
  Widget _buildCategoriesSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Categories',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categoriesList.length,
              itemBuilder: (context, index) {
                final category = categoriesList[index];
                return GestureDetector(
                  onTap: () => _goToCategoryPage(category),
                  behavior: HitTestBehavior.opaque,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 64,
                          height: 64,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey.shade200,
                            image: category.imagePath.isNotEmpty
                                ? DecorationImage(
                                    image: AssetImage(category.imagePath),
                                    fit: BoxFit.cover,
                                  )
                                : null,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          category.name,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHomePage() {
    return Column(
      children: [
        // Full Height Video
        Container(
          height: MediaQuery.of(context).size.height * 0.55,
          width: double.infinity,
          margin: const EdgeInsets.all(16),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(24)),
          clipBehavior: Clip.antiAlias,
          child: _videoReady
              ? Stack(
                  children: [
                    Positioned.fill(
                      child: FittedBox(
                        fit: BoxFit.cover,
                        child: SizedBox(
                          width: _videoController.value.size.width,
                          height: _videoController.value.size.height,
                          child: VideoPlayer(_videoController),
                        ),
                      ),
                    ),
                  ],
                )
              : const Center(child: CircularProgressIndicator()),
        ),
        const SizedBox(height: 8),
        _buildCategoriesSection(),
        const SizedBox(height: 12),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Runway',
        leadingIcon: 'assets/svgs/bar-chart-2.svg',
        actionIcon: 'assets/svgs/solar_bell-line-duotone.svg',
        onActionPressed: () {
          HapticFeedback.lightImpact();
        },
        onLeadingPressed: () {
          HapticFeedback.lightImpact();
        },
      ),
      body: IndexedStack(
        index: currentIndex,
        children: [
          _buildHomePage(),
          const FavoritePage(),
          const CartPage(),
          const Center(child: Text('Profile')),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            activeIcon: Icon(Icons.favorite),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_outlined),
            activeIcon: Icon(Icons.shopping_bag),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
