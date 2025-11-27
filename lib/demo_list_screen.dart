import 'package:flutter/material.dart';
import 'package:smartui_components/list_view_handler/custom_list_view.dart';

class DemoListScreen extends StatefulWidget {
  const DemoListScreen({super.key});

  @override
  State<DemoListScreen> createState() => _DemoListScreenState();
}

class _DemoListScreenState extends State<DemoListScreen> {
  List<String> dataList = List.generate(20, (index) => "Item $index");
  bool isLoadingMore = false;

  Future<void> loadMoreData() async {
    if (isLoadingMore) return;

    setState(() => isLoadingMore = true);

    await Future.delayed(const Duration(seconds: 2));

    final newItems =
    List.generate(10, (index) => "New Item ${dataList.length + index}");

    setState(() {
      dataList.addAll(newItems);
      isLoadingMore = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("CustomListView Example")),
       body: CustomListView(
        itemCount: dataList.length,
        isLoadingMore: isLoadingMore,
        itemBuilder: (context, index) => ListTile(
          title: Text(dataList[index]),
        ),

        onLoadMore: loadMoreData,

        // Optional
        separatorBuilder: (context, index) => const Divider(),
        padding: const EdgeInsets.all(8),
      ),
    );
  }
}
