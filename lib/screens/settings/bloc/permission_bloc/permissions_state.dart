part of 'permissions_bloc.dart';

abstract class PermissionsState {}

class PermissionsInitial extends PermissionsState {}

class PermissionsLoading extends PermissionsState {}

class PermissionsLoaded extends PermissionsState {
  final Map<String, bool> permissions;
  PermissionsLoaded(this.permissions);
}