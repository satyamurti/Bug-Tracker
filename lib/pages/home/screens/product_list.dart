import 'package:bug_tracker/models/auth/product.dart';
import 'package:bug_tracker/providers/bugs_provider.dart';
import 'package:bug_tracker/providers/products_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductsList extends ConsumerWidget {
  const ProductsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.read(productProvider);
    final int bugIndexNotifier = ref.watch(bugIndexProvider) as int;

    return Container(
        decoration: BoxDecoration(color: Colors.pink.shade100.withOpacity(0.5)),
        child: StreamBuilder<List<Product>>(
            stream: products.getUserList(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.error != null) {
                return const Center(
                    child: Text(
                        'Some error occurred')); // Show an error just in case(no internet etc)
              }

              return Column(
                children: [
                  const Flexible(
                      child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 16, horizontal: 10),
                          child: SizedBox(
                            width: 250,
                            child: Text('PROJECTS',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.black)),
                            // child: TextField(
                            //   cursorColor: Colors.pink.shade900,
                            //   decoration: InputDecoration(
                            //       prefixIcon: const Icon(
                            //         Icons.search,
                            //         color: Colors.grey,
                            //       ),
                            //       focusColor: Colors.pink.shade900,
                            //       prefixIconColor: Colors.grey,
                            //       focusedBorder: OutlineInputBorder(
                            //           borderSide: BorderSide(
                            //               color: Colors.pink.shade900),
                            //           borderRadius: const BorderRadius.all(
                            //               Radius.circular(10))),
                            //       border: OutlineInputBorder(
                            //           borderSide: BorderSide(
                            //               color: Colors.pink.shade900),
                            //           borderRadius: const BorderRadius.all(
                            //               Radius.circular(10))),
                            //       hintText: 'Search the product'),
                            // )
                          ))),
                  const Divider(height: 10),
                  Expanded(
                      child: ListView.builder(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                                onTap: () {
                                  ref.read(bugStateProvider.notifier).value =
                                      snapshot.data![index].id;
                                  ref.read(bugIndexProvider.notifier).value =
                                      index;
                                },
                                tileColor: bugIndexNotifier == index
                                    ? Colors.pink.shade200
                                    : null,
                                title: Text(
                                  snapshot.data![index].name,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w900),
                                ),
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(20.0),
                                      bottomRight: Radius.circular(20.0)),
                                ));
                          })),
                ],
              );
            }));
  }
}
