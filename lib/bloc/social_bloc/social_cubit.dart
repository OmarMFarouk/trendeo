import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trendeo/bloc/social_bloc/social_states.dart';
import 'package:trendeo/core/shared.dart';

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialState());
  static SocialCubit get(context) => BlocProvider.of(context);
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Stream? usersStream;
  Stream? postsStream;
  Stream? userData;
  TextEditingController? controller = TextEditingController();
  TextEditingController? msgController = TextEditingController();
  String imageLink = "";
  bool hasPostImage = false;
  String? profilePicture;
  bool hasProfileImage = false;
  bool isFavorite = false;

  fetchPosts() {
    postsStream = _firestore
        .collection('posts')
        .orderBy('created_at', descending: true)
        .snapshots();
  }

  fetchUsers() {
    usersStream = _firestore.collection('users').snapshots();
  }

  fetchUserData() {
    userData = _firestore
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .snapshots();
  }

  // likeChecker({required bool isFavorite, required doc}) {
  //   !isFavorite
  //       ? likePost(
  //           operation: "like",
  //           email: FirebaseAuth.instance.currentUser!.email,
  //           doc: doc)
  //       : likePost(
  //           operation: "unlike",
  //           email: FirebaseAuth.instance.currentUser!.email,
  //           doc: doc);
  // }

  likePost({required email, required bool isFavorite, required doc}) async {
    if (isFavorite == true) {
      return await _firestore.collection('posts').doc(doc).update({
        "likes": FieldValue.arrayUnion(['$email'])
      });
    } else {
      return await _firestore.collection('posts').doc(doc).update({
        "likes": FieldValue.arrayRemove(['$email'])
      });
    }
  }

  Future imgFromGallery() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      File file = File(pickedFile.path);
      final fileName = "${FirebaseAuth.instance.currentUser!.email}.png";
      final destination = 'images/$fileName';

      try {
        print(destination);

        final ref = FirebaseStorage.instance.ref(destination);
        await ref.putFile(file);
        imageLink = await FirebaseStorage.instance
            .ref()
            .child(destination)
            .getDownloadURL();
        hasPostImage = true;
        emit(SocialSuccessState());
        return imageLink;
      } catch (e) {
        print('error occured');
        print('error is $e');
      }
    }
  }

  addPost() async {
    if (imageLink != "" && controller!.text.isNotEmpty) {
      await _firestore.collection('posts').add({
        "author": SharedPref.localStorage?.getString('name'),
        "image": imageLink,
        "email": FirebaseAuth.instance.currentUser!.email,
        "likes": [],
        "body": controller!.text,
        "author_image": SharedPref.localStorage?.getString('image'),
        "created_at": "${DateTime.now()}",
      });
      controller!.clear();
      hasPostImage = false;
      imageLink = "";
    }
  }

  deletePost(doc) async {
    return await _firestore.collection('posts').doc(doc).delete();
  }

  Future imgFromGallery2() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      File file = File(pickedFile.path);
      final fileName = "${FirebaseAuth.instance.currentUser!.email}.png";
      final destination = 'avatar/$fileName';

      try {
        print(destination);

        final ref = FirebaseStorage.instance.ref(destination);
        await ref.putFile(file);
        profilePicture = await FirebaseStorage.instance
            .ref()
            .child(destination)
            .getDownloadURL();
        hasProfileImage = true;
        emit(SocialSuccessState());
        SharedPref.localStorage?.setString('image', '$profilePicture');
        return profilePicture;
      } catch (e) {
        print('error occured');
        print('error is $e');
      }
    }
  }

  changeProfilePicture() {
    print("image is $profilePicture");
    if (profilePicture != "") {
      _firestore.collection('users').doc(_auth.currentUser!.uid).update({
        "image": SharedPref.localStorage?.getString('image'),
      });
      imageLink = "";
      hasProfileImage = false;
    }
  }

  Future<void> sendMessage(String receiverId) async {
    final String currentUserId = _auth.currentUser!.uid;
    final String currentUserEmail = _auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();

    List<String> ids = [currentUserId, receiverId];
    ids.sort();
    String chatRoomId = ids.join("_");
    await _firestore
        .collection("chat_rooms")
        .doc(chatRoomId)
        .collection('messages')
        .add({
      'senderId': currentUserId,
      'senderEmail': currentUserEmail,
      'receiverId': receiverId,
      'text': msgController!.text,
      'timeStamp': timestamp
    });
    emit(SocialSuccessState());
    msgController!.clear();
  }

  Stream<QuerySnapshot> getMessages(String userId, otherUserId) {
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoomId = ids.join("_");
    return _firestore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timeStamp', descending: true)
        .snapshots();
  }
}
