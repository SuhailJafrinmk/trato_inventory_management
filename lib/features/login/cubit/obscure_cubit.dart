import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

class ObscureCubit extends Cubit<bool> {
  ObscureCubit() : super(true);
void toggleVisibility()=>emit(!state);
}
