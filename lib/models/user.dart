import 'package:hive/hive.dart';


part 'user.g.dart';

@HiveType(typeId: 0)
class User extends HiveObject {

@HiveField(0)
  late String username ;

@HiveField(1)
  late String password ;

@HiveField(3)
  late String access_token ;

@HiveField(4)
  late String refresh_token ;
}



