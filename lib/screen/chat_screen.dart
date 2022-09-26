import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({Key? key}) : super(key: key);
  final Stream<QuerySnapshot> _messagesStream = FirebaseFirestore.instance
      .collection('chats/DlUGo5fhUXbXlA8XmghC/messages')
      .snapshots();
  final CollectionReference<Map<String, dynamic>> fireStore = FirebaseFirestore
      .instance
      .collection('chats/DlUGo5fhUXbXlA8XmghC/messages');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Chat App"),
        actions: [
          DropdownButton(
              icon: Icon(
                Icons.more_vert,
                color: Theme.of(context).primaryIconTheme.color,
              ),
              items: [
                DropdownMenuItem(
                  child: Container(
                    child: Row(
                      children: [
                        Icon(Icons.exit_to_app),
                        SizedBox(
                          width: 8,
                        ),
                        Text("Logout")
                      ],
                    ),
                  ),
                  value: 'logout',
                ),
              ],
              onChanged: (itemIdentifire){
                if(itemIdentifire=='logout')
                  {
                    FirebaseAuth.instance.signOut();
                  }
              })
        ],
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _messagesStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }

          return ListView.builder(
            itemBuilder: (ctx, index) => Container(
              padding: EdgeInsets.all(8),
              child: Text(snapshot.data!.docs[index]['text']),
            ),
            itemCount: snapshot.data!.docs.length,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          fireStore.add({'text': 'This is added through plus button'});
        },
      ),
    );
  }
}
