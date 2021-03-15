  import 'package:flutter/material.dart';
  Widget imageLoadingCircle() {
    return  Container(
            color: Colors.white,
            child: Container(
              child: CircularProgressIndicator(
                value: null,
              ),
            ));
  }