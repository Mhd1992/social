import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_application/cubit/social/social_state.dart';
import 'package:social_application/local/cache_helper.dart';
import 'package:social_application/model/message_model.dart';
import 'package:social_application/model/post_like_model.dart';
import 'package:social_application/model/post_model.dart';
import 'package:social_application/model/user_model.dart';
import 'package:social_application/screens/chats/chat_screens.dart';
import 'package:social_application/screens/feeds/feed_screens.dart';
import 'package:social_application/screens/new_post/new_post_screen.dart';
import 'package:social_application/screens/settings/settings_screens.dart';
import 'package:social_application/screens/users/user_screens.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:uuid/uuid.dart';

class SocialCubit extends Cubit<SocialState> {
  SocialCubit() : super(SocialInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);

  UserModel? userModel;

  String? imageUrl;
  String? mainImage;
  List<String> likes = [];
  List<PostLIkeModel> likedElement = [];
  final ImagePicker _picker = ImagePicker();
  final ImagePicker _pickerCover = ImagePicker();

  void getUserDate() {
    emit(SocialLoadingUserState());

    FirebaseFirestore.instance.collection('users').doc(uId).get().then((val) {
      userModel = UserModel.fromJson(val.data());
      emit(SocialGetUserState(userModel: userModel));
    }).catchError((error) {
      emit(SocialGetUserErrorState(error.toString()));
    });
  }

  void updateVerifyState(String? userId, bool isVerified) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .update({'isEmailVerifiedId': isVerified}).then((_) {
      print("Verified email updated successfully!");
    }).catchError((error) {
      print("Failed to update verified email: $error");
    });
  }

  void updatePostLikeState(String postId, bool liked) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .update({'liked': liked}).then((val) {
      print('Update Is Success');
      getAllPosts();
    }).catchError((error) {
      print('update is failed ');
    });
  }

  int currentIndex = 0;
  List<Widget> screens = [
    const FeedScreens(),
    const ChatScreens(),
    const NewPostScreen(),
    const UserScreens(),
    const SettingsScreens(),
  ];

  List<String> titles = ['New Feeds', 'Chat', 'NewPost', 'Users', 'Settings'];

  void selectBottomNav(int index) {
    if (index == 2) {
      currentIndex = 0;
      emit(AddNewPostState());
    } else {
      currentIndex = index;
      emit(ChangeBottomNaveState());
    }
  }

  File? profileImage;
  File? coverImage;
  final picker = ImagePicker();

  Future<void> getIProfileImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);

      emit(AddProfileImageSuccessState());
    } else {
      emit(AddProfileImageErrorState());
      print('no image selected');
    }
  }

  Future<void> getCoverImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(AddCoverImageSuccessState());
    } else {
      emit(AddCoverImageErrorState());
      print('no image selected');
    }
  }

  void upLoadFileImage() async {
    try {
      final ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('users')
          .child('${Uri.file(profileImage!.path).pathSegments.last}');

      await ref.putFile(profileImage!);
      final downloadUrl = await ref.getDownloadURL();

      print('-------------->>>>>>>>>>[$downloadUrl]<<<<------------');
    } catch (error) {
      print('Error uploading file: $error');
    }
  }

  Future<void> uploadCloudinaryImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path); //= File(pickedFile.path);

      emit(AddProfileImageSuccessState());
      String cloudinaryUrl =
          'https://api.cloudinary.com/v1_1/djsueu1no/image/upload';

      var request = http.MultipartRequest('POST', Uri.parse(cloudinaryUrl));
      request.fields['upload_preset'] = 'Alhammali'; // Set your upload preset
      request.files.add(
        await http.MultipartFile.fromPath('file', profileImage!.path),
      );

      var response = await request.send();
      if (response.statusCode == 200) {
        String responseBody = await response.stream.bytesToString();
        var jsonResponse = json.decode(responseBody);

        imageUrl = jsonResponse['secure_url'];
      } else {
        print('Upload failed: ${response.statusCode}');
      }
    }
  }

  Future<void> uploadCloudinaryCoverImage() async {
    final pickedCoverFile =
        await _pickerCover.pickImage(source: ImageSource.gallery);
    if (pickedCoverFile != null) {
      coverImage = File(pickedCoverFile.path); //= File(pickedFile.path);

      emit(AddCoverImageSuccessState());
      String cloudinaryUrl =
          'https://api.cloudinary.com/v1_1/djsueu1no/image/upload';

      var request = http.MultipartRequest('POST', Uri.parse(cloudinaryUrl));
      request.fields['upload_preset'] = 'Alhammali'; // Set your upload preset
      request.files.add(
        await http.MultipartFile.fromPath('file', coverImage!.path),
      );

      var response = await request.send();
      if (response.statusCode == 200) {
        String responseBody = await response.stream.bytesToString();
        var jsonResponse = json.decode(responseBody);

        mainImage = jsonResponse['secure_url'];

        print('main Image is ====>>>$mainImage');
      } else {
        print('Upload failed: ${response.statusCode}');
      }
    }
  }

  void updateUserData(
      {String? uId, String? name, String? phone, String? bio, String? email}) {
    UserModel model = UserModel(
        uId: uId,
        name: name,
        phone: phone,
        image: imageUrl,
        bio: bio,
        email: email,
        coverImage: mainImage,
        isEmailVerified: true);

    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .update(model.toMap())
        .then((value) {
      getUserDate();
    }).catchError((error) {
      print(error);
    });
  }

  void createPost(
      {required String dateTime, required String text, String? postImage}) {
    String postId = generatePostId();

    PostModel postModel = PostModel(
      name: userModel!.name,
      uId: userModel!.uId,
      text: text,
      dateTime: DateTime.now().toString(),
      image: userModel!.image,
      postImage: imageUrl ?? '',
      postId: postId,
      liked: false,
    );
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .set(postModel.toMap())
        .then((val) {
      // emit(CreatePostSuccessState(postModel));
    }).catchError((error) {
      // emit(CreatePostErrorState(message: error.toString()));
    });
  }

  String generatePostId() {
    var uuid = Uuid();
    String postId = uuid.v4();
    return postId;
  }

  final List<PostModel> posts = [];

  void getAllPosts() {
    emit(SocialLoadingUserState());

    FirebaseFirestore.instance.collection('posts').get().then((val) {
      posts.clear();
      posts.addAll(val.docs.map((e) {
        return PostModel.fromJson(e.data());
      }));
      emit(GetPostsSuccessState(postModels: posts));
    }).catchError((error) {
      emit(GetPostsErrorState(error.toString()));
    });
  }

  List<UserModel?> users = [];

  void getAllUsers() {
    emit(GetPostLoadingState());

    FirebaseFirestore.instance.collection('users').get().then((val) {
      users.addAll(
          val.docs.where((doc) => doc.data()['uId'] != userModel!.uId).map((e) {
        return UserModel.fromJson(e.data());
      }));
      emit(SocialGetAllUserState(userModel: users));
    }).catchError((error) {
      emit(GetPostsErrorState(error.toString()));
    });
  }

  String? getLatestPostId() {
    if (posts.isNotEmpty) {
      return posts.last.postId; // Return the last postId
    }
    return null; // Return null if no posts exist
  }

  void likePost(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userModel!.uId)
        .set({'postId': postId, 'like': true}).then((val) {
      FirebaseFirestore.instance
          .collection('posts')
          .doc(postId)
          .collection('likes')
          .get()
          .then((val) {
        likedElement =
            val.docs.map((e) => PostLIkeModel.fromJson(e.data())).toList();
        //  emit(LikePostSuccessState(model: likedElement));
        print('total is ${likedElement.length}');
      });

      // getLikedPost(postId);
      // emit(LikePostSuccessState());
    }).catchError((error) {
      //emit(CreatePostErrorState(message: error.toString()));
    });
  }

  void sendChatMessage(
      {required String receiverId, required String text, String? dateTime}) {
    MessageModel messageModel = MessageModel(
        senderId: userModel!.uId,
        receiverId: receiverId,
        text: text,
        dateTime: dateTime);
    //for sender
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(messageModel.toMap())
        .then((value) {
      emit(SendChatMessageSuccessState());
    }).catchError((error) {
      emit(SendChatMessageErrorState(error));
    });
// for receiver
    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(userModel!.uId)
        .collection('messages')
        .add(messageModel.toMap())
        .then((value) {
      emit(SendChatMessageSuccessState());
    }).catchError((error) {
      emit(SendChatMessageErrorState(error));
    });
  }

  List<MessageModel> messages = [];

  void getMessage({required String receiverId}) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      messages = [];
      event.docs.forEach((element) {
        messages.add(
          MessageModel.fromJson(
            element.data(),
          ),
        );
      });
      emit(GetAllChatMessageSuccessState(messageModel: messages));
    });
  }
}

