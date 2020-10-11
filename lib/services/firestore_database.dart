// import 'dart:async';

import 'package:meta/meta.dart';
// import 'firestore_service.dart';
// import 'firestore_path.dart';

String documentIdFromCurrentData() => DateTime.now().toIso8601String();

class FirestoreDatabase {
  FirestoreDatabase({
    @required this.uid
  }) : assert(uid != null);

  final String uid;

  // final _service = FirestoreService.instance;

  // TODO
  
}