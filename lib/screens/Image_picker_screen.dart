import 'dart:io';
import 'package:api/api/api_response.dart';
import 'package:api/extensions/context_extension.dart';
import 'package:api/get/images_getx_controller.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
class ImagePickerScreen extends StatefulWidget {
  const ImagePickerScreen({Key? key}) : super(key: key);

  @override
  State<ImagePickerScreen> createState() => _ImagePickerScreenState();
}

class _ImagePickerScreenState extends State<ImagePickerScreen> {
  late ImagePicker _imagePicker;
  XFile? _pickedImage;
  double? _progressValue = 0 ;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _imagePicker = ImagePicker();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:const Text('Upload Image')),
      body: Column(
        children: [
          LinearProgressIndicator(
            color: Colors.green,
            minHeight: 5,
            value: _progressValue,
          ),
          Expanded(
              child:_pickedImage !=null
                  ? Image.file(File(_pickedImage!.path))
                  :IconButton(
                  onPressed: ()=>_pickImage(),
                  icon: const Icon(Icons.camera_alt_outlined , size: 60,),
                padding: EdgeInsets.zero,
              )
          ),
          ElevatedButton.icon(onPressed: (){_performUpload();}, label: const Text('Upload'),
            icon: const Icon(Icons.cloud_upload_rounded),
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity,50),
            ),
          )
        ],
      ),
    );
  }
  void  _pickImage()async{
     XFile? image = await _imagePicker.pickImage(source: ImageSource.camera);
     if(image !=null){
       setState(()=>_pickedImage = image);
     }
  }
  void _performUpload(){
    if(_checkData()){
      _uploadImage();
    }
  }
  bool _checkData(){
    if(_pickedImage !=null) {
      return true;
    }
    context.showSnackBar(message: 'Pick an Image!');
    return false;
  }
  void _uploadImage()async{
    _changeProgress();
    ApiResponse apiResponse = await ImagesGetXController.to.upload(_pickedImage!.path);
    apiResponse.success?_changeProgress(progress: 1):_changeProgress(progress: 0);
    context.showSnackBar(message: apiResponse.message , error: !apiResponse.success);
  }
  void _changeProgress({double? progress}){
    setState(()=> _progressValue = progress);
  }
}
