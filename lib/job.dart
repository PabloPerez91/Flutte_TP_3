import 'package:hive/hive.dart';
part 'job.g.dart';

@HiveType(typeId: 1)
class Job {
  Job(this.entreprise, this.salairenet, this.status, this.salairebrut, this.sentiment, this.contrattype);

  @HiveField(0)
  final String entreprise;

  @HiveField(1)
  final double salairebrut;

  @HiveField(2)
  final String status;

  @HiveField(3)
  final double salairenet;

  @HiveField(4)
  final String sentiment;

  @HiveField(5)
  final String contrattype;

  @override
  String toString(){
    return '$entreprise $salairenet $salairebrut $status $sentiment $contrattype';
  }
}