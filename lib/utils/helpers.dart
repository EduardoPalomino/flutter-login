// Aquí puedes agregar funciones de ayuda, como validadores o formateadores.

String validateEmail(String value) {
  if (value.isEmpty) {
    return 'Please enter an email';
  }
  final regex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
  if (!regex.hasMatch(value)) {
    return 'Please enter a valid email';
  }
  return null;
}
