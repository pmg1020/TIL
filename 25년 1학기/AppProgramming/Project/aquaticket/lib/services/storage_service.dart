import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class StorageService {
  final _picker = ImagePicker();
  final _storage = FirebaseStorage.instance;

  // 이미지 선택 후 업로드
  Future<String?> pickAndUploadImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile == null) return null;

    final file = File(pickedFile.path);
    final fileName = const Uuid().v4(); // 고유 파일명 생성
    final ref = _storage.ref().child('uploads/$fileName.jpg');

    final uploadTask = await ref.putFile(file);
    final downloadUrl = await uploadTask.ref.getDownloadURL();

    return downloadUrl;
  }
}
