abstract class ErrorException {
  String message;

  ErrorException(this.message);
  @override
  String toString() {
    // TODO: implement toString
    return message;
  }
}

class ErrorLocalException extends ErrorException {
  ErrorLocalException(super.message);
  @override
  String toString() {
    // TODO: implement toString
    return super.message;
  }
}

class ErrorRemoteException extends ErrorException {
  ErrorRemoteException(super.message);

  @override
  String toString() {
    return super.message;
  }
}