// import 'package:syntonic_components/models/appointment_personal_setting_view_options_model.dart';
// import 'package:syntonic_components/models/chat_model.dart';
// import 'package:syntonic_components/models/equipment_model.dart';
// import 'package:syntonic_components/models/staff_model.dart';
// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:syntonic_components/services/local_storage_service_io.dart' if (dart.library.html) 'package:syntonic_components/services/local_storage_service_html.dart' as local_storage_service;
//
// class LocalStorageService {
//   static final String _chat = "CREATE TABLE chat(id INTEGER PRIMARY KEY AUTOINCREMENT, image TEXT, file_path TEXT, message TEXT, sent_date INTEGER)";
//   static final String _staff = "CREATE TABLE staff(id INTEGER PRIMARY KEY AUTOINCREMENT, staff_id TEXT, is_enabled INTEGER)";
//   static final String _equipment = "CREATE TABLE equipment(id INTEGER PRIMARY KEY AUTOINCREMENT, equipment_id TEXT, is_enabled INTEGER)";
//   static final String _equipmentPersonalSettingsViewOptions = "CREATE TABLE appointment_personal_settings_view_options(id INTEGER PRIMARY KEY AUTOINCREMENT, customer_name INTEGER)";
//
//   /// Create the database.
//   static Future<Database> get database async {
//     // Fixme: リセットのためだけのコードなので、製造時の動作確認のみに使っている。
//     // var path = join(await getDatabasesPath(), 'db');
//     // await deleteDatabase(path);
//
//     final Future<Database> _database = openDatabase(
//       join(await getDatabasesPath(), 'db'),
//       onCreate: (db, version) async {
//         List<String> _sqls = [
//           _chat,
//           _staff,
//           _equipment,
//           _equipmentPersonalSettingsViewOptions,
//         ];
//
//         for (String _sql in _sqls) {
//           await db.execute(
//             _sql,
//           );
//         }
//       },
//       version: 1,
//     );
//     return _database;
//   }
//
//   /// Insert a chat in database with [chat].
//   static Future<void> insertChat({required ChatModel chat}) async {
//     final Database db = await database;
//     await db.insert(
//       'chat',
//       chat.toJsonForLocalStorage(),
//       conflictAlgorithm: ConflictAlgorithm.replace,
//     );
//   }
//
//   /// Get chats from database.
//   static Future<List<ChatModel>> getChats() async {
//     final Database db = await database;
//     final List<Map<String, dynamic>> maps = await db.query('chat');
//     return List.generate(maps.length, (i) {
//       return ChatModel.fromJson(maps[i])..sentDate = DateTime.now();
//     });
//   }
//
//   /// Delete a chat with [chat.id].
//   static Future<void> deleteChat(ChatModel chat) async {
//     final db = await database;
//     await db.delete(
//       'chat',
//       where: "id = ?",
//       whereArgs: [chat.id],
//     );
//   }
//
//   /// Insert a staff in database with [staff].
//   static Future<void> insertStaff({required StaffModel staff}) async {
//     final Database db = await database;
//     final List<Map<String, dynamic>> maps = await db.query(
//       'staff',
//       where: "staff_id = ?",
//       whereArgs: [staff.id != null ? staff.id!.toString() : null]);
//       StaffModel? _staff = maps.length > 0 ? StaffModel.fromJson(maps[0]) : null;
//
//       if (_staff != null) {
//         await db.update(
//           'staff',
//           {
//             "staff_id": staff.id != null ? staff.id!.toString() : null,
//           },
//           where: "staff_id = ?",
//           whereArgs: [staff.id != null ? staff.id!.toString() : null],
//         );
//       } else {
//         await db.insert(
//           'staff',
//           {
//             "staff_id": staff.id != null ? staff.id!.toString() : null,
//             "is_enabled": 1,
//           },
//           conflictAlgorithm: ConflictAlgorithm.replace,
//         );
//       }
//   }
//
//   /// Update a staff in database with [staff].
//   static Future<void> updateStaff({required StaffModel staff, required bool isEnabled}) async {
//     final Database db = await database;
//     await db.update(
//       'staff',
//       {
//         "staff_id": staff.id != null ? staff.id!.toString() : null,
//         "is_enabled": isEnabled ? 1 : 0,
//       },
//       where: "staff_id = ?",
//       whereArgs: [staff.id != null ? staff.id!.toString() : null],
//     );
//   }
//
//   /// Get staffs from database.
//   static Future<List<StaffModel>> getStaffs({bool? isEnabled}) async {
//     final Database db = await database;
//     final List<Map<String, dynamic>> maps = await db.query('staff',
//       where: isEnabled != null ? "is_enabled = ?" : null,
//       whereArgs: isEnabled != null ? [isEnabled ? 1 : 0] : null,);
//     return List.generate(maps.length, (i) {
//       return StaffModel(id: maps[i]["staff_id"] != null ? BigInt.parse(maps[i]["staff_id"]) : null);
//     });
//   }
//
//   /// Delete a staff with [staff.id].
//   static Future<void> deleteStaff(StaffModel staff) async {
//     final db = await database;
//     await db.delete(
//       'staff',
//       where: "staff_id = ?",
//       whereArgs: [staff.id != null ? staff.id!.toString() : null],
//     );
//   }
//
//   /// Delete a staff with [staff.id].
//   static Future<void> deleteAllStaffs() async {
//     final db = await database;
//     await db.execute("DROP TABLE IF EXISTS staff");
//     await db.execute(_staff);
//   }
//
//   /// Insert a equipment in database with [equipment].
//   static Future<void> insertEquipment({required EquipmentModel equipment}) async {
//     final Database db = await database;
//
//     final List<Map<String, dynamic>> maps = await db.query(
//         'equipment',
//         where: "equipment_id = ?",
//         whereArgs: [equipment.id != null ? equipment.id!.toString() : null]);
//     EquipmentModel? _equipment = maps.length > 0 ? EquipmentModel.fromJson(maps[0]) : null;
//
//     if (_equipment != null) {
//       await db.update(
//         'equipment',
//         {
//           "equipment_id": equipment.id != null ? equipment.id!.toString() : null,
//         },
//         where: "equipment_id = ?",
//         whereArgs: [equipment.id != null ? equipment.id!.toString() : null],
//       );
//     } else {
//       await db.insert(
//         'equipment',
//         {
//           "equipment_id": equipment.id != null ? equipment.id!.toString() : null,
//           "is_enabled": 1,
//         },
//         conflictAlgorithm: ConflictAlgorithm.replace,
//       );
//     }
//   }
//
//   /// Update a equipment in database with [Equipment].
//   static Future<void> updateEquipment({required EquipmentModel equipment, required bool isEnabled}) async {
//     final Database db = await database;
//     await db.update(
//       'equipment',
//       {
//         "equipment_id": equipment.id != null ? equipment.id!.toString() : null,
//         "is_enabled": isEnabled ? 1 : 0,
//       },
//       where: "equipment_id = ?",
//       whereArgs: [equipment.id != null ? equipment.id!.toString() : null],
//     );
//   }
//
//   /// Get equipments from database.
//   static Future<List<EquipmentModel>> getEquipments({bool? isEnabled}) async {
//     final Database db = await database;
//     final List<Map<String, dynamic>> maps = await db.query('equipment');
//     return List.generate(maps.length, (i) {
//       return EquipmentModel(id: BigInt.parse(maps[i]["equipment_id"]));
//     });
//   }
//
//   /// Delete a equipment with [equipment.id].
//   static Future<void> deleteEquipment(EquipmentModel equipment) async {
//     final db = await database;
//     await db.delete(
//       'equipment',
//       where: "equipment_id = ?",
//       whereArgs: [equipment.id.toString()],
//     );
//   }
//
//   /// Delete a staff with [staff.id].
//   static Future<void> deleteAllEquipments() async {
//     final db = await database;
//     await db.execute("DROP TABLE IF EXISTS equipment");
//     await db.execute(_equipment);
//   }
//
//   /// Insert a staff in database with [staff].
//   static Future<void> insertAppointmentPersonalSettingViewOptions({required AppointmentPersonalSettingViewOptionsModel viewOptions}) async {
//     final Database db = await database;
//     await deleteAppointmentPersonalSettingViewOptions();
//     await db.insert(
//       'appointment_personal_settings_view_options',
//       {
//         "customer_name": viewOptions.customerName!.index,
//       },
//       conflictAlgorithm: ConflictAlgorithm.replace,
//     );
//   }
//
//   /// Get staffs from database.
//   static Future<AppointmentPersonalSettingViewOptionsModel> getAppointmentPersonalSettingViewOptions() async {
//     final Database db = await database;
//     final List<Map<String, dynamic>> maps = await db.query('appointment_personal_settings_view_options');
//     if (maps.isNotEmpty) {
//       return AppointmentPersonalSettingViewOptionsModel(customerName: CustomerNameViewOption.values[maps[0]["customer_name"]]);
//     } else {
//       return AppointmentPersonalSettingViewOptionsModel(customerName: CustomerNameViewOption.name);
//     }
//   }
//
//   /// Delete a staff with [staff.id].
//   static Future<void> deleteAppointmentPersonalSettingViewOptions() async {
//     final db = await database;
//     await db.execute("DROP TABLE IF EXISTS appointment_personal_settings_view_options");
//     await db.execute(_equipmentPersonalSettingsViewOptions);
//   }
//
//   /// Get request token.
//   static Future<String?> getToken() async {
//     return local_storage_service.LocalStorageService.getToken();
//   }
//
//   /// Get own authorities.
//   static get myAuthorities async {
//     return await local_storage_service.LocalStorageService.myAuthorities();
//   }
//
//   /// Delete local storage.
//   static get deleteLocalstorage async {
//     return await local_storage_service.LocalStorageService.deleteLocalstorage();
//   }
// }
