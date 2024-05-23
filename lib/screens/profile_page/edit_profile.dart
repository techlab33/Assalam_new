import 'package:assalam/controller/image_picker_controller.dart';
import 'package:assalam/controller/profile/profile_update_controller.dart';
import 'package:assalam/utils/helper/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  // Global key
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Profile controller
  final profileController = Get.put(ProfileUpdateController());

  @override
  Widget build(BuildContext context) {

    // Image Picker Controller
    final imagePickerController = Get.put(ImagePickerController());


    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile', style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.green,
      ),
      body: SafeArea(child: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Obx(() =>  Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Profile Picture
              GestureDetector(
                onTap: () {
                  showDialog(
                      context: Get.context!,
                      builder: (context) {
                        return AlertDialog(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10),
                                topLeft: Radius.circular(10),
                                bottomLeft: Radius.circular(10)),
                          ),
                          content: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              InkWell(
                                onTap: () {
                                  imagePickerController.imagePickerMethodGallery(ImageSource.gallery);
                                },
                                child: Container(
                                  height: 50,
                                  width: 110,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Colors.green.shade400),
                                  child: const Center(
                                    child: Text('Gallery', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black)),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              InkWell(
                                onTap: () {
                                  imagePickerController.imagePickerMethodGallery(ImageSource.camera);
                                },
                                child: Container(
                                  height: 50,
                                  width: 110,
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: Colors.green.shade400),
                                  child: const Center(
                                    child: Text('Camera', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      });
                },
                child: Stack(
                  children: [
                    Container(
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.green,
                        ),
                        child: imagePickerController.image.value.path == ''
                            ? const Icon(Icons.person_outline, size: 100)
                            : CircleAvatar(backgroundImage: FileImage(imagePickerController.image.value),
                        )),
                    const Positioned(
                      bottom: 10,
                      right: 10,
                      child: Icon(Icons.camera_alt_outlined, size: 30),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),

              // TExt Field
             Form(
               key: formKey,
               child: Column(
                 children: [
                   TextFormField(
                     controller: profileController.nameController,
                     validator: (value) => TValidator.validateEmptyText('Name', value),
                     decoration: InputDecoration(
                       border: OutlineInputBorder(),
                       hintText: 'Name',
                       label: Text('Name'),
                     ),
                   ),
                   //
                   SizedBox(height: 10),
                   TextFormField(
                     controller: profileController.phoneNumberController,
                     validator: (value) => TValidator.validateEmptyText('Phone Number', value),
                     decoration: InputDecoration(
                       border: OutlineInputBorder(),
                       hintText: 'Phone Number ',
                       label: Text('Phone Number'),
                     ),
                   ),
                   //
                   SizedBox(height: 10),
                   TextFormField(
                     controller: profileController.addressController,
                     validator: (value) => TValidator.validateEmptyText('Address', value),
                     decoration: InputDecoration(
                       border: OutlineInputBorder(),
                       hintText: 'Address ',
                       label: Text('Address'),
                     ),
                   ),

                   SizedBox(height: 40),
                   InkWell(
                     onTap: () {
                       if(formKey.currentState!.validate()) {
                         profileController.profileUpdate();
                       }
                     },
                     child: profileController.isLoading.value ? Center(child: CircularProgressIndicator(color: Colors.green)) :   Container(
                       height: 55,
                       width: MediaQuery.of(context).size.width,
                       alignment: Alignment.center,
                       decoration: BoxDecoration(
                         color: Colors.green,
                         borderRadius: BorderRadius.circular(10),
                       ),
                       child: Text('Save', style: const TextStyle(
                         fontSize: 18,
                         color: Colors.white,
                         fontWeight: FontWeight.w500,
                       ),),
                     ),
                   ),
                 ],
               ),
             ),
            ],
          ),
        ),
        ),
      )),
    );
  }
}
