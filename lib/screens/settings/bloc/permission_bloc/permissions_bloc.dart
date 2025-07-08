import 'package:bloc/bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'permissions_event.dart';
part 'permissions_state.dart';

class PermissionsBloc extends Bloc<PermissionsEvent, PermissionsState> {
  PermissionsBloc() : super(PermissionsInitial()) {
    on<LoadPermissions>(_onLoadPermissions);
    on<RequestPermission>(_onRequestPermission);
  }

  Future<void> _onLoadPermissions(
      LoadPermissions event,
      Emitter<PermissionsState> emit,
      ) async {
    emit(PermissionsLoading());

    final prefs = await SharedPreferences.getInstance();
    final permissions = {
      'location': prefs.getBool('permission_location') ?? false,
      'camera': prefs.getBool('permission_camera') ?? false,
      'microphone': prefs.getBool('permission_microphone') ?? false,
    };

    emit(PermissionsLoaded(permissions));
  }

  Future<void> _onRequestPermission(
      RequestPermission event,
      Emitter<PermissionsState> emit,
      ) async {
    final prefs = await SharedPreferences.getInstance();
    PermissionStatus status;

    switch (event.permissionType) {
      case 'location':
        status = await Permission.location.request();
        break;
      case 'camera':
        status = await Permission.camera.request();
        break;
      case 'microphone':
        status = await Permission.microphone.request();
        break;
      default:
        return;
    }

    final isGranted = status.isGranted;
    await prefs.setBool('permission_${event.permissionType}', isGranted);

    add(LoadPermissions());
  }
}