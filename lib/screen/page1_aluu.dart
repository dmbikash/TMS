import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../provider/alu_provider.dart';

class ALUUContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ALU_Provider>(
      builder: (context, aluProvider, child) {
        return Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "ALU... With STATE Management",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 40,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 10,
                      color: aluProvider.flag
                          ? Colors.orangeAccent
                          : Colors.teal
                  ),
                ),
                child: Image.network(
                  "https://images.unsplash.com/photo-1596910547037-846b1980329f?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1170&q=80",
                  height: 400,
                  width: 600,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  aluProvider.changeFlag(!aluProvider.flag);
                },
                child: Text("Touch ME"),
              ),
            ],
          ),
        );
      },
    );
  }
}
