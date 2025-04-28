class ConsultPending {
  final String nama;
  final String durasi;
  final String tanggal;
  final String waktu;
  final String tanggalTenggat;
  final String waktuTenggat;
  final String metodePembayaran;
  final String totalHarga;
  final String bank;
  final String createdAt;
  final int patientId;
  final int scheduleId;
  final int paymentId;

  ConsultPending({
    required this.nama,
    required this.durasi,
    required this.tanggal,
    required this.waktu,
    required this.tanggalTenggat,
    required this.waktuTenggat,
    required this.metodePembayaran,
    required this.totalHarga,
    this.bank = '',
    this.createdAt = '',
    this.patientId = 0,
    this.scheduleId = 0,
    this.paymentId = 0,
  });
}
