import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart%20%20';
import 'package:pmu_labs/presentation/details_page/details_page.dart';
import '../../components/utils/debounce.dart';
import '../../domain/models/card.dart';
import 'package:pmu_labs/presentation/home_page/bloc/bloc.dart';
import 'package:pmu_labs/presentation/home_page/bloc/events.dart';
import 'package:pmu_labs/presentation/home_page/bloc/state.dart';

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

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final searchController = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeBloc>().add(const HomeLoadDataEvent());
    });
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  Future<void> _onRefresh() {
    context
        .read<HomeBloc>()
        .add(HomeLoadDataEvent(search: searchController.text));
    return Future.value(null);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: CupertinoSearchTextField(
            controller: searchController,
            onChanged: (search) {
              Debounce.run(() => context
                  .read<HomeBloc>()
                  .add(HomeLoadDataEvent(search: search)));
            },
          ),
        ),
        BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) => state.error != null
              ? Text(
                  state.error ?? '',
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(color: Colors.red),
                )
              : state.isLoading
                  ? const CircularProgressIndicator()
                  : Expanded(
                      child: RefreshIndicator(
                        onRefresh: _onRefresh,
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: state.data?.length ?? 0,
                          itemBuilder: (context, index) {
                            final data = state.data?[index];
                            return data != null
                                ? _CardSign.fromData(
                                    data,
                                    onLike: (String title, bool isLiked) =>
                                        _showSnackBar(context, title, isLiked),
                                    onTap: () => _navToDetails(context, data),
                                  )
                                : const SizedBox.shrink();
                          },
                        ),
                      ),
                    ),
        ),
      ],
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
