import 'package:assalam/data/models/profile/user_profile_data_model.dart';
import 'package:assalam/data/services/profile/get_user_profile_data.dart';
import 'package:get/get.dart';

class UserProfileController extends GetxController {
  Rx<UserProfileDataModel?> _userProfileData = Rx<UserProfileDataModel?>(null);
  RxBool _isLoading = RxBool(false);
  RxString _error = RxString('');

  UserProfileDataModel? get userProfileData => _userProfileData.value;
  bool get isLoading => _isLoading.value;
  String get error => _error.value;

  var fetchProfileData = UserProfileGetData();

  @override
  void onInit() {
    super.onInit();
    fetchUserProfileData();
  }

  Future<void> fetchUserProfileData() async {
    _isLoading.value = true;
    _error.value = '';

    try {
      _userProfileData.value = await fetchProfileData.fetchUserProfileData();
    } catch (e) {
      _error.value = e.toString();
    } finally {
      _isLoading.value = false;
    }
  }
}
