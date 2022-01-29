import 'package:bug_tracker/models/auth/team.dart';
import 'package:bug_tracker/providers/products_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductsList extends ConsumerWidget {
  const ProductsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.read(productProvider);
    return Container(
        decoration: BoxDecoration(
          color: Colors.pink.shade200.withOpacity(0.2),
        ),
        child: StreamBuilder<List<Team>>(
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
                  Flexible(
                      child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          child: SizedBox(
                              width: 250,
                              child: TextField(
                                cursorColor: Colors.pink.shade900,
                                decoration: InputDecoration(
                                    prefixIcon: const Icon(
                                      Icons.search,
                                      color: Colors.grey,
                                    ),
                                    focusColor: Colors.pink.shade900,
                                    prefixIconColor: Colors.grey,
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.pink.shade900),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10))),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.pink.shade900),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10))),
                                    hintText: 'Search the product'),
                              )))),
                  const Divider(height: 10),
                  Expanded(
                      child: ListView.builder(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                                title: Text(
                                  snapshot.data![index].name,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w900),
                                ),
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20.0),
                                      bottomLeft: Radius.circular(20.0)),
                                ));
                          })),
                ],
              );
            }));
  }
}
