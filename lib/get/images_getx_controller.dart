
import 'package:api/api/images_api_controller.dart';
import 'package:get/get.dart';
import '../api/api_response.dart';
import '../models/student-image.dart';

class ImagesGetXController extends GetxController{
   static ImagesGetXController get to => Get.find();
  final ImagesApiController _apiController = ImagesApiController();
  RxList<StudentImage> images = <StudentImage>[].obs;
  RxBool loading = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    read();
  }

  Future<ApiResponse> upload(String path)async{
    ApiResponse<StudentImage> apiResponse = await _apiController.uploadImage(path);
    if(apiResponse.success && apiResponse.object!=null){
      images.add(apiResponse.object!);
    }
    return apiResponse;
  }

  void read ()async{
    loading.value = true;
    images.value = await _apiController.read();
    loading.value = false;
  }

  Future<ApiResponse> delete(int index)async{
    ApiResponse apiResponse = await _apiController.delete(images[index].id);
    if(apiResponse.success){
      images.removeAt(index);
    }
    return apiResponse;
  }



}