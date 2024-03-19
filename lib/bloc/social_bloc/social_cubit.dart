import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trendeo/bloc/social_bloc/social_states.dart';

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialState());
  static SocialCubit get(context) => BlocProvider.of(context);

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Stream? usersStream;
  Stream? postsStream;
  Stream? userData;

  fetchPosts() {
    postsStream = _firestore.collection('posts').snapshots();
  }

  fetchUsers() {
    usersStream = _firestore.collection('users').snapshots();
  }

  fetchUserData(doc) {
    userData = _firestore.collection('users').doc('$doc').snapshots();
  }

  likeChecker({required bool isFavorite, required cubit}) {
    !isFavorite
        ? cubit.likePost(
            operation: "like", email: FirebaseAuth.instance.currentUser!.email)
        : cubit.likePost(
            operation: "unlike",
            email: FirebaseAuth.instance.currentUser!.email);
  }

  likePost({required email, required operation}) async {
    if (operation == "like") {
      return await _firestore
          .collection('posts')
          .doc('ep45USrhYn871abEJFvy')
          .update({
        "likes": FieldValue.arrayUnion(['$email'])
      });
    } else {
      return await _firestore
          .collection('posts')
          .doc('ep45USrhYn871abEJFvy')
          .update({
        "likes": FieldValue.arrayRemove(['$email'])
      });
    }
  }
}
