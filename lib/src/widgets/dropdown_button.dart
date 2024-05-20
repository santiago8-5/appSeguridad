import 'package:flutter/material.dart';
import 'package:proyect_segu_v2/src/provider/register_provider.dart';

Widget buildDropdownFormField({
  required String labelText,
  required IconData icon,
  required List<DropdownMenuItem<UserRole>> items, // Cambio de tipo
  required UserRole? value, // Cambio de tipo
  required void Function(UserRole?) onChanged, // Cambio de tipo
  InputDecoration? decoration,
}) {
  return DropdownButtonFormField<UserRole>(
    // Cambio de tipo
    decoration: decoration ?? const InputDecoration(),
    value: value,
    onChanged: onChanged,
    items: items,
    icon: Icon(icon),
    iconSize: 24,
    elevation: 16,
    style: const TextStyle(color: Colors.black),
    isExpanded: true,
  );
}
