import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';

class ToDoTaskRecord extends FirestoreRecord {
  ToDoTaskRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  bool hasTitle() => _title != null;

  // "details" field.
  String? _details;
  String get details => _details ?? '';
  bool hasDetails() => _details != null;

  // "completed" field.
  bool? _completed;
  bool get completed => _completed ?? false;
  bool hasCompleted() => _completed != null;

  // "created_time" field.
  DateTime? _createdTime;
  DateTime? get createdTime => _createdTime;
  bool hasCreatedTime() => _createdTime != null;

  // "user" field.
  DocumentReference? _user;
  DocumentReference? get user => _user;
  bool hasUser() => _user != null;

  void _initializeFields() {
    _title = snapshotData['title'] as String?;
    _details = snapshotData['details'] as String?;
    _completed = snapshotData['completed'] as bool?;
    _createdTime = snapshotData['created_time'] as DateTime?;
    _user = snapshotData['user'] as DocumentReference?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('ToDoTask');

  static Stream<ToDoTaskRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => ToDoTaskRecord.fromSnapshot(s));

  static Future<ToDoTaskRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => ToDoTaskRecord.fromSnapshot(s));

  static ToDoTaskRecord fromSnapshot(DocumentSnapshot snapshot) =>
      ToDoTaskRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static ToDoTaskRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      ToDoTaskRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'ToDoTaskRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is ToDoTaskRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createToDoTaskRecordData({
  String? title,
  String? details,
  bool? completed,
  DateTime? createdTime,
  DocumentReference? user,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'title': title,
      'details': details,
      'completed': completed,
      'created_time': createdTime,
      'user': user,
    }.withoutNulls,
  );

  return firestoreData;
}

class ToDoTaskRecordDocumentEquality implements Equality<ToDoTaskRecord> {
  const ToDoTaskRecordDocumentEquality();

  @override
  bool equals(ToDoTaskRecord? e1, ToDoTaskRecord? e2) {
    return e1?.title == e2?.title &&
        e1?.details == e2?.details &&
        e1?.completed == e2?.completed &&
        e1?.createdTime == e2?.createdTime &&
        e1?.user == e2?.user;
  }

  @override
  int hash(ToDoTaskRecord? e) => const ListEquality()
      .hash([e?.title, e?.details, e?.completed, e?.createdTime, e?.user]);

  @override
  bool isValidKey(Object? o) => o is ToDoTaskRecord;
}
