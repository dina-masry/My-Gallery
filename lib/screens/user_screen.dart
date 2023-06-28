import 'package:api/api/api_response.dart';
import 'package:api/api/auth_api_controller.dart';
import 'package:api/api/users_api_controller.dart';
import 'package:api/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/users.dart';
class UserScreen extends StatelessWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User'),
        actions: [
          IconButton(onPressed: ()async{
           ApiResponse apiResponse = await AuthApiController().logout();
           context.showSnackBar(message: apiResponse.message , error: !apiResponse.success);
           if(apiResponse.success){
             Navigator.pushReplacementNamed(context, '/login_screen');
           }
          },
              icon: const Icon(Icons.logout)),
          IconButton(onPressed: (){
            Navigator.pushNamed(context, '/images_screen');
          },
              icon: const Icon(Icons.image))
        ],
      ),
      body: FutureBuilder<List<User>>(
        future: UsersApiController().getUsers(),
        builder: (context , snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator(),);
          }
          else if(snapshot.hasData && snapshot.data!.isNotEmpty){
            return ListView.builder(
              itemCount: snapshot.data!.length,
                itemBuilder: (context, index){
                  return ListTile(
                    leading: CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage(snapshot.data![index].image),
                    ),
                    title: Text(snapshot.data![index].firstName),
                    subtitle: Text(snapshot.data![index].email),
                  );
                });
          }else {
            return Center(child: Text('No Data' , style: GoogleFonts.poppins(
              color: Colors.grey.shade300
            ),),);
          }
        },
      ),
    );
  }
}
