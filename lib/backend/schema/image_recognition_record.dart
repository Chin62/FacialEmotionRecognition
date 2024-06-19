import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ImageRecognitionRecord extends FirestoreRecord {
  ImageRecognitionRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "image_url" field.
  String? _imageUrl;
  String get imageUrl => _imageUrl ?? '';
  bool hasImageUrl() => _imageUrl != null;

  void _initializeFields() {
    _imageUrl = snapshotData['image_url'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('image_recognition');

  static Stream<ImageRecognitionRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => ImageRecognitionRecord.fromSnapshot(s));

  static Future<ImageRecognitionRecord> getDocumentOnce(
          DocumentReference ref) =>
      ref.get().then((s) => ImageRecognitionRecord.fromSnapshot(s));

  static ImageRecognitionRecord fromSnapshot(DocumentSnapshot snapshot) =>
      ImageRecognitionRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static ImageRecognitionRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      ImageRecognitionRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'ImageRecognitionRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is ImageRecognitionRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createImageRecognitionRecordData({
  String? imageUrl,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'image_url': imageUrl,
    }.withoutNulls,
  );

  return firestoreData;
}

class ImageRecognitionRecordDocumentEquality
    implements Equality<ImageRecognitionRecord> {
  const ImageRecognitionRecordDocumentEquality();

  @override
  bool equals(ImageRecognitionRecord? e1, ImageRecognitionRecord? e2) {
    return e1?.imageUrl == e2?.imageUrl;
  }

  @override
  int hash(ImageRecognitionRecord? e) =>
      const ListEquality().hash([e?.imageUrl]);

  @override
  bool isValidKey(Object? o) => o is ImageRecognitionRecord;
}
