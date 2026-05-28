class ConectastiException implements Exception {
  final String message;

  ConectastiException(this.message);

  @override
  String toString(){
    message.replaceAll("Execption:", "");
    return message;
  }
}