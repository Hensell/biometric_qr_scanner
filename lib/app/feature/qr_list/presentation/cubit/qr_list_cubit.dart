import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'qr_list_state.dart';

class QrListCubit extends Cubit<QrListState> {
  QrListCubit() : super(QrListInitial());
}
