class ConsultationResponse {
  final String bank;
  final String vaNumber;
  final String paymentMethod;
  final String transactionId;
  final String? status;
  final String expiredDate;
  final int amount;

  ConsultationResponse({
    required this.bank,
    required this.vaNumber,
    required this.paymentMethod,
    required this.transactionId,
    required this.expiredDate,
    required this.amount,
    this.status,
  });

  factory ConsultationResponse.fromJson(Map<String, dynamic> json) {
    return ConsultationResponse(
      bank: json['bank'],
      vaNumber: json['va_number'],
      paymentMethod: json['payment_method'],
      transactionId: json['transaction_id'],
      expiredDate: json['expired_date'],
      amount: json['amount'],
      status: json['status'],
    );
  }
}
