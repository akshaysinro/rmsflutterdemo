abstract class Failure {
  final String message;
  Failure(this.message);
}


class MainFailure extends Failure {
  MainFailure() : super("Something went wrong");
}
class ServerFailure extends Failure {
  ServerFailure() : super("The kitchen server is down. Please try again.");
}

