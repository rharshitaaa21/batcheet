import 'package:batcheet/widgets/chat/messages.dart';
import 'package:batcheet/widgets/chat/new_message.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Chat'),
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
                    children: <Widget>[
                      Icon(Icons.exit_to_app),
                      SizedBox(
                        width: 8,
                      ),
                      Text(('Logout'))
                    ],
                  ),
                ),
                value: 'Logout',
              ),
            ],
            onChanged: (itemidentifier) {
              if (itemidentifier == 'Logout') {
                FirebaseAuth.instance.signOut();
              }
            },
          )
        ],
      ),
      body: Container(
        child: Column(children: <Widget>[
          Expanded(
            child: Messages(),
          ),
          NewMessage(),
        ]),
      ),
      // floatingActionButton: FloatingActionButton(
      //     child: Icon(Icons.add),
      //     onPressed: () {
      //       Firestore.instance
      //           .collection('chats/e5bhvXsCB4GZGE0brDYL/messages')
      //           .add({
      //         'text': "This was added by clicking the button",
      //       });
      //     }),
    );
  }
}
