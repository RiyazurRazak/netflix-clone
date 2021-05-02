import 'package:hive/hive.dart';

part 'list.g.dart';

@HiveType(typeId:0)

class MYList{

   @HiveField(0)
  final int id;

  @HiveField(1)
  final String imageURL;

  @HiveField(2)
  final String title;

   @HiveField(3)
  final bool ismovie;

  @HiveField(4)
  final String overview;

  @HiveField(5)
  final double popularity;

  
MYList({
  this.id,
  this.imageURL,
  this.title,
  this.ismovie,
  this.overview,
  this.popularity,
});

}

