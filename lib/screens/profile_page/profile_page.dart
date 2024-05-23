import 'dart:developer';

import 'package:assalam/data/models/profile/user_profile_data_model.dart';
import 'package:assalam/data/services/profile/get_user_profile_data.dart';
import 'package:assalam/screens/profile_page/edit_profile.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // Data Function
  var fetchProfileData = UserProfileGetData();

  @override
  void initState() {
    fetchProfileData.fetchUserProfileData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.green,
        actions: [
          InkWell(
            onTap: () => Get.to(EditProfilePage()),
            child: Image.asset('assets/icons/edit-profile.png', height: 40, width: 40),
          ),
          SizedBox(width: 10),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: FutureBuilder<UserProfileDataModel>(
            future: fetchProfileData.fetchUserProfileData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator(color: Colors.green));
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (!snapshot.hasData || snapshot.data?.user == null) {
                return Text('No data available');
              } else {
                final UserProfileDataModel userProfileDataModel = snapshot.data!;
                return Column(
                  children: [
                    Container(
                      height: 220,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
                      ),
                      child: Column(
                        children: [
                          // Profile Image
                          Container(
                            alignment: Alignment.center,
                            height: 120,
                            width: 120,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Colors.white,
                            ),
                            child: Container(
                              alignment: Alignment.center,
                              height: 115,
                              width: 115,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Colors.green,
                              ),
                              child: ClipOval(
                                child: CachedNetworkImage(
                                  imageUrl: userProfileDataModel.user?.image ?? '',
                                  height: 115,
                                  width: 115,
                                  fit: BoxFit.cover,
                                  progressIndicatorBuilder: (context, url, progress) =>
                                      CircularProgressIndicator(value: progress.progress),
                                  errorWidget: (context, url, error) => Icon(Icons.error),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          // User Name
                          Text(
                            userProfileDataModel.user?.name ?? 'No Name',
                            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500, color: Colors.white),
                          ),
                          // User Email
                          Text(
                            userProfileDataModel.user?.email ?? 'No Email',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      child: Card(
                        elevation: 3,
                        child: Container(
                          padding: EdgeInsets.all(20),
                          height: 300,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            // color: Color.fromRGBO(234,233,219,1)
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.mobile_friendly, color: Colors.green),
                                  SizedBox(width: 20),
                                  Text(
                                    userProfileDataModel.user?.mobile ?? 'No Mobile',
                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              SizedBox(height: 15),
                              Row(
                                children: [
                                  Icon(Icons.location_on_outlined, color: Colors.green, size: 30),
                                  SizedBox(width: 20),
                                  Text(
                                    userProfileDataModel.user?.address ?? 'No Address',
                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}



