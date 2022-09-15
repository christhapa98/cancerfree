// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'dart:io';

import 'package:cancer_free/utils/toast.dart';
import 'package:cancer_free/viewmodels/app_provider.dart';
import 'package:cancer_free/widgets/buttonsWidgets/button_widget.dart';
import 'package:cancer_free/widgets/formComponents/text_field_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:image_picker/image_picker.dart';

class AddBills extends HookWidget {
  const AddBills({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final description = useTextEditingController();
    final title = useTextEditingController();
    final image = useState<File?>(null);
    final loading = useState<bool>(false);

    void uploadImage() {
      loading.value = true;
      if (image.value != null &&
          title.text.isNotEmpty &&
          description.text.isNotEmpty) {
        String imageFileName = DateTime.now().microsecondsSinceEpoch.toString();
        final Reference storageReference =
            FirebaseStorage.instance.ref().child("Images").child(imageFileName);
        final UploadTask uploadTask = storageReference.putFile(image.value!);
        uploadTask.then((TaskSnapshot taskSnapshot) {
          taskSnapshot.ref.getDownloadURL().then((imageUrl) {
            FirebaseFirestore.instance
                .collection('bills')
                .add({
                  "image": imageUrl,
                  "uid": AppProvider.uid,
                  "description": description.text,
                  "title": title.text
                })
                .then((value) => {
                      toast('Success', context, taskSuccess: true),
                      loading.value = false
                    })
                .catchError((e) {
                  toast('Error', context, taskSuccess: true);
                  loading.value = false;
                });
          }).catchError((error) {
            loading.value = false;
          });
        });
      }
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text('Add Bill Histories'),
        ),
        body: ListView(padding: const EdgeInsets.all(15.0), children: [
          const SizedBox(height: 25),
          TextFormFieldWidget(controller: title, hintText: 'Title'),
          TextFormFieldWidget(
              controller: description,
              hintText: 'Desctiption'),
          const SizedBox(height: 25),
          ButtonWidget(
              title: 'Add Image From Camera',
              onPressed: () {
                ImagePicker.platform
                    .pickImage(source: ImageSource.camera)
                    .then((value) => image.value = File(value!.path));
              }),
          const SizedBox(height: 25),
          ButtonWidget(
              title: 'Add Image From Gallery',
              onPressed: () {
                ImagePicker.platform
                    .pickImage(source: ImageSource.gallery)
                    .then((value) => image.value = File(value!.path));
              }),
          if (image.value != null)
            TextButton.icon(
                onPressed: () {
                  image.value = null;
                },
                icon: const Icon(Icons.remove),
                label: const Text('Remove')),
          if (image.value != null) Image.file(image.value!),
          const SizedBox(height: 25),
          loading.value
              ? const Center(child: CircularProgressIndicator())
              : ButtonWidget(
                  title: 'Add',
                  onPressed: () {
                    uploadImage();
                  }),
          const SizedBox(height: 25)
        ]));
  }
}
