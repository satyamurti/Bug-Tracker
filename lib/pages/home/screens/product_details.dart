import 'package:bug_tracker/models/bug.dart';
import 'package:bug_tracker/models/bug_details.dart';
import 'package:bug_tracker/providers/bugs_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

class ProductDetails extends ConsumerWidget {
  const ProductDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bugsprod = ref.read(bugsProvider);
    final Bug? discussion = ref.watch(discussionStateProvider) as Bug?;
    final String bugStateNotifier = ref.watch(bugStateProvider) as String;

    TextEditingController controller = TextEditingController();
    return bugStateNotifier == ""
        ? Center(child: SvgPicture.asset('assets/bug1.svg'))
        : StreamBuilder<List<Bug>>(
            stream: bugsprod.getProductList(bugStateNotifier),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.error != null) {
                return const Center(
                    child: Text(
                        'Some error occurred')); // Show an error just in case(no internet etc)
              } else {
                BugDetails bugs = getBugs(snapshot.data!);
                var data = [
                  {
                    'color': Colors.green,
                    'name': 'Raised',
                    'count': bugs.raised
                  },
                  {
                    'color': Colors.purple,
                    'name': 'Resolved',
                    'count': bugs.resolved
                  },
                  {
                    'color': Colors.red,
                    'name': 'Pending',
                    'count': bugs.pending
                  },
                ];

                return discussion != null
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                            Flexible(
                                child: Row(children: [
                              Container(
                                alignment: Alignment.topLeft,
                                padding: EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 10),
                                child: Text(discussion.name,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 30,
                                        fontWeight: FontWeight.w900)),
                              ),
                              Flexible(
                                  child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                decoration: BoxDecoration(
                                    color: discussion.status == "Raised"
                                        ? Colors.green
                                        : discussion.status == "Resolved"
                                            ? Colors.purple
                                            : Colors.red,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Text(
                                  discussion.status.toString(),
                                  style: const TextStyle(color: Colors.white),
                                ),
                              )),
                              discussion.status == "Raised"
                                  ? Expanded(
                                      child: Align(
                                          alignment: Alignment.centerRight,
                                          child: TextButton(
                                              style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        Colors.purple),
                                              ),
                                              onPressed: () async {
                                                bugsprod.resolveBug(
                                                    discussion, ref);
                                                ref
                                                    .read(resolveStateProvider
                                                        .notifier)
                                                    .value = true;
                                              },
                                              child: const Text(
                                                'Resolve',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ))))
                                  : Container()
                            ])),
                            Flexible(
                                child: Container(
                              alignment: Alignment.topLeft,
                              padding: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 10),
                              child: Text(discussion.description,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 20)),
                            )),
                            Flexible(
                                child: Container(
                                    alignment: Alignment.topLeft,
                                    padding: EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 10),
                                    child: ListView.builder(
                                        itemCount:
                                            discussion.assignees.length + 1,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return index == 0
                                              ? const Text('Maintainers: ',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20))
                                              : Text(
                                                  discussion
                                                      .maintainers[index - 1]
                                                      .name,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 20),
                                                );
                                        }))),
                            Flexible(
                                child: Container(
                                    alignment: Alignment.topLeft,
                                    padding: EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 10),
                                    child: ListView.builder(
                                        itemCount:
                                            discussion.assignees.length + 1,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return index == 0
                                              ? const Text('Assignees: ',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20))
                                              : Text(
                                                  discussion
                                                      .assignees[index - 1]
                                                      .name,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 20),
                                                );
                                        }))),
                            const Flexible(
                                child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 10),
                              child: Text('Discussion',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w900)),
                            )),
                            const Divider(height: 10),
                            Flexible(
                                flex: 5,
                                child: SingleChildScrollView(
                                    child: Column(
                                        children: discussion.discussion
                                            .map((e) => Container(
                                                  margin: EdgeInsets.symmetric(
                                                      horizontal: 24,
                                                      vertical: 7),
                                                  padding: EdgeInsets.all(16),
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Flexible(
                                                      child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                        Text(e.name,
                                                            style: TextStyle(
                                                                fontSize: 20,
                                                                color: Colors
                                                                    .black)),
                                                        SizedBox(height: 5),
                                                        Text(
                                                          e.message,
                                                          style: TextStyle(
                                                            color: Colors
                                                                .black87
                                                                .withOpacity(
                                                                    0.7),
                                                            fontSize: 16,
                                                          ),
                                                        ),
                                                        Align(
                                                            alignment: Alignment
                                                                .bottomRight,
                                                            child: Text(
                                                              e.time.toString(),
                                                              style: TextStyle(
                                                                  fontSize: 8,
                                                                  color: Colors
                                                                      .black54),
                                                            )),
                                                      ])),
                                                  decoration: BoxDecoration(
                                                      color: Colors
                                                          .pink.shade300
                                                          .withOpacity(0.1),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                ))
                                            .toList()))),
                            Flexible(
                                child: Container(
                                    margin: const EdgeInsets.all(20),
                                    child: Row(children: [
                                      Flexible(
                                        child: TextField(
                                          controller: controller,
                                          decoration: const InputDecoration(
                                              border: UnderlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(10))),
                                              hintText:
                                                  'Type Your Comment Here..'),
                                        ),
                                      ),
                                      IconButton(
                                          onPressed: () async {
                                            await bugsprod.postMessage(
                                                controller.text,
                                                discussion,
                                                ref);
                                          },
                                          icon: const Icon(Icons.send))
                                    ])))
                          ])
                    : Column(
                        children: [
                          const Flexible(
                              child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 20, horizontal: 10),
                            child: Text('Bugs',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 30,
                                    fontWeight: FontWeight.w900)),
                          )),
                          const Divider(height: 10),
                          Flexible(
                              child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: data
                                          .map(
                                            (e) => Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  CircleAvatar(
                                                    radius: 60,
                                                    child: Text(
                                                        (e['count'] as int)
                                                            .toString(),
                                                        style: const TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w900)),
                                                    backgroundColor:
                                                        e['color'] as Color,
                                                  ),
                                                  const Divider(
                                                    height: 10,
                                                  ),
                                                  Text(e['name'] as String,
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.w900)),
                                                ]),
                                          )
                                          .toList()))),
                          Expanded(
                              child: SingleChildScrollView(
                                  child: Table(
                            defaultVerticalAlignment:
                                TableCellVerticalAlignment.middle,
                            border: TableBorder.symmetric(
                                outside: BorderSide(
                                    color: Colors.grey.shade200, width: 0.5),
                                inside: BorderSide(
                                    width: 1, color: Colors.grey.shade100)),
                            children: [
                              TableRow(
                                  decoration: BoxDecoration(
                                    color:
                                        Colors.pink.shade100.withOpacity(0.1),
                                  ),
                                  children: const [
                                    Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 16),
                                        child: Center(
                                            child: Text('Bug',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w900)))),
                                    Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 16),
                                        child: Center(
                                            child: Text('Status',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w900)))),
                                    Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 16),
                                        child: Center(
                                            child: Text('Created',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w900)))),
                                    Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 16),
                                        child: Center(
                                            child: Text('Due',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w900))))
                                  ]),
                              ...bugs.bugs.map((e) {
                                return TableRow(
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.1),
                                    ),
                                    children: [
                                      Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 20),
                                          child: Center(
                                              child: InkWell(
                                                  onTap: () => ref
                                                      .read(
                                                          discussionStateProvider
                                                              .notifier)
                                                      .value = e,
                                                  child: Text(
                                                    e.name,
                                                  )))),
                                      Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 20),
                                          child: Center(
                                              child: Container(
                                            decoration: BoxDecoration(
                                                color: e.status == "Raised"
                                                    ? Colors.green
                                                    : e.status == "Resolved"
                                                        ? Colors.purple
                                                        : Colors.red,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            padding: const EdgeInsets.all(8),
                                            child: Text(
                                              e.status.toString(),
                                              style: const TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ))),
                                      Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 20),
                                          child: Center(
                                              child: Text(e.created
                                                  .toString()
                                                  .split(" ")[0]))),
                                      Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 20),
                                          child: Center(
                                              child: Text(e.due
                                                  .toString()
                                                  .split(" ")[0])))
                                    ]);
                              }).toList()
                            ],
                          )))
                        ],
                      );
              }
            });
  }
}
