import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trato_inventory_management/features/inventory/bloc/inventory_bloc.dart';
import 'package:trato_inventory_management/models/category_model.dart';
import 'package:trato_inventory_management/utils/constants/colors.dart';
import 'package:trato_inventory_management/utils/constants/text_styles.dart';
import 'package:trato_inventory_management/widgets/app_textfield.dart';
import 'package:trato_inventory_management/widgets/category_grid.dart';
import 'package:trato_inventory_management/widgets/custom_button.dart';
import 'package:trato_inventory_management/widgets/popup_menu_button.dart';
import 'package:trato_inventory_management/widgets/product_tile.dart';

class InventoryPage extends StatefulWidget {
  const InventoryPage({super.key});

  @override
  State<InventoryPage> createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {
  List<String>? categoryNames;
  CustomPopupMenuController menuController = CustomPopupMenuController();
  @override
  void initState() {
    //event meant for fetching the existing categories in the database
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
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('Category deleted')));
        } else if (state is CategoriesFetchedState) {
          categoryNames = state.documentList;
        } else if (state is ProductDeletedSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('product deleted successfull')));
        }
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        child: SafeArea(
            child: Column(
          children: [
            SizedBox(
              height: size.height * .02,
            ),
            Row(
              children: [
                Text(
                  'Categories',
                  style: categoryTitle,
                ),
                SizedBox(
                  width: size.width * .09,
                ),
                CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.black,
                    child: IconButton(
                        onPressed: () {
                          print('clicked add button');
                          show_dialogue(context, bloc, categoryNames);
                        },
                        icon: const Icon(
                          Icons.add,
                          color: Colors.white,
                        ))),
              ],
            ),
            SizedBox(
              height: size.height * .02,
            ),
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
                    return const Center(child: Text('No categories available'));
                  }
                  final categories = snapshot.data!.docs;
                  return GridView.builder(
                      itemCount: categories.length,
                      scrollDirection: Axis.vertical,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 3 / 2,
                        mainAxisSpacing: 15,
                        crossAxisSpacing: 15,
                      ),
                      itemBuilder: (context, index) {
                        final categoryName = categories[index].id;
                        return GestureDetector(
                            onLongPress: () {
                              BlocProvider.of<InventoryBloc>(context).add(CategoryTileLongpress(document: categoryName));
                            },
                            child: CategoryTile(categoryname: categoryName));
                      });
                },
              ),
            ),
            SizedBox(
              height: size.height * .02,
            ),
            Row(
              children: [
                Text(
                  'Products',
                  style: categoryTitle,
                ),
                SizedBox(
                  width: size.width * .15,
                ),
                CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.black,
                    child: IconButton(
                        onPressed: () {
                          Navigator.pushNamed(context, 'add_product');
                        },
                        icon: const Icon(
                          Icons.add,
                          color: Colors.white,
                        ))),
              ],
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore
                      .instance //retrieves the available products from the database
                      .collection('UserData')
                      .doc(user.uid)
                      .collection('Products')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return const Center(
                          child: Text('Error fetching products'));
                    } else if (!snapshot.hasData ||
                        snapshot.data!.docs.isEmpty) {
                      return const Center(child: Text('No products available'));
                    }
                    final doc = snapshot.data!.docs;
                    return ListView.builder(
                        itemCount: doc.length,
                        itemBuilder: (context, index) {
                          final productData =
                              doc[index].data() as Map<String, dynamic>;
                          return ProductTile(
                              trailingWidget: CustomPopupMenuWidget(
                                controller: menuController,
                                child: Icon(Icons.more_vert_rounded),
                                document: productData,
                                menuItems: ['Edit', 'Delete'],
                              ),
                              productName: productData['productName'],
                              subtitle1:'supplier : ${productData['supplier']}',
                              subtitle2: 'suail',
                              productImage: productData['productImage']
                              );
                        });
                  }),
            ),
          ],
        )),
      ),
    );
  }
}

void show_dialogue(BuildContext context, InventoryBloc inventoryBloc,List<String>? categoryNames) {
  showDialog(
      context: context,
      builder: (context) {
        final TextEditingController categoryController =
            TextEditingController();
        final TextEditingController? descriptionControler =TextEditingController();
        return AlertDialog(
          title: const Text('Add category'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppTextfield(
                validateMode: AutovalidateMode.onUserInteraction,
                textEditingController: categoryController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'please add category name';
                  }
                  if (categoryNames != null) {
                    if (categoryNames.contains(value)) {
                      return 'Category already exist';
                    }
                  }
                  return null;
                },
                labelText: 'Category name',
                width: double.infinity,
                padding: 10,
                obscureText: false,
                fillColor: Colors.white,
              ),
              AppTextfield(
                textEditingController: descriptionControler,
                labelText: 'Description',
                width: double.infinity,
                padding: 10,
                obscureText: false,
                fillColor: Colors.white,
              ),
              CustomButton(
                onTap: () {
                  inventoryBloc.add(AddCategoryButtonClicked(CategoryModel(
                      category: categoryController.text,
                      description: descriptionControler?.text)));
                },
                height: 60,
                width: double.infinity,
                elevation: 10,
                color: AppColors.primaryColor,
                radius: 10,
                child: BlocBuilder<InventoryBloc, InventoryState>(
                  builder: (context, state) {
                    if (state is CategoryAddLoading) {
                      return const CircularProgressIndicator(
                        color: Colors.white,
                      );
                    }
                    return Text(
                      'Add category',
                      style: buttonText,
                    );
                  },
                ),
              )
            ],
          ),
        );
      });
}
