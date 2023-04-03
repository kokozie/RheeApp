import 'package:flutter/material.dart';

class ProfileDetails extends StatefulWidget {
  final dynamic profiles;
  const ProfileDetails({required this.profiles, Key? key}) : super(key: key);

  @override
  State<ProfileDetails> createState() => _ProfileDetailsState();
}

class _ProfileDetailsState extends State<ProfileDetails> {
  Widget rowItem(String title, dynamic value) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: Colors.grey.withOpacity(0.3), width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Flexible(
              child: Text(
                value.toString(),
                textAlign: TextAlign.justify,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: const Text('Profile'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        children: [
          rowItem("Name:", widget.profiles.name),
          rowItem("Age:", widget.profiles.age),
          rowItem("Email:", widget.profiles.email),
          rowItem("Phone Number:", widget.profiles.phone),
          rowItem("Address:", widget.profiles.address),
          rowItem("Hobbies:", widget.profiles.hobbies),
        ],
      ),
    );
  }
}
