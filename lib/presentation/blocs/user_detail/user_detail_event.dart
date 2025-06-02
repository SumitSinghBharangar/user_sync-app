import 'package:equatable/equatable.dart';
import 'package:user_sync/data/models/post_model.dart';

abstract class UserDetailEvent extends Equatable {
  const UserDetailEvent();

  @override
  List<Object> get props => [];
}

class FetchUserDetails extends UserDetailEvent {
  final int userId;

  const FetchUserDetails(this.userId);

  @override
  List<Object> get props => [userId];
}

class AddPost extends UserDetailEvent {
  final Post post;

  const AddPost(this.post);

  @override
  List<Object> get props => [post];
}
