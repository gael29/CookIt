import 'dart:ffi';

class Instruction{
  int number ;
  String step ;

  Instruction({this.number,this.step});
  factory Instruction.fromJson(dynamic json) {
    return new Instruction(
      number: json['number'] as int,
      step: json['step'] as String,
    );


  }

}
  