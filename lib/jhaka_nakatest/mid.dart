import 'package:flutter/material.dart';

import '../menu/menu_item.dart';



class Batchdekhabo extends StatefulWidget {

  final void Function(MenuItem) onMenuItemSelected;

  Batchdekhabo({required this.onMenuItemSelected});

  @override
  State<Batchdekhabo> createState() => _BatchdekhaboState();
}

class _BatchdekhaboState extends State<Batchdekhabo> {
  @override
  Widget build(BuildContext context) {
    return Center(child: TextButton(
      onPressed: (){
        widget.onMenuItemSelected(MenuItem.createAdmin);
        },
      child: Text("Yoo"),
    ),);
  }
}

