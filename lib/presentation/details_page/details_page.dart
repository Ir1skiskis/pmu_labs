import 'package:flutter/material.dart';
import 'package:pmu_labs/domain/models/card.dart';

class DetailsPage extends StatelessWidget {
  final CardData data;

  const DetailsPage(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple.shade200,
      ),
      body: SingleChildScrollView(
        child: Container(
          constraints: BoxConstraints(minHeight: MediaQuery.sizeOf(context).height - 105),
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 255, 255, 255),
          ),
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Image.network(data.imageUrl ?? ''),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: Text(
                  data.text!,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ),
              Text(
                data.signDesc!,
                style: Theme.of(context).textTheme.bodyLarge,
              )
            ],
          ),
        ),
      ),
    );
  }
}
