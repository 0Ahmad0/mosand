import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

//LawyerSchedule
class LawyerSchedule {
  TextEditingController? fromController;
  TextEditingController? toController;
  String? formHour;
  String? toHour;

  LawyerSchedule(
      {this.formHour, this.toHour, this.fromController, this.toController});
}
//advance
class Advance {
  static bool theme = false;
  static bool language = false;
  static bool isRegisterKEY = false;
  static bool isLogined = false;
  static String token = "";
  static String uid = "";
  static String avatarImage = "";
}
//user
class User {
  String id;
  String uid;
  String name;
  String photoUrl;
  String email;
  String phoneNumber;
  String password;
  String typeUser;
  String description;
  String lawyerId;
  String gender;
  DateTime dateBirth;
  List<String> tokens;
  User({
    required this.id,
    required this.uid,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.password,
    required this.typeUser,
    required this.photoUrl,
    required this.gender,
    required this.dateBirth,
    this.description = "",
    this.lawyerId = "",
    this.tokens = const[],
  });

  factory User.fromJson(json) {
    //print(json);
    return User(
        id: json['id'],
        uid: json["uid"],
        name: json["name"],
        email: json["email"],
        phoneNumber: json["phoneNumber"],
        password: json["password"],
        typeUser: json["typeUser"],
        photoUrl: json["photoUrl"],
        gender: json["gender"],
        lawyerId: json["lawyerId"],
        dateBirth: json["dateBirth"].toDate(),
       // tokens: json["tokens"],
        description: (json["description"] != null) ? json["description"] : "");
  }
  factory User.init(){
    return User(id: "", uid: '', name: '', email: '', phoneNumber: '', password: '', typeUser: '', photoUrl: "", gender: "", dateBirth: DateTime.now());
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'uid': uid,
        'name': name,
        'email': email,
        'phoneNumber': phoneNumber,
        'password': password,
        'typeUser': typeUser,
        'gender': gender,
        'dateBirth':Timestamp.fromDate(dateBirth),
        'lawyerId': lawyerId,
        'photoUrl': photoUrl,
        'description': description,
        'tokens': tokens,
      };
}
//users
class Users {
  List<User> users;

  //DateTime date;

  Users({required this.users});

  factory Users.fromJson(json) {
    List<User> tempUsers = [];

    for (int i = 0; i < json.length; i++) {
      User tempUser = User.fromJson(json[i]);
      tempUser.id = json[i].id;
      tempUsers.add(tempUser);
    }
    return Users(users: tempUsers);
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> tempUsers = [];
    for (User user in users) {
      tempUsers.add(user.toJson());
    }
    return {
      'users': tempUsers,
    };
  }
}

//dateDay
class DateDay {
  String id;
  TimeOfDay? from;
  TimeOfDay? to;
  DateDay({
     this.id="",
    required this.from,
    required this.to,
  });

  factory DateDay.fromJson(json) {
    return DateDay(
        id: json['id'],
        from: (json["from"]==null)?json["from"]: TimeOfDay.fromDateTime(json["from"].toDate()),
        to: (json["to"]==null)?json["to"]:TimeOfDay.fromDateTime(json["to"].toDate()),);
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'from': (from==null)?from:DateTime.fromMillisecondsSinceEpoch(((from!.hour-3)*60+from!.minute)*60000),
    'to': (to==null)?to:DateTime.fromMillisecondsSinceEpoch(((to!.hour-3)*60+to!.minute)*60000),
  };
}
//dateLawyer
class DateLawyer {
  String id;
  String idLawyer;
  Map<String,dynamic> dateDays;
  DateLawyer({
    this.id="",
    required this.dateDays,
    required this.idLawyer,
  });

  factory DateLawyer.fromJson(json) {
    Map<String,dynamic> temp={};
    for(var element in json['dateDays'].keys){
      temp[element]=DateDay.fromJson(json['dateDays'][element]);
    }
    return DateLawyer(
      id: json['id'],
        idLawyer: json['idLawyer'],
    dateDays: temp);
  }

