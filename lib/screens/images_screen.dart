import 'package:api/api/api_response.dart';
import 'package:api/extensions/context_extension.dart';
import 'package:api/get/images_getx_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
class ImagesScreen extends StatelessWidget {
  const ImagesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Images'),
      actions: [
        IconButton(onPressed: (){
          Navigator.pushNamed(context, '/image_picker');
        }, icon: const Icon(Icons.camera))
      ],),
      body: GetX <ImagesGetXController>(
        init:  ImagesGetXController(),
        global:  true,
        builder: (ImagesGetXController controller){
          if(controller.loading.isTrue){
            return const Center(child: CircularProgressIndicator(),);
          }else if(controller.images.isNotEmpty){
            return GridView.builder(
                scrollDirection: Axis.vertical,
                itemCount: controller.images.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10 ,
                    mainAxisSpacing: 10
                ),
                itemBuilder: (context, index){
                  return Card(
                    clipBehavior: Clip.antiAlias,
                    elevation: 5,
                    child: Stack(
                      children: [
                        Image.network(controller.images[index].imageUrl,
                        fit: BoxFit.cover,
                          height: double.infinity,
                          width: double.infinity,

                        ),
                        Align(
                          alignment:  AlignmentDirectional.bottomEnd,
                          child: Container(
                            padding: const EdgeInsetsDirectional.only(start: 10),
                            height: 50,
                            color: Colors.black45,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(controller.images[index].image , overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.poppins(color: Colors.white),
                                  ),
                                ),
                                IconButton(onPressed: ()=>_deleteImage(context, index),
                                    icon: const Icon(Icons.delete , color: Colors.red,))
                              ],
                            ),

                          ),
                        )
                      ],
                    ),
                  );
                });
          }else {
            return Center(child: Text('NO IMAGES' , style:  GoogleFonts.poppins(
          fontWeight: FontWeight.bold,
          fontSize: 30
          ),) ,);
          }
        },
      )
    );
  }
  Future<void> _deleteImage(BuildContext context ,int index)async{
    ApiResponse apiResponse = await ImagesGetXController.to.delete(index);
    context.showSnackBar(message: apiResponse.message , error: !apiResponse.success);
  }
}
