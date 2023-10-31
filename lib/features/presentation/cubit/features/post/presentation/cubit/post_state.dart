part of 'post_cubit.dart';


abstract class PostState extends Equatable {
  const PostState();

  @override
  List<Object> get props => [];
}

class PostInitial extends PostState {}

class PostLoading extends PostState {}

class PostLoad extends PostState {
final Response response;
const PostLoad(this.response);
@override

  List<Response> get props => [response];
}

class PostError extends PostState {
  final String message ;
  const PostError(this.message);
}
