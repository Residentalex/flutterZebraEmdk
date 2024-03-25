/// VALIDATION CLASS
class TValidator {
  /// Empty Text Validation
  static String? validateEmptyText(String? fieldName, String? value) {
    if (value == null || value.isEmpty) {
      return '$fieldName is requerido.';
    }

    return null;
  }

  /// Username Validation
  static String? validateUsername(String? username) {
    if (username == null || username.isEmpty) {
      return 'Nombre de usuario es requerido.';
    }

    // Define a regular expression pattern for the username.
    const pattern = r"^[a-zA-Z0-9_-]{3,20}$";

    // Create a RegExp instance from the pattern.
    final regex = RegExp(pattern);

    // Use the hasMatch method to check if the username matches the pattern.
    bool isValid = regex.hasMatch(username);

    // Check if the username doesn't start or end with an underscore or hyphen.
    if (isValid) {
      isValid = !username.startsWith('_') &&
          !username.startsWith('-') &&
          !username.endsWith('_') &&
          !username.endsWith('-');
    }

    if (!isValid) {
      return 'Username is not valid.';
    }

    return null;
  }

  /// Email Validation
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Correo electrónico es requerido.';
    }

    // Regular expression for email validation
    final emailRegExp = RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!emailRegExp.hasMatch(value)) {
      return 'Correo electrónico invalido';
    }

    return null;
  }

  /// Password Validation
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'La contraseña es requerida.';
    }

    // Check for minimum password length
    if (value.length < 6) {
      return 'La contraseña debe tener al menos 6 caracteres.';
    }

    // Check for uppercase letters
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'La Contraseña debe tener al menos un caracter en mayuscula.';
    }

    // Check for numbers
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'La contraseña debe tener al menos un numero.';
    }

    return null;
  }

  /// Phone Number Validation
  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Numero de teléfono requeridos.';
    }

    // Regular expression for phone number validation (assuming a 10-digit US phone number format)
    final phoneRegExp = RegExp(r'^\d{10}$');

    if (!phoneRegExp.hasMatch(value)) {
      return 'Formato de numero de teléfono no valido (Se requieren 10 digitos.)';
    }

    return null;
  }

// Add more custom validators as needed for your specific requirements.
}
