import 'package:mysql1/mysql1.dart';
class Mysql{
  static String host='localhost',
  user= 'root',
  
  db= 'unitabledb';
  static int port=3306;
  Mysql();
  Future<MySqlConnection> getconnection() async{
    var setting =new ConnectionSettings(
      host: host,
      port: port,
      user: user,
      db: db,
     
    );
    return await MySqlConnection.connect(setting);
  }
}