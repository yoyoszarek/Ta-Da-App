//possible color themes

import 'package:flutter/material.dart';

class ColorThemes {
  static final List<Map<String, dynamic>> palettes = [
    {
      "name": "Classic Blue",
      "light": {
        "primary": const Color(0xFF1D3557),
        "secondary": const Color(0xFF31587A),
        "tertiary": const Color(0xFF457B9D),
        "background": const Color(0xFFCDEAE5),
        "surface": const Color(0xFFA8DADC),
        "text": const Color(0xFF1D3557),
        "error": const Color(0xFFEC9A9A),
        "danger": const Color(0xFFE63946),
      },
      "dark": {
        "primary": const Color(0xFF0F1B2D),
        "secondary": const Color(0xFF223E5C),
        "tertiary": const Color(0xFF2E5376),
        "background": const Color(0xFF1A1A2E),
        "surface": const Color(0xFF16213E),
        "text": const Color(0xFFF1FAEE),
        "error": const Color(0xFFB22222),
        "danger": const Color(0xFF8B0000),
      }
    },
    {
      "name": "Forest Green",
      "light": {
        "primary": const Color(0xFF2D6A4F),
        "secondary": const Color(0xFF40916C),
        "tertiary": const Color(0xFF52B788),
        "background": const Color(0xFFD8F3DC),
        "surface": const Color(0xFF95D5B2),
        "text": const Color(0xFF2D6A4F),
        "error": const Color(0xFFFFB4A2),
        "danger": const Color(0xFFD00000),
      },
      "dark": {
        "primary": const Color(0xFF1B3B2A),
        "secondary": const Color(0xFF2A5A44),
        "tertiary": const Color(0xFF3C7D5C),
        "background": const Color(0xFF16281D),
        "surface": const Color(0xFF1F4A35),
        "text": const Color(0xFFF1FAEE),
        "error": const Color(0xFFB22222),
        "danger": const Color(0xFF8B0000),
      }
    },
    {
      "name": "Sunset Orange",
      "light": {
        "primary": const Color(0xFF9B2226),
        "secondary": const Color(0xFFD00000),
        "tertiary": const Color(0xFFE85D04),
        "background": const Color(0xFFF48C06),
        "surface": const Color(0xFFFAA307),
        "text": const Color(0xFF9B2226),
        "error": const Color(0xFFFFB4A2),
        "danger": const Color(0xFFD00000),
      },
      "dark": {
        "primary": const Color(0xFF5F1114),
        "secondary": const Color(0xFF8A0000),
        "tertiary": const Color(0xFFA63D03),
        "background": const Color(0xFF4C0C0C),
        "surface": const Color(0xFF5F1A00),
        "text": const Color(0xFFF1FAEE),
        "error": const Color(0xFFB22222),
        "danger": const Color(0xFF8B0000),
      }
    }
  ];
}
