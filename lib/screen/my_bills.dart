import 'package:cancer_free/models/bill.dart';
import 'package:cancer_free/screen/add_bill_history.dart';
import 'package:cancer_free/utils/navigator.dart';
import 'package:cancer_free/viewmodels/app_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class UserHistories extends HookWidget {
  const UserHistories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final refresh = useState<bool>(false);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add Histories'),
          actions: [
            IconButton(
                onPressed: () {
                  navigateTo(screen: const AddBills(), context: context);
                },
                icon: const Icon(Icons.add))
          ],
        ),
        body: refresh.value
            ? const Center(child: CircularProgressIndicator())
            : FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
                future: FirebaseFirestore.instance
                    .collection('bills')
                    .where('uid', isEqualTo: AppProvider.uid)
                    .get(),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return const Center(child: CircularProgressIndicator());
                    default:
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return snapshot.data!.docs.isEmpty
                            ? const Center(child: Text('No Bill Histories'))
                            : ListView.builder(
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (_, ind) {
                                  BiilModel data = BiilModel.fromJson(
                                      snapshot.data!.docs[ind].data());
                                  return ListTile(
                                      title: Text(data.title),
                                      subtitle: Text(data.description),
                                      leading: GestureDetector(
                                          onTap: () {
                                            showDialog(
                                                context: context,
                                                builder: (_) => AlertDialog(
                                                      content: Image.network(
                                                          data.image),
                                                    ));
                                          },
                                          child: Image.network(data.image)));
                                });
                      }
                  }
                }));
  }
}
