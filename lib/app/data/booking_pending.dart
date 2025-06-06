class BookingPending {
  final String nama;
  final String durasi;
  final String tanggal;
  final String waktuMulai;
  final String waktuSelesai;
  final String tanggalTenggat;
  final String waktuTenggat;
  final String metodePembayaran;
  final String totalHarga;
  final String bank;
  final String createdAt;
  final int patientId;
  final int scheduleId;
  final int paymentId;
  final String vaNumber;
  final String transactionId;
  final String expiredDate;
  final String? availableDateRaw;
  final String expertises;
  final int consultationID;
  final String profileUrl;

  BookingPending({
    required this.nama,
    required this.durasi,
    required this.tanggal,
    required this.waktuMulai,
    required this.waktuSelesai,
    required this.tanggalTenggat,
    required this.waktuTenggat,
    required this.metodePembayaran,
    required this.totalHarga,
    required this.vaNumber,
    required this.transactionId,
    required this.expiredDate,
    required this.expertises,
    required this.profileUrl,
    required this.consultationID,
    this.availableDateRaw,
    this.bank = '',
    this.createdAt = '',
    this.patientId = 0,
    this.scheduleId = 0,
    this.paymentId = 0,
  });
}