  Map<String, dynamic> toJson() {
    Map<String,dynamic> temp={};
    for(var element in dateDays.keys){
      temp[element]=dateDays[element].toJson();
    }
    return {
    'id': id,
    'idLawyer': idLawyer,
    'dateDays': temp,
  };
  }
}
//DateLawyers
class DateLawyers {
  List<DateLawyer> listDateLawyer;

  //DateTime date;

  DateLawyers({required this.listDateLawyer});

  factory DateLawyers.fromJson(json) {
    List<DateLawyer> temp = [];
    for (int i = 0; i < json.length; i++) {
      DateLawyer tempElement = DateLawyer.fromJson(json[i]);
      tempElement.id = json[i].id;
      temp.add(tempElement);
    }
    return DateLawyers(listDateLawyer: temp);
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> temp = [];
    for (var element in listDateLawyer) {
      temp.add(element.toJson());
    }
    return {
      'listDateLawyer': temp,
    };
  }
}

//Internship
class Internship {
  String id;
  String idLawyer;
  String internshipOpportunity;
  String price;
  Internship({
    this.id="",
    required this.internshipOpportunity,
    required this.idLawyer,
    required this.price,
  });

  factory Internship.fromJson(json) {

    return Internship(
        id: json['id'],
        idLawyer: json['idLawyer'],
        internshipOpportunity: json['internshipOpportunity'],
        price: json['price']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'idLawyer': idLawyer,
      'internshipOpportunity': internshipOpportunity,
      'price': price,
    };
  }
}
//Internships
class Internships {
  List<Internship> listInternship;

  //DateTime date;

  Internships({required this.listInternship});

  factory Internships.fromJson(json) {
    List<Internship> temp = [];
    for (int i = 0; i < json.length; i++) {
      Internship tempElement = Internship.fromJson(json[i]);
      tempElement.id = json[i].id;
      temp.add(tempElement);
    }
    return Internships(listInternship: temp);
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> temp = [];
    for (var element in listInternship) {
      temp.add(element.toJson());
    }
    return {
      'listInternship': temp,
    };
  }
}


//DateO
class DateO {
  String id;
  String idLawyer;
  String idUser;
  String specialtyLawyer;
  String subjectConsultation;
  DateTime dateTime;
  bool notificationLawyer;
  bool notificationUser;
  DateO({
    this.id="",
    required this.idUser,
    required this.idLawyer,
    required this.specialtyLawyer,
    required this.subjectConsultation,
     this.notificationLawyer=false,
     this.notificationUser=false,
    required this.dateTime,
  });

  factory DateO.fromJson(json) {

    return DateO(
        id: json['id'],
        idUser: json['idUser'],
        idLawyer: json['idLawyer'],
        specialtyLawyer: json['specialtyLawyer'],
        subjectConsultation: json['subjectConsultation'],
    notificationLawyer: json['notificationLawyer'],
        notificationUser: json['notificationUser'],
        dateTime: json['dateTime'].toDate());
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'idUser': idUser,
      'idLawyer': idLawyer,
      'specialtyLawyer': specialtyLawyer,
      'subjectConsultation': subjectConsultation,
      'notificationLawyer': notificationLawyer,
      'notificationUser': notificationUser,
      'dateTime': dateTime,
    };
  }
  factory DateO.init(){
    return DateO(idUser: "", idLawyer: "", specialtyLawyer: "", subjectConsultation: "", dateTime: DateTime.now());
  }
}

//DateOs
class DateOs {
  List<DateO> listDateO;

  //DateTime date;

  DateOs({required this.listDateO});

  factory DateOs.fromJson(json) {
    List<DateO> temp = [];
    for (int i = 0; i < json.length; i++) {
      DateO tempElement = DateO.fromJson(json[i]);
      tempElement.id = json[i].id;
      temp.add(tempElement);
    }
    return DateOs(listDateO: temp);
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> temp = [];
    for (var element in listDateO) {
      temp.add(element.toJson());
    }
    return {
      'listDateO': temp,
    };
  }
}

/*
flutter pub run easy_localization:generate -S "assets/translations/" -O "lib/translations"
flutter pub run easy_localization:generate -S "assets/translations/" -O "lib/translations" -o "locale_keys.g.dart" -f keys
flutter build apk --split-per-abi
temp@gmail.com   123456
 */
