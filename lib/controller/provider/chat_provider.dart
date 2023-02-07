import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:mosand/controller/provider/process_provider.dart';
import 'package:mosand/controller/provider/profile_provider.dart';
import 'package:mosand/translations/locale_keys.g.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import '../../model/models.dart';
import '../../model/utils/const.dart';
import '../../model/utils/consts_manager.dart';
import '../utils/firebase.dart';

class ChatProvider with ChangeNotifier{
 Chats chats=Chats(listChat: []);
 Chat chat=Chat.init();

 createChat(BuildContext context,{required List<String> listIdUser}) async {
   //ProfileProvider profileProvider= Provider.of<ProfileProvider>(context);
  // List<String> listIdUser=[idLawyer,profileProvider.user.id];
   var result=await FirebaseFun.fetchChatsByListIdUser(listIdUser: listIdUser);
   if(result['status']){
     if(result['body'].length<=0){
       result=await FirebaseFun.addChat(chat:
       Chat(messages: [], listIdUser: listIdUser, date: DateTime.now()));
           if(result['status'])
             await FirebaseFun.addMessage(message: Message.init(),idChat:result['body']['id'] );
     }

     else
       result=FirebaseFun.errorUser("Chat already found");
   }
   return result;
 }


 fetchLastMessage(context,{required String idChat}) async{
   final result=await FirebaseFun.fetchLastMessage(idChat: idChat);
   Message message=Message.init();
   if(result['status']){
     message=Message.fromJson(result['body'][0]);
   }
   return message.toJson();
 }
 widgetLastMessage(context,{required String idChat}){
   return FutureBuilder(
     future: fetchLastMessage(
         context,
         idChat: idChat),
     builder: (
         context,
         snapshot,
         ) {
       print(snapshot
           .error);
       if (snapshot
           .connectionState ==
           ConnectionState
               .waiting) {
         return  Text(tr(LocaleKeys.loading));
         //Const.CIRCLE(context);
       } else if (snapshot
           .connectionState ==
           ConnectionState
               .done) {
         if (snapshot
             .hasError) {
           return const Text(
               'Error');
         } else if (snapshot
             .hasData) {
          Message message =Message.fromJson(snapshot.data);
           // Map<String,dynamic> data=snapshot.data as Map<String,dynamic>;
           //homeProvider.sessions=Sessions.fromJson(data['body']);
           return Text(
               '${message.textMessage}'
           );
         } else {
           return const Text(
               'Empty data');
         }
       } else {
         return Text(
             'State: ${snapshot.connectionState}');
       }
     },
   );
 }
 fetchChatStream({required String idChat}) {
   final result= FirebaseFirestore.instance
       .collection(AppConstants.collectionChat)
   .doc(idChat)
       .collection(AppConstants.collectionMessage)
       .orderBy("sendingTime")
       .snapshots();
   return result;

 }
 fetchChatsStream(String idUser) {
   final result= FirebaseFirestore.instance
       .collection(AppConstants.collectionChat)
   .where('listIdUser',arrayContains: idUser)
   //    .orderBy("date")
       .snapshots();
   return result;

 }
 addMessage(context,{required String idChat,required Message message}) async{
   message.sendingTime=DateTime.now();
   var result =await FirebaseFun
       .addMessage(idChat: idChat,
       message:message);
   //print(result);
   result['status']??Const.TOAST(context,textToast: FirebaseFun.findTextToast(result['message'].toString()));
   return result;
 }
 deleteMessage(context,{required String idChat,required Message message}) async{
   var result =await FirebaseFun
       .deleteMessage(idChat: idChat,
       message:message);
   result['status']??Const.TOAST(context,textToast: FirebaseFun.findTextToast(result['message'].toString()));
   return result;
 }


 Future uploadFile({required String filePath,required String typePathStorage}) async {
   try {
     String path = basename(filePath);
     print(path);
     File file =File(filePath);

//FirebaseStorage storage = FirebaseStorage.instance.ref().child(path);
     Reference storage = FirebaseStorage.instance.ref().child("${typePathStorage}${path}");
     UploadTask storageUploadTask = storage.putFile(file);
     TaskSnapshot taskSnapshot = await storageUploadTask;
     //Const.LOADIG(context);
     String url = await taskSnapshot.ref.getDownloadURL();
     //Navigator.of(context).pop();
     print('url $url');
     return url;
   } catch (ex) {
     //Const.TOAST( context,textToast:FirebaseFun.findTextToast("Please, upload the image"));
   }
 }
  onError(error){
    print(false);
    print(error);
    return {
      'status':false,
      'message':error,
      //'body':""
    };
  }
}
