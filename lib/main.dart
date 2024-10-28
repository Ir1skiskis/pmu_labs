import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Табеев Александр Павлович'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Color _color = Colors.deepPurple;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: _color,
        title: Text(widget.title),
      ),
      body: const MyWidget(),
    );
  }
}

class _CardData {
  final String text;
  final String descriptionText;
  final IconData icon;
  final String? imageUrl;

  _CardData(
      this.text, {
      required this.descriptionText,
      this.icon = Icons.videogame_asset,
      this.imageUrl,
  });
}

class MyWidget extends StatelessWidget  {
  const MyWidget({super.key}); // ключи

@override
  Widget build(BuildContext context) {
  final data = [
    _CardData(
      'Знак квен',
      descriptionText: 'Узнать больше',
      imageUrl: 'https://steamuserimages-a.akamaihd.net/ugc/778491285542587846/4D2F818BA75D4F559966A8E160D1F03458DE67A3/',
    ),
    _CardData(
      'Знак аксий',
      descriptionText: 'Узнать больше',
      imageUrl: 'https://steamuserimages-a.akamaihd.net/ugc/778491285542585855/E1126DB28634F5E82F360BD76E315BC18BA5C93E/',
    ),
    _CardData(
      'Знак ирден',
      descriptionText: 'Узнать больше',
      imageUrl: 'https://steamuserimages-a.akamaihd.net/ugc/778491285542589140/7DCC65D5A1BD51A8FCCA46362985C46630B958FB/',
    ),
    _CardData(
      'Знак аард',
      descriptionText: 'Узнать больше',
      imageUrl: 'https://steamuserimages-a.akamaihd.net/ugc/778491285542584354/C0CAB1EDF118A5ED3B115CAAF12DA6B69B36E823/',
    ),
    _CardData(
      'Знак игни',
      descriptionText: 'Узнать больше',
      imageUrl: 'https://steamuserimages-a.akamaihd.net/ugc/778491285542582699/A14AAD38642820504205131564151DD131A7948C/',
    ),
  ];

  return Center(
    child: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: data.map((e) => _CardBook.fromData(e)).toList(),
      ),
    ),
  );
  }
}

class _CardBook extends StatelessWidget {
  final String text;
  final String descriptionText;
  final IconData icon;
  final String? imageUrl;


  const _CardBook(
      this.text, {
      this.icon = Icons.ac_unit_outlined,
      required this.descriptionText,
      this.imageUrl,
  });

  factory _CardBook.fromData(_CardData data) => _CardBook(
      data.text,
      descriptionText: data.descriptionText,
      icon: data.icon,
      imageUrl: data.imageUrl,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white70,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.grey,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(.5),
            spreadRadius: 4,
            offset: const Offset(0, 5),
            blurRadius: 8,
          )
        ]
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: SizedBox(
              height: 140,
              width: 130,
              child: Image.network(imageUrl ?? '',
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const Placeholder(),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    text,
                    style: Theme.of(context).textTheme.headlineLarge,
                    ),
                  Text(
                    descriptionText,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Icon(icon),
          ),
        ],
      ),
    );
  }
}