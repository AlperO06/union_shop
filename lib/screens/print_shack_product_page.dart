import 'package:flutter/material.dart';
import '../data/print_shack.dart';

class PrintShackProductPage extends StatefulWidget {
  final PrintShackProduct product;

  const PrintShackProductPage({Key? key, required this.product}) : super(key: key);

  @override
  State<PrintShackProductPage> createState() => _PrintShackProductPageState();
}

class _PrintShackProductPageState extends State<PrintShackProductPage> {
  int _selectedImage = 0;
  int _lines = 1;
  int _quantity = 1;
  late List<TextEditingController> _controllers;
