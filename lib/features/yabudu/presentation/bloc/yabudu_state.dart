part of 'yabudu_bloc.dart';

abstract class YabuduState extends Equatable {
  const YabuduState();  

  @override
  List<Object> get props => [];
}
class YabuduInitial extends YabuduState {}
