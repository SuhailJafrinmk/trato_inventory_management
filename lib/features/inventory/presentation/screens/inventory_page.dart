import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trato_inventory_management/features/addproduct/presentation/add_product.dart';
import 'package:trato_inventory_management/features/category/presentation/category_product_page.dart';
import 'package:trato_inventory_management/features/inventory/bloc/inventory_bloc.dart';
import 'package:trato_inventory_management/features/inventory/presentation/dialogues/add_category_dialogue.dart';
import 'package:trato_inventory_management/features/inventory/presentation/dialogues/delete_category_modal.dart';
import 'package:trato_inventory_management/features/inventory/presentation/dialogues/delete_product_modal.dart';
import 'package:trato_inventory_management/features/product_details/presentation/product_details.dart';
import 'package:trato_inventory_management/utils/constants/text_styles.dart';
import 'package:trato_inventory_management/widgets/category_grid.dart';
import 'package:trato_inventory_management/widgets/product_tile.dart';

class InventoryPage extends StatefulWidget {
  const InventoryPage({super.key});

  @override
  State<InventoryPage> createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {
  List<String>? categoryNames;

  @override
  void initState() {
    // Fetching the existing categories in the database
    BlocProvider.of<InventoryBloc>(context).add(FetchCategoriesEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bloc = BlocProvider.of<InventoryBloc>(context);
    final user = FirebaseAuth.instance.currentUser;
    
    return BlocListener<InventoryBloc, InventoryState>(
      listener: (context, state) {
        if (state is CategoryAddedSuccess) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Category added successfully')));
        } else if (state is CategoryAddedError) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to add category')));
        } else if (state is CategoryDeleted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Category deleted')));
        } else if (state is CategoriesFetchedState) {
          categoryNames = state.documentList;
        } else if (state is ProductDeletedSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Product deleted successfully')));
        }
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: size.height * .02),
                Row(
                  children: [
                    Text('Categories', style: categoryTitle),
                    SizedBox(width: size.width * .09),
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.black,
                      child: IconButton(
                        onPressed: () {
                          showDialogue(context, bloc, categoryNames);
                        },
                        icon: const Icon(Icons.add, color: Colors.white),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: size.height * .02),
                SizedBox(
                  height: size.height * .3,
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('UserData')
                        .doc(user!.uid)
                        .collection('Category')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return const Center(child: Text('Error fetching products'));
                      } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('No categories available'),
                              Text('Please click the Plus button to add a category'),
                              Text('Hold the category tile to delete the category')
                            ],
                          ),
                        );
                      }
                      final categories = snapshot.data!.docs;
                      return GridView.builder(
                        itemCount: categories.length,
                        scrollDirection: Axis.vertical,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 3 / 2,
                          mainAxisSpacing: 15,
                          crossAxisSpacing: 15,
                        ),
                        itemBuilder: (context, index) {
                          final categoryName = categories[index].id;
                          return GestureDetector(
                            onLongPress: () {
                              deleteCategory(context, categoryName);
                            },
                            child: CategoryTile(
                              categoryname: categoryName,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CategoryProductPage(
                                      categoryName: categoryName,
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                SizedBox(height: size.height * .02),
                Row(
                  children: [
                    Text('Products', style: categoryTitle),
                    SizedBox(width: size.width * .15),
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.black,
                      child: IconButton(
                        onPressed: () {
                          Navigator.pushNamed(context, 'add_product');
                        },
                        icon: const Icon(Icons.add, color: Colors.white),
                      ),
                    ),
                  ],
                ),
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('UserData')
                      .doc(user.uid)
                      .collection('Products')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return const Center(child: Text('Error fetching products'));
                    } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return const Center(child: Text('No products available'));
                    }
                    final doc = snapshot.data!.docs;
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: doc.length,
                      itemBuilder: (context, index) {
                        final productData = doc[index].data() as Map<String, dynamic>;
                        return ProductTile(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductDetails(
                                productData: productData,
                              ),
                            ),
                          ),
                          trailingWidget: PopupMenuButton(
                            itemBuilder: (context) {
                              return [
                                PopupMenuItem(
                                  child: const Text('Edit'),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => AddProduct(
                                          document: productData,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                PopupMenuItem(
                                  child: const Text('Delete'),
                                  onTap: () {
                                    deleteProduct(context, productData);
                                  },
                                ),
                              ];
                            },
                          ),
                          productName: productData['productName'],
                          subtitle1: 'Supplier: ${productData['supplier']}',
                          subtitle2: 'Price: ${productData['sellingPrice']}',
                          productImage: productData['productImage'],
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

