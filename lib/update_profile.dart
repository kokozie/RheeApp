import 'package:flutter/material.dart';
import 'package:rhee_app/model/profile.dart';



class UpdateProfile extends StatefulWidget {
  final ProfileModel updateProfile;
  const UpdateProfile({Key? key,required this.updateProfile}) : super(key: key);

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {

  var formKey = GlobalKey<FormState>();
  late final nameText =  TextEditingController(text: widget.updateProfile.name);
  late final ageText =  TextEditingController(text: widget.updateProfile.age.toString());
  late final emailText =  TextEditingController(text: widget.updateProfile.email);
  late final phoneText =  TextEditingController(text: widget.updateProfile.phone.toString());
  late final addressText =  TextEditingController(text: widget.updateProfile.address);
  late final hobbiesText =  TextEditingController(text: widget.updateProfile.hobbies);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: const Text('Update Profile'),
      ),
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const SizedBox(height: 20),
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
                onPressed: () async{
                  var validForm = formKey.currentState!.validate();
                  if (validForm) {
                    ProfileModel newProfile = ProfileModel(
                        id: widget.updateProfile.id,
                        name: nameText.text,
                        age: int.parse(ageText.text),
                        email: emailText.text,
                        phone: int.parse(phoneText.text),
                        address: addressText.text,
                        hobbies: hobbiesText.text);
                    Navigator.pop(context,newProfile);
                  }},
                child: const Text('Update'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}