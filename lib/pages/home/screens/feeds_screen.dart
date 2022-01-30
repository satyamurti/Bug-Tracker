import 'package:bug_tracker/models/bug.dart';
import 'package:bug_tracker/providers/bugs_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

class FeedsScreen extends ConsumerWidget {
  const FeedsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bugsprod = ref.read(bugsProvider);
    return StreamBuilder<List<Bug>>(
        stream: bugsprod.getResolvedBugs(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.error != null) {
            return const Center(
                child: Text(
                    'Some error occurred')); // Show an error just in case(no internet etc)
          } else {
            return Column(children: [
              SizedBox(
                height: 5,
              ),
              Flexible(child: SvgPicture.asset('assets/bug2.svg')),
              Flexible(
                  child: Text("Resolved Bugs",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.bold))),
              Expanded(
                  child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 7),
                          padding: const EdgeInsets.all(16),
                          alignment: Alignment.centerLeft,
                          child: Flexible(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                Text(snapshot.data![index].name,
                                    style: const TextStyle(
                                        fontSize: 20, color: Colors.black)),
                                const SizedBox(height: 5),
                                Text(
                                  snapshot.data![index].description,
                                  style: TextStyle(
                                    color: Colors.black87.withOpacity(0.7),
                                    fontSize: 16,
                                  ),
                                ),
                                Align(
                                    alignment: Alignment.bottomRight,
                                    child: TextButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.purple),
                                      ),
                                      onPressed: () {},
                                      child: Text(snapshot.data![index].status,
                                          style: const TextStyle(
                                              fontSize: 8,
                                              color: Colors.white)),
                                    )),
                              ])),
                          decoration: BoxDecoration(
                              color: Colors.pink.shade300.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10)),
                        );
                      }))
            ]);
          }
        });
  }
}
