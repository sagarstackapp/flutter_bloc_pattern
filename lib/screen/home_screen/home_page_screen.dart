import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_pattern/bloc/posts_bloc.dart';
import 'package:flutter_bloc_pattern/bloc/posts_events.dart';
import 'package:flutter_bloc_pattern/bloc/posts_states.dart';
import 'package:flutter_bloc_pattern/main.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        PostsBloc().add(FetchedPosts());
      }
    });
  }

  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   super.dispose();
  //   scrollController.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    print('Current Page --> $runtimeType');
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text('Flutter Bloc'), centerTitle: true),
      body: Center(
        child: BlocProvider(
          create: (context) {
            return PostsBloc(httpClient: http.Client())..add(FetchedPosts());
          },
          child: BlocBuilder<PostsBloc, PostsStates>(
            builder: (context, state) {
              switch (state.postsStatus) {
                case PostsStatus.failure:
                  return Center(child: Text('Failed to fetch data'));
                case PostsStatus.success:
                  return ListView.separated(
                    controller: scrollController,
                    itemBuilder: (context, index) => index >= state.postsLists.length ? LoadingPage() : Text('${state.postsLists[index].title}'),
                    separatorBuilder: (context, index) => Divider(thickness: 2, color: Colors.grey),
                    itemCount: state.hasReachedMax ? state.postsLists.length : state.postsLists.length + 1,
                  );
                default:
                  return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }
}
