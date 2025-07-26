import 'package:get/get.dart';
import 'package:prettyrini/core/const/image_path.dart';

class AvatarController extends GetxController {
  // Selected avatar index (-1 means no selection)
  RxInt selectedAvatarIndex = (-1).obs;

  // List of avatar paths
  final List<String> avatarPaths = [
    ImagePath.av1,
    ImagePath.av2,
    ImagePath.av3,
    ImagePath.av4,
  ];

  // Select avatar method
  void selectAvatar(int index) {
    selectedAvatarIndex.value = index;
  }

  // Check if avatar is selected
  bool isAvatarSelected(int index) {
    return selectedAvatarIndex.value == index;
  }

  // Check if any avatar is selected
  bool get hasSelectedAvatar => selectedAvatarIndex.value != -1;

  // Get selected avatar path
  String? get selectedAvatarPath {
    if (selectedAvatarIndex.value == -1) return null;
    return avatarPaths[selectedAvatarIndex.value];
  }

  // Continue with selected avatar
  void continueWithAvatar() {
    if (hasSelectedAvatar) {
      // Handle navigation or save selected avatar
      print('Selected avatar: ${selectedAvatarPath}');
      // Add your navigation logic here
      // Get.toNamed('/next-screen');
    }
  }
}
