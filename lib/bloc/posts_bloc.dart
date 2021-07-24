import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_pattern/bloc/posts_events.dart';
import 'package:flutter_bloc_pattern/bloc/posts_states.dart';
import 'package:flutter_bloc_pattern/service/posts_service/rest_api.dart';
import 'package:http/http.dart' as http;

class PostsBloc extends Bloc<PostsEvents, PostsStates> {
  final http.Client httpClient;
  PostsBloc({this.httpClient}) : super(PostsStates());

  @override
  Stream<PostsStates> mapEventToState(PostsEvents event) async* {
    if (event is FetchedPosts) {
      yield await mapFetchedPostsStates(state);
    }
  }

  Future<PostsStates> mapFetchedPostsStates(PostsStates state) async {
    if (state.hasReachedMax) return state;
    try {
      if (state.postsStatus == PostsStatus.initial) {
        final postsList = await PostApi().postsApi();
        return state.copyWith(
          postsStatus: PostsStatus.success,
          postsLists: postsList,
          hasReachedMax: false,
        );
      }
      final postsList = await PostApi().postsApi(state.postsLists.length);
      return postsList.isEmpty
          ? state.copyWith(hasReachedMax: true)
          : state.copyWith(postsStatus: PostsStatus.success, postsLists: List.of(state.postsLists)..addAll(postsList));
    } catch (e) {
      print('Catch error in mapFetchedPostsStates --> $e');
      return state.copyWith(postsStatus: PostsStatus.failure, postsLists: null, hasReachedMax: false);
    }
  }
}
