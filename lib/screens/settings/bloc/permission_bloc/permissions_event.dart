part of 'permissions_bloc.dart';

abstract class PermissionsEvent {}

class LoadPermissions extends PermissionsEvent {}

class RequestPermission extends PermissionsEvent {
  final String permissionType;
  RequestPermission(this.permissionType);
}