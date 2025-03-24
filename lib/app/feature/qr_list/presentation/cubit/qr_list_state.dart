part of 'qr_list_cubit.dart';

@immutable
sealed class QrListState {}

final class QrListInitial extends QrListState {}

final class QrListLoading extends QrListState {}

final class QrListLoaded extends QrListState {
  final List<Map<String, dynamic>> codes;

  QrListLoaded(this.codes);
}

final class QrListError extends QrListState {
  final String message;

  QrListError(this.message);
}

final class QrDeleteSuccess extends QrListState {}

final class QrDeleteError extends QrListState {
  final String message;

  QrDeleteError(this.message);
}
