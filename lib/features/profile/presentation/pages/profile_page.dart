import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/user_collection_bloc/user_collection_bloc.dart';
import '../../../../core/widgets/profile_picture.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? profilePicture;

  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final userCollection =
        context.watch<UserCollectionBloc>().state.userCollection!;

    _nameController.value = TextEditingValue(
      text: userCollection.name!,
      selection: TextSelection.fromPosition(
        TextPosition(
            offset: FirebaseAuth.instance.currentUser!.displayName!.length),
      ),
    );
    if (userCollection.phone != null) {
      _phoneController.value = TextEditingValue(
        text: userCollection.phone!,
        selection: TextSelection.fromPosition(
          TextPosition(offset: userCollection.phone!.length),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'Profile',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
          color: Colors.black,
        ),
      ),
      body: BlocBuilder<UserCollectionBloc, UserCollectionState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 32),
                Column(
                  children: [
                    InkWell(
                      onTap: () async {
                        final pickedFile = await ImagePicker()
                            .getImage(source: ImageSource.gallery);
                        // final croppedImage = await ImageCropper.cropImage(
                        //     sourcePath: pickedFile.path,
                        //     aspectRatio: const CropAspectRatio(
                        //         ratioX: 1.0, ratioY: 1.0));
                        if (pickedFile != null) {
                          profilePicture = File(pickedFile.path);
                          setState(() {});
                        }
                      },
                      child: (profilePicture == null)
                          ? ProfilePictureWidget(
                              radius: 100,
                              url: state.userCollection!.photo,
                            )
                          : CircleAvatar(
                              radius: 100,
                              backgroundColor: Colors.transparent,
                              child: CircleAvatar(
                                radius: 100,
                                backgroundImage: FileImage(profilePicture!),
                              ),
                            ),
                    ),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              enabled: false,
                              initialValue: state.userCollection!.email,
                              decoration: const InputDecoration(
                                labelText: 'Email Address',
                              ),
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              controller: _nameController,
                              onFieldSubmitted: (_) =>
                                  FocusScope.of(context).nextFocus(),
                              validator: (String? value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your full name.';
                                }
                                return null;
                              },
                              keyboardType: TextInputType.name,
                              textInputAction: TextInputAction.next,
                              decoration: const InputDecoration(
                                labelText: 'Full Name',
                              ),
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              controller: _phoneController,
                              onFieldSubmitted: (_) =>
                                  FocusScope.of(context).unfocus(),
                              keyboardType: TextInputType.phone,
                              textInputAction: TextInputAction.done,
                              validator: (String? value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your phone number.';
                                }
                                if (!RegExp(r'^(09|\+639)\d{9}$')
                                    .hasMatch(value)) {
                                  // ignore: lines_longer_than_80_chars
                                  return 'Please enter a valid Philippine phone number';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                labelText: 'Phone Number',
                                hintText: '+639#########',
                              ),
                            ),
                            TextButton.icon(
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    if (profilePicture != null) {
                                      final user =
                                          FirebaseAuth.instance.currentUser!;

                                      final profileImageReference =
                                          FirebaseStorage.instance
                                              .ref()
                                              .child('profile/${user.uid}.jpg');
                                      final uploadTask =
                                          await profileImageReference
                                              .putFile(profilePicture!);
                                      final url = (await uploadTask.ref
                                          .getDownloadURL());

                                      context
                                          .read<UserCollectionBloc>()
                                          .add(UpdateUserCollection({
                                            'name': _nameController.text,
                                            'phone': _phoneController.text,
                                            'photo': url,
                                          }));
                                      await user.updateProfile(
                                        displayName: _nameController.text,
                                        photoURL: url.toString(),
                                      );
                                    } else {
                                      final user =
                                          FirebaseAuth.instance.currentUser!;

                                      await user.updateProfile(
                                          displayName: _nameController.text);

                                      context
                                          .read<UserCollectionBloc>()
                                          .add(UpdateUserCollection({
                                            'name': _nameController.text,
                                            'phone': _phoneController.text,
                                          }));
                                    }

                                    context
                                        .read<UserCollectionBloc>()
                                        .add(FetchUserCollection());
                                  }
                                },
                                icon: const Icon(Icons.update),
                                label: const Text('Update Profile'))
                          ],
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
