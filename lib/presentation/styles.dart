import 'dart:ui';

const PADDING_DEFAULT = 28.0;
const BORDER_RADIUS_DEFAULT = 8.0;
const BORDER_RADIUS_LARGE = 12.0;

Color primaryGreen = Color.fromARGB(255, 127, 255, 212);
Color orange = Color.fromRGBO(255, 127, 80, 0.95);
Color orangeOpaque = Color.fromRGBO(255, 127, 80, 0.12);
Color green = Color.fromRGBO(0, 206, 209, 0.9);
Color grey = Color.fromRGBO(99, 106, 125, 1);
Color blue = Color.fromRGBO(136, 199, 227, 0.9);


Color getTypeColor(int type) {
  switch(type) {
    case 1: {
      return orange;
    }
    case 2: {
      return grey;
    }
    case 3: {
      return blue;
    }
    default: {
      return orange;
    }
  }
}