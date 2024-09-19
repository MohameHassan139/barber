import 'dart:io';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'add_service_state.dart';

class AddServiceCubit extends Cubit<AddServiceState> {
  AddServiceCubit() : super(AddServiceInitial());

  String email = FirebaseAuth.instance.currentUser!.email!;
  CollectionReference barberService = FirebaseFirestore.instance
      .collection('Barbers')
      .doc(FirebaseAuth.instance.currentUser!.email)
      .collection('Services');
  final storage = FirebaseStorage.instance;
  final ImagePicker picker = ImagePicker();
  File? serviceImage;
  String? imageUrl;
  int rand = Random().nextInt(9999999);
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController timeController = TextEditingController();

  Future<void> pickServiceImage() async {
    final pickerFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickerFile != null) {
      serviceImage = File(pickerFile.path);
      emit(ImagePicked());
    } else {
      emit(ImagePickedError('No Image Selected'));
    }
  }

  Future<String?> uploadProfileImage() async {
    if (serviceImage != null) {
      emit(UploadImageLoading());
      try {
        var uploadTask = await storage
            .ref()
            .child(
                'services/$email/$rand${Uri.file(serviceImage!.path).pathSegments.last}')
            .putFile(serviceImage!);
        imageUrl = await uploadTask.ref.getDownloadURL();
        emit(UploadImageSuccess());
        return imageUrl;
      } on firebase_core.FirebaseException catch (e) {
        emit(UploadImageError(e.toString()));
      }
    }
  }

  Future<void> uploadServiceData({
    String? imageUrl,
  }) async {
    await barberService.add({
      'image': imageUrl,
      'cost': int.parse(priceController.text),
      'name': nameController.text,
      'time': int.parse(timeController.text),
      "description": descriptionController.text,
    });
  }

  bool isloading = false;
  Future<void> addService() async {
    emit(AddServiceLoading());
    isloading = true;
    try {
      String? imageUrl = await uploadProfileImage();
      await uploadServiceData(imageUrl: imageUrl);
      isloading = false;
      emit(AddServiceSuccess());
    } catch (e) {
      isloading = false;
      emit(AddServiceError(e.toString()));
    }
  }
}
