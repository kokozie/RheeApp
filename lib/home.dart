import 'package:flutter/material.dart';
import 'package:rhee_app/add_profile.dart';
import 'package:rhee_app/model/profile.dart';
import 'package:rhee_app/profile_details.dart';
import 'package:rhee_app/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rhee_app/services/dbhelper.dart';
import 'package:rhee_app/update_profile.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);


  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();
  List profiles = <dynamic>[];

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

    final userEmail = Text(
      firebaseAuth.currentUser?.email ?? '',
      style: const TextStyle(fontSize: 18.0),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      drawer: Drawer(
        child: Container(
          color: Colors.white,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Container(
                height: 200,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/qwerty.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: const Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 16, bottom: 8),
                    child: Text(
                      'Rhee App',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ListTile(
                leading: const Icon(Icons.exit_to_app, color: Colors.brown),
                title: const Text(
                  'Logout',
                  style: TextStyle(
                    color: Colors.brown,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () async {
                  await _auth.signOut();
                },
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        title: const Text(
          'Profile Maker',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.brown,
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.info,
              color: Colors.white,
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text(
                      'App Details',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Logged In: ',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            userEmail,
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              'Version:',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '3.0.0',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              'Created by: ',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Rico Rhee M. Vaguchay',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    actions: [
                      TextButton(
                        child: const Text(
                          'Close',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },
          )
        ],
      ),
      body: Center(
        child: FutureBuilder<List<ProfileModel>>(
          future: DatabaseHelper.instance.getUserProfiles(),
          builder: (context, AsyncSnapshot<List<ProfileModel>> snapshot) {
            if (snapshot.hasData) {
              profiles = snapshot.data!;
              return ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  itemCount: profiles.length,
                  itemBuilder: (context, index) {
                    final profile = profiles[index];
                    return Dismissible(
                      key: UniqueKey(),
                      onDismissed: (direction) {
                        setState(() {
                          profiles.removeAt(index);
                          DatabaseHelper.instance.delete(profile.id);
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Profile Deleted'),
                              backgroundColor: Colors.red),
                        );
                      },
                      background: Container(color: Colors.red),
                      child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16),
                          title: Text(
                            profile.name,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            '${profile.age} years old',
                            style: const TextStyle(fontSize: 14),
                          ),
                          trailing: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.brown,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () async {
                              var updateProfile = await Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) =>
                                      UpdateProfile(updateProfile: profile)));
                              await DatabaseHelper.instance.update(
                                  updateProfile);
                              setState(() {
                                profiles[index] = updateProfile;
                              });
                            },
                            child: const Text(
                                'Edit', style: TextStyle(fontSize: 14)),
                          ),
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) =>
                                    ProfileDetails(profiles: profile)));
                          },
                        ),
                      ),
                    );
                  }
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        child: const Icon(Icons.add, color: Colors.black,),
        onPressed: () async {
          var result = await Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddProfile())
          );
          setState(() {
            profiles.add(result);
          });
        },
      ),
    );
  }
}