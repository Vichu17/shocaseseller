import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shocase/Services/userManagement.dart';
import 'package:shocase/subpages/myProfile.dart';

class ProfilePic extends StatefulWidget {
  const ProfilePic({
    Key? key,
  }) : super(key: key);

  @override
  _ProfilePicState createState() => _ProfilePicState();
}

class _ProfilePicState extends State<ProfilePic> {
  String? profilePicUrl;
  File? newProfilePic;
  final _auth = FirebaseAuth.instance;
  UserManagement userManagement = new UserManagement();

  @override
  void initState() {
    super.initState();
    setState(() {
      if (_auth.currentUser!.photoURL == null) {
        profilePicUrl =
            "https://www.pngitem.com/pimgs/m/30-307416_profile-icon-png-image-free-download-searchpng-employee.png";
      } else {
        profilePicUrl = _auth.currentUser!.photoURL.toString();
      }
    });
  }

  Future getImage() async {
    var tempImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(
      () {
        newProfilePic = File(tempImage!.path);
      },
    );
    print("Image Path : " + newProfilePic!.path);
    uploadImage();
  }

  void uploadImage() async {
    var userID = _auth.currentUser!.uid.toString();
    String url;
    final Reference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('user_avatars/$userID.jpg');
    UploadTask task = firebaseStorageRef.putFile(newProfilePic!);

    task.whenComplete(() async {
      url = await firebaseStorageRef.getDownloadURL();
      print("Download URL : " + url);
      userManagement.updateProfilePic(url);
    }).catchError((onError) {
      print(onError);
    });

    setState(() {
      if (_auth.currentUser!.photoURL == null) {
        profilePicUrl =
            "https://www.pngitem.com/pimgs/m/30-307416_profile-icon-png-image-free-download-searchpng-employee.png";
      } else {
        profilePicUrl = _auth.currentUser!.photoURL.toString();
      }
    });
  }

  Widget _circleAvatar(){
    return CircleAvatar(
      backgroundImage: newProfilePic == null ? NetworkImage(profilePicUrl.toString()) : FileImage(File(newProfilePic!.path)) as ImageProvider,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 115,
      width: 115,
      child: Stack(
        fit: StackFit.expand,
        overflow: Overflow.visible,
        children: [
          _circleAvatar(),
          // CircleAvatar(
          //   backgroundImage: AssetImage("assets/Profile Image.png"),
          //   // backgroundImage: NetworkImage(profilePicUrl.toString()),
          //   // backgroundImage: NetworkImage(newProfilePic == null ? profilePicUrl.toString() : newProfilePic!.path),
          //   // backgroundImage: newProfilePic == null ? NetworkImage(profilePicUrl.toString()) : AssetImage(newProfilePic!.path),
          // ),
          Positioned(
            right: -16,
            bottom: 0,
            child: SizedBox(
              height: 46,
              width: 46,
              child: FlatButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                  side: BorderSide(color: Colors.white),
                ),
                color: Color(0xFFF5F6F9),
                onPressed: () async {
                  setState(() {
                    getImage();
                  });

                  // uploadImage();
                },
                child: SvgPicture.asset("assets/Camera Icon.svg"),
              ),
            ),
          )
        ],
      ),
    );
  }
}
