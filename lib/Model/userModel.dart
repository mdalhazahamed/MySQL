
import 'package:hive/hive.dart';
part 'userModel.g.dart';

@HiveType(typeId: 0) //this model class type To
class UserModel extends HiveObject{

  @HiveField(0)
  late String user_name;

   @HiveField(1)
  late String user_number;

   @HiveField(2)
  late String location;


}