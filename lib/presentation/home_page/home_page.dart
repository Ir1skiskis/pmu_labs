import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pmu_labs/presentation/details_page/details_page.dart';
import '../../domain/models/card.dart';

part 'card.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Color _color = Colors.deepPurple.shade200;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: _color,
        title: Text(widget.title),
      ),
      body: const Body(),
    );
  }
}

class Body extends StatelessWidget {
  const Body({super.key}); // ключи

  @override
  Widget build(BuildContext context) {
    final data = [
      CardData(
        'Знак квен',
        descriptionText: 'Узнать больше',
        imageUrl:
            'https://i.playground.ru/p/3CQFu4JWr2aG2dt1y36pcQ.png.webp',
        signDesc:
            'Знак основанный на элементе земли. Образует защитное поля поглощающие ограниченное количество ударов, по мере улучшения это количество можно увеличить. На втором уровне улучшения способен создавать поле выдерживающие серию ударов, но во время использования такого поля двигаться практически невозможно.',
      ),
      CardData(
        'Знак аксий',
        descriptionText: 'Узнать больше',
        imageUrl:
            'https://i.playground.ru/p/keckHXvVjCRtk7RNnZPwyA.png.webp',
        signDesc:
            'Знак основанный на элементе воды. Волна психологического воздействия способная помутить разум противника. На начальном уровне вводит врага в ступор и временно обездвиживает его. При дальнейшем улучшении может склонять врага на вашу сторону. Вне боя используется для убеждения собеседников, но будьте осторожны в большой компании Аксий бесполезен. Также имеет одну не менее важную функцию, с помощью Аксия можно быстро успокоить "Плотву", что незаменимо в работе ведьмака.',
      ),
      CardData(
        'Знак ирден',
        descriptionText: 'Узнать больше',
        imageUrl:
            'https://i.playground.ru/p/07sGuL1-abJXU5-YxOeCSw.png.webp',
        signDesc:
            'Знак основанный на пятом элементе, сути магии. Ирден создаёт магическую ловушку в виде круга, попав в которую враг значительно замедляется, но некоторые противники способны противостоять воздействию знака. Незаменим в битвах с Полуденницой и Полуночницой, так как в привычном виде они не осязаемы, а попав в ловушку приобретают материальную форму. В альтернативном режиме Геральт создает на земле активный знак, который стреляет разрядами по врагам нанося им урон. Так же уничтожает болты и стрелы. Очень эффективен в бою с быстрыми противниками.',
      ),
      CardData(
        'Знак аард',
        descriptionText: 'Узнать больше',
        imageUrl:
            'https://i.playground.ru/p/7b4aa0LCPs_IxWfaNkOHaw.png.webp',
        signDesc:
            'Знак основанный на элементе воздуха. Аард, направленный телекинетический удар способный дезориентировать врага или вовсе сбить с ног. Используя Аард можно сбить летающую бестию или врага использующего конницу. Также незаменим и вне боя, используется для разрушения хлипких стен и дверей.',
      ),
      CardData(
        'Знак игни',
        descriptionText: 'Узнать больше',
        imageUrl:
            'https://i.playground.ru/p/MNUnTYH-uwgCsyX_AkPWqg.png.webp',
        signDesc:
            'Знак основанный на элементе огня. Направленный огненный шквал, способный поранить или вовсе поджечь наступающую силу противника, также вид огня может посеять панику в рядах противника. Помимо боевых качеств, Игни можно использовать и в более рутинных целях, таких как розжиг костров, воспламенения ядовитых газов и уничтожения гнёзд различных бестий.',
      ),
    ];

    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: data.map((data) {
            return _CardSign.fromData(
              data,
              onLike: (String title, bool isLiked) =>
                  _showSnackBar(context, title, isLiked),
              onTap: () => _navToDetails(context, data),
            );
          }).toList(),
        ),
      ),
    );
  }

  void _navToDetails(BuildContext context, CardData data) {
    Navigator.push(
      context,
      CupertinoPageRoute(builder: (context) => DetailsPage(data)),
    );
  }

  void _showSnackBar(BuildContext context, String title, bool isLiked) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          '$title ${isLiked ? 'liked!' : 'disliked! '}',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        backgroundColor: Colors.deepPurple.shade200,
        duration: const Duration(seconds: 1),
      ));
    });
  }
}
