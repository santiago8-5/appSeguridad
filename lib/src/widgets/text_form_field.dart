import 'package:flutter/material.dart';

enum Validator {
  validationPassword,
  validationEmail,
}

String? validateField(Validator validator, String? value) {
  switch (validator) {
    case Validator.validationPassword:
      if (value == null || value.trim().length < 6) {
        return 'La contraseña debe tener al menos 6 caracteres';
      }
      break;
    case Validator.validationEmail:
      if (value == null || value.trim().isEmpty || !value.contains('@')) {
        return 'Por favor, introduzca una dirección de correo válida';
      }
      break;
  }
  return null;
}

Widget buildTextFormField({
  required TextEditingController controller,
  required String labelText,
  required IconData icon,
  TextInputType? inputType,
  Widget? suffixIcon,
  bool obscureText = false,
  Validator? validator,
}) {
  return TextFormField(
    controller: controller,
    decoration: InputDecoration(
      labelStyle: const TextStyle(color: Color.fromARGB(255, 25, 58, 207)),
      labelText: labelText,
      suffixIcon: suffixIcon,
      icon: Icon(icon, color: const Color.fromARGB(255, 25, 58, 207)),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.blue, width: 2),
        borderRadius: BorderRadius.circular(20),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide:
            const BorderSide(color: Color.fromARGB(255, 41, 65, 131), width: 2),
        borderRadius: BorderRadius.circular(20),
      ),
    ),
    obscureText: obscureText,
    keyboardType: inputType,
    validator: (value) {
      if (validator != null) {
        // Verificar si validator no es nulo
        return validateField(validator, value);
      }
      return null;
    },
  );
}
