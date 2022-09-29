import '../base_model.dart';
import '../enum/view_state.dart';
import '../exception/main_exception.dart';
import '../service/authentification_service.dart';
import '../service_locator.dart';

class LoginModel extends BaseModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();

  Future<String?> login(String email, String password) async {
    setState(ViewState.busy);
    String? failureMessage;

    try {
      await _authenticationService.login(email, password);
    } catch (e) {
      if (e is MainException) {
        failureMessage = e.message;
      } else {
        failureMessage = 'Unhandled Error : $e';
      }
    }

    setState(ViewState.idle);
    return failureMessage;
  }
}
