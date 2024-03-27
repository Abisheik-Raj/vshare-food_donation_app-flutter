import "dart:ffi";
import "dart:typed_data";

import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:firebase_core/firebase_core.dart";
import "package:firebase_storage/firebase_storage.dart";
import "package:flutter/material.dart";

final FirebaseStorage _storage = FirebaseStorage.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class StoreData {
  Future<String> uploadImageToStorage(String childName, Uint8List file) async {
    Reference ref = _storage.ref().child(childName);
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<String> saveData(
      {required String name,
      required String bio,
      required Uint8List file}) async {
    String resp = "Some Error Occurred";
    try {
      String imageUrl = await uploadImageToStorage("image", file);
      await _firestore.collection("images").add({
        "name": name,
        "bio": bio,
        "imageUrl": imageUrl,
      });

      resp = "Success";
    } catch (err) {
      resp = err.toString();
    }
    return resp;
  }
}
