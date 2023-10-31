
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:internet_connection_retry/injection_container.dart';
part 'post_state.dart';

class PostCubit extends Cubit<PostState> {
  PostCubit() : super(PostInitial());



Future<void> getPost() async {
  try{
    emit(PostLoading());
   final Response response = await getIt<Dio>()
                      .get('https://jsonplaceholder.typicode.com/posts');
                      emit(PostLoad(response));
                      }
                      catch(e){
                        emit(const PostError("error"));
                      }
}
}
