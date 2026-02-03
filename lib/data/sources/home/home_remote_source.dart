import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/providers/firebase_providers.dart';
import '../../models/auth/user_model.dart';

part 'home_remote_source.g.dart';

@Riverpod(keepAlive: true)
HomeRemoteSource homeRemoteSource(Ref ref) {
  return HomeRemoteSourceImpl(ref.watch(firebaseFirestoreProvider));
}

abstract class HomeRemoteSource {
  Stream<List<UserModel>> getUsers();
}

class HomeRemoteSourceImpl implements HomeRemoteSource {
  final FirebaseFirestore _firestore;

  HomeRemoteSourceImpl(this._firestore);

  @override
  Stream<List<UserModel>> getUsers() {
    return _firestore.collection('users').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return UserModel.fromJson(doc.data());
      }).toList();
    });
  }
}
