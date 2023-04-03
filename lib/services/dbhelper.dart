import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rhee_app/model/profile.dart';

import '../model/firebaseuser.dart';
import 'auth.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  final CollectionReference _profilesCollection = FirebaseFirestore.instance.collection('profiles');

  DatabaseHelper._privateConstructor();


  Future<List<ProfileModel>> getProfiles(String userId) async {
    QuerySnapshot querySnapshot = await _profilesCollection
        .where('user_id', isEqualTo: userId)
        .orderBy('__name__')
        .get();
    List<ProfileModel> profileList = [];

    for (var document in querySnapshot.docs) {
      Map<String, dynamic>? data = document.data() as Map<String, dynamic>?;

      if (data != null) {
        ProfileModel profile = ProfileModel.fromMap(data);
        profile.id = document.id; // set the ID of the profile model
        profileList.add(profile);
      }
    }

    return profileList;
  }

  Future<List<ProfileModel>> getUserProfiles() async {
    // Get the current user
    FirebaseUser? user = await AuthService().getCurrentUser();

    // If the user is not logged in, return an empty list
    if (user == null) {
      return [];
    }

    // Get the user's profiles
    List<ProfileModel> profiles = await getProfiles(user.uid!);

    return profiles;
  }



  Future<DocumentReference> add(ProfileModel profile, String userId) async {
    // Add the user ID to the profile data
    Map<String, dynamic> data = profile.toJson();
    data['user_id'] = userId;

    // Add the profile to Firestore
    DocumentReference docRef = await _profilesCollection.add(data);

    // Return the document reference
    return docRef;
  }


  Future<void> delete(String id) async {
    await _profilesCollection.doc(id).delete();
  }

  Future<int> update(ProfileModel profile) async {
    final snapshot = await _profilesCollection.doc(profile.id!).get();

    if (snapshot.exists) {
      await _profilesCollection.doc(profile.id!).update(profile.toMap());
      return 1;
    } else {
      return 0;
    }
  }
}
