abstract class ErrorFailures {
  String message;

  ErrorFailures(this.message);
  @override
  String toString() {
    // TODO: implement toString
    return message;
  }
}

class ErrorLocalFailure extends ErrorFailures {
  ErrorLocalFailure(super.message);
  @override
  String toString() {
    // TODO: implement toString
    return super.message;
  }
}

class ErrorRemoteFailure extends ErrorFailures {
  ErrorRemoteFailure(super.message);

  @override
  String toString() {
    return super.message;
  }
}
