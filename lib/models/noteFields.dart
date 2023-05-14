import 'package:hive/hive.dart';
part 'noteFields.g.dart';
@HiveType(typeId: 0)
class noteFields extends HiveObject{
  @HiveField(0)
  final String title;
  @HiveField(1)
  final String content;
  @HiveField(2)
  final String date;
  noteFields({required this.title,required this.content, required this.date});

}