/*  Future<void> _fetchSpecificImage(String publicId) async {
    String cloudinaryUrl =
        'https://api.cloudinary.com/v1_1/djsueu1no/resources/image/upload/$publicId';

    final response = await http.get(
      Uri.parse(cloudinaryUrl),
      headers: {
        'Authorization':
            'Basic ${base64Encode(utf8.encode('$apiKey:$apiSecret'))}',
      },
    );

    if (response.statusCode == 200) {
      print('AM IN 200');
      var jsonResponse = json.decode(response.body);
      String imageUrl = jsonResponse['secure_url'];
    //  setState(() {
        _imageUrls.add(imageUrl);
    //  });
    } else {
      print('Failed to fetch image: ${response.statusCode}');
    }
  }*/

/*  Future<void> _fetchImages() async {
    String cloudinaryUrl =
        'https://api.cloudinary.com/v1_1/djsueu1no/resources/image/upload';

    final response = await http.get(
      Uri.parse(cloudinaryUrl),
      headers: {
        'Authorization':
            'Basic ${base64Encode(utf8.encode('$apiKey:$apiSecret'))}',
      },
    );
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      List<dynamic> resources = jsonResponse['resources'];
     // setState(() {
        _images = resources.map((image) => ImageModel.fromJson(image)).toList();
    //  });

      */ /*
      * with out using any model
      *   setState(() {
        _images = resources
            .map((image) {
              return {
                'public_id': image['public_id'],
                'secure_url': image['secure_url'],
              };
            })
            .toList()
            .cast<Map<String, dynamic>>();
        //  .cast<String>();
      });
      * */ /*
    } else {
      print('Failed to fetch images: ${response.statusCode}');
    }
  }*/
