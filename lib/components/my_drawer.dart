import 'package:chat/service/auth/auth_service.dart';
import 'package:chat/pages/settings_page.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  void logout(){
    //get suth service
    final _auth = AuthService();
    _auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          //logo
          Column(
            children: [
              DrawerHeader(
                child: Material(
                  elevation: 0,
                  child: Center(child: Icon(Icons.message,size: 40,color: Theme.of(context).colorScheme.primary,),))),

                  const SizedBox(height: 10,),
              
              //home tile
              Padding(
                padding: const EdgeInsets.only(left:25.0),
                child: ListTile(
                  title: const Text("H O M E"),
                  leading: const Icon(Icons.home),
                  onTap: () {
                    //pop the drawer
                    Navigator.pop(context);
                  },
                ),
              ),
              
              //setting tile
                Padding(
                padding: const EdgeInsets.only(left:25.0),
                child: ListTile(
                  title: const Text("S E T T I N G S"),
                  leading: const Icon(Icons.settings),
                  onTap: () {
                    //pop the drawer
                    Navigator.pop(context);

                    //naviagte to settings page
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Settingspage()));
                  },
                ),
              ),
            ],
          ),

          //logout tile
          Padding(
            padding: const EdgeInsets.only(left:25.0,bottom:50),
            child: ListTile(
              title: const Text("L O G O U T"),
              leading: const Icon(Icons.logout),
              onTap:logout,
            ),
          )

        ],
      ),
    );
  }
}

