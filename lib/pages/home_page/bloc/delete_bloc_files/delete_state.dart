part of '../delete_bloc.dart';

@immutable
abstract class DeleteState {}

class DeleteInitial extends DeleteState {}

class DeleteSuccess extends DeleteState {}

class DeleteFailure extends DeleteState {}
