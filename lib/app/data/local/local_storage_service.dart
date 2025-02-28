// // lib/app/core/services/storage_service.dart
// import 'package:get_storage/get_storage.dart';

// class StorageService {
//   final storage = GetStorage();

//   // Initialize storage
//   static Future<void> init() async {
//     await GetStorage.init();
//   }

//   // Save data
//   Future<void> saveData(String key, dynamic value) async {
//     await storage.write(key, value);
//   }

//   // Read data
//   T? getData<T>(String key) {
//     return storage.read<T>(key);
//   }

//   // Delete data
//   Future<void> removeData(String key) async {
//     await storage.remove(key);
//   }

//   // Clear all data
//   Future<void> clearAll() async {
//     await storage.erase();
//   }
// }
