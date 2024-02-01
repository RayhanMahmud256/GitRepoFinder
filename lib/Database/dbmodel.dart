import 'package:isar/isar.dart';

part 'repos.g.dart';

@Collection()
class repos{
  Id id = Isar.autoIncrement;
  late List ls;
}