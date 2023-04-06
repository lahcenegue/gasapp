import 'package:flutter/material.dart';

Widget droupDownMenu({
  required List<String> items,
  required String? hintText,
  required Widget prefix,
  required void Function(String?)? onChanged,
}) {
  return Container(
    height: 50,
    margin: const EdgeInsets.only(top: 20),
    padding: const EdgeInsets.only(left: 8, right: 10),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(
        color: Colors.black,
      ),
      borderRadius: BorderRadius.circular(30),
    ),
    child: Row(
      children: [
        prefix,
        const SizedBox(width: 5),
        Flexible(
          child: DropdownButtonFormField(
            decoration: InputDecoration.collapsed(
              hintText: hintText!,
            ),
            items: items
                .map((item) => DropdownMenuItem(
                      value: item,
                      child: Text(
                        item,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 18,
                        ),
                      ),
                    ))
                .toList(),
            onChanged: onChanged,
            // validator: (value) {
            //   if (value == null) {
            //     return 'يجب الاختيار';
            //   }
            //   return null;
            // },
          ),
        ),
      ],
    ),
  );
}
