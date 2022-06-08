import '../db/models/user_model.dart';

abstract class SuperCubit {
  void login(User user);

  void registerUser(User user);
}
