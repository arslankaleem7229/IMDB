import 'package:flutter/material.dart';

Row movieField({@required String field, @required String value}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "$field : ",
        style: TextStyle(
          color: Colors.black38,
          fontSize: 12.0,
          fontWeight: FontWeight.w300,
        ),
      ),
      Expanded(
        child: Text(
          value,
          style: TextStyle(
            color: Colors.black,
            fontSize: 12.0,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
    ],
  );
}
