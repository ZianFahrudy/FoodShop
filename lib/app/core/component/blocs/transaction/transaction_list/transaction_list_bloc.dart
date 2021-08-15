import 'package:food_shop/app/core/component/data/models/response/transaction_list_model.dart';
import 'package:food_shop/app/core/component/data/repository/transaction/transaction_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@injectable
class TransactionListBloc {
  TransactionRepository _repository;
  TransactionListBloc(this._repository);
  final _transactionList = BehaviorSubject<TransactionListModel>();

  Function(TransactionListModel) get updateTransactionList =>
      _transactionList.sink.add;
  Stream<TransactionListModel> get data => _transactionList.stream;

  fetchTransactionList() async {
    final result = await _repository.getTransactionList();

    result.fold((error) {
      print('Something wrong when request transaction list $error');
      return _transactionList.addError(error);
    }, (value) => updateTransactionList(value));
  }

  dispose() {
    _transactionList.close();
  }
}
