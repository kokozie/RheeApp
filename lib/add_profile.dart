import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rhee_app/model/profile.dart';
import 'package:rhee_app/services/auth.dart';
import 'package:rhee_app/services/dbhelper.dart';

import 'model/firebaseuser.dart';


class AddProfile extends StatefulWidget {
  const AddProfile({Key? key}) : super(key: key);

  @override
  State<AddProfile> createState() => _AddProfileState();
}

class _AddProfileState extends State<AddProfile> {
  var formKey = GlobalKey<FormState>();
  final nameText =  TextEditingController();
  final ageText =  TextEditingController();
  final emailText =  TextEditingController();
  final phoneText =  TextEditingController();
  final addressText =  TextEditingController();
  final hobbiesText =  TextEditingController();


  @override
  void dispose(){
    nameText.dispose();
    ageText.dispose();
    emailText.dispose();
    phoneText.dispose();
    addressText.dispose();
    hobbiesText.dispose();

    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Profile'),
        backgroundColor: Colors.brown,
      ),
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            TextFormField(
              controller: nameText,
              style: const TextStyle(fontWeight: FontWeight.bold),
              keyboardType: TextInputType.name,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Ex: Rico Rhee M. Vaguchay',
                labelText: 'Name',
              ),
              validator: (name){
                return (name == '') ? 'Please enter Name' : null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: ageText,
              keyboardType: TextInputType.number,
              style: const TextStyle(fontWeight: FontWeight.bold),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: '22',
                labelText: 'Age',

              ),
              validator: (name){
                return (name == '') ? 'Please enter Age' : null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: emailText,
              keyboardType: TextInputType.emailAddress,
              style: const TextStyle(fontWeight: FontWeight.bold),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'example@gmail.com',
                labelText: 'Email',
              ),
              validator: (name){
                return (name == '') ? 'Please enter Email' : null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: phoneText,
              keyboardType: TextInputType.number,
              style: const TextStyle(fontWeight: FontWeight.bold),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: '12345678910',
                labelText: 'Phone Number',
              ),
              validator: (name){
                return (name == '') ? 'Please enter Phone Number' : null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: addressText,
              keyboardType: TextInputType.name,
              style: const TextStyle(fontWeight: FontWeight.bold),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Cagayan de Oro City',
                labelText: 'Address',
              ),
              validator: (name){
                return (name == '') ? 'Please enter Address' : null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: hobbiesText,
              keyboardType: TextInputType.name,
              style: const TextStyle(fontWeight: FontWeight.bold),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Video Games',
                labelText: 'Hobbies',
              ),
              validator: (name){
                return (name == '') ? 'Please enter Hobbies' : null;
              },
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 50,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.brown, // Background color
                  ),
                onPressed: () async {
                  var validForm = formKey.currentState!.validate();
                  if (validForm) {
                    FirebaseUser? user = await AuthService().getCurrentUser();
                    if (user == null) {
                      // handle null user case
                      return;
                    }
                    String userId = user.uid!;
                    ProfileModel newProfile = ProfileModel(
                      name: nameText.text,
                      age: int.parse(ageText.text),
                      email: emailText.text,
                      phone: int.parse(phoneText.text),
                      address: addressText.text,
                      hobbies: hobbiesText.text,
                    );
                    DocumentReference docRef = await DatabaseHelper.instance.add(newProfile, userId);
                    newProfile = newProfile.copyWith(id: null); // set the ID of the newProfile object to null
                    Navigator.pop(context, newProfile);
                  }
                },





                child: const Text('Submit'),

              ),
            ),
          ],
        ),
      ),
    );
  }
}