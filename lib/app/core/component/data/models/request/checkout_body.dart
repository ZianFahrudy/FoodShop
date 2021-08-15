import 'package:json_annotation/json_annotation.dart';

part 'checkout_body.g.dart';

@JsonSerializable(createFactory: false, fieldRename: FieldRename.snake)
class CheckoutBody {
  final int? foodId;
  final int? userId;
  final int? quantity;
  final int? total;
  final String? status;

  CheckoutBody({
    this.foodId,
    this.userId,
    this.quantity,
    this.total,
    this.status,
  });

  Map<String, dynamic> toJson() => _$CheckoutBodyToJson(this);
}
