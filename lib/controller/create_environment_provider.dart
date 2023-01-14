// import '../model/utils/consts_manager.dart';
// import 'firebase.dart';
//
// class CreateEnvironmentProvider with ChangeNotifier{
//
//   List<models.User> listAdmin=[
//     models.User(id: "",
//         uid: "",
//         name: "Admin",
//         email: "admin@gmail.com",
//         phoneNumber: "+999999999999",
//         password: "123456",
//         typeUser: AppConstants.collectionAdmin,
//         photoUrl: ""),
//   ];
//
//   createAdmin(context,{int indexListAdmin=0}) async {
//     if(listAdmin.length<1){
//       return FirebaseFun.errorUser("a user is emty");
//     }
//     models.User user=listAdmin[indexListAdmin];
//     var result =await FirebaseFun.signup(email: user.email, password: user.password);
//     if(result['status']){
//         user.uid= result['body']['uid'];
//         result = await FirebaseFun.createUser(user: user);
//     }
//     print(result);
//     Const.TOAST(context,textToast: FirebaseFun.findTextToast(result['message'].toString()));
//     return result;
//   }
//
//   createAdmins(context) async {
//     var result;
//     if(listAdmin.length<1){
//       return FirebaseFun.errorUser("a list admin is empty");
//     }
//     for(int i=0;i<listAdmin.length;i++){
//       result =await createAdmin(context,indexListAdmin: i);
//     }
//
//     return result;
//   }
//
//   onError(error){
//     print(false);
//     print(error);
//     return {
//       'status':false,
//       'message':error,
//       //'body':""
//     };
//   }
// }
