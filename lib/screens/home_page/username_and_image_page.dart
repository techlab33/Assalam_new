import 'package:assalam/controller/profile/user_profile_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UsernameAndImagePage extends StatelessWidget {
  final UserProfileController _userProfileController = Get.put(UserProfileController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
        if (_userProfileController.isLoading) {
          return Center(child: CircularProgressIndicator(color: Colors.green));
        } else if (_userProfileController.error.isNotEmpty) {
          return Text('Error: ${_userProfileController.error}');
        } else if (_userProfileController.userProfileData == null || _userProfileController.userProfileData!.user == null) {
          return Text('No data available');
        } else {
          final userProfileData = _userProfileController.userProfileData!;
          return Padding(
            padding: const EdgeInsets.only(left: 40),
            child: Row(
              children: [
                Text(
                  'Assalamualaikum, ${userProfileData.user!.name}' ?? '',
                  style: TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.w500),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(width: 8),
                CircleAvatar(
                  radius: 18,
                  child: ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: userProfileData.user?.image ?? '',
                      height: 115,
                      width: 115,
                      fit: BoxFit.cover,
                      progressIndicatorBuilder: (context, url, progress) =>
                          CircularProgressIndicator(value: progress.progress),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      });

  }
}
