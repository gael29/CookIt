import 'dart:ffi';

import 'instruction.dart';

class AnalizedInstruction{
  String name ;
  List<Instruction> instructions;

  AnalizedInstruction({this.name,this.instructions});
  factory AnalizedInstruction.fromJson(dynamic json) {

      var InstructionObjsJson = json['steps'] as List;
      List<Instruction> _instruction = InstructionObjsJson.map((tagJson) => Instruction.fromJson(tagJson)).toList();

    return new AnalizedInstruction(
      name: json['name'] as String,
      instructions :_instruction
    );


  }

}