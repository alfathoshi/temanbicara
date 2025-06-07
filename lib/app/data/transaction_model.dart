class TransactionModel {
  final String namaPsikiater;
  final String expertise;
  final String topik;
  final String metode;
  final String durasi;
  final int sesi;
  final String jadwal;
  final String waktu;
  final String kadaluarsa;
  final int harga;
  final int selectedID;
  final int appTax;
  final int admTax;
  final String profileUrl;

  TransactionModel({
    required this.namaPsikiater,
    required this.expertise,
    required this.profileUrl,
    this.topik = "Consultation",
    this.metode = "Chat",
    required this.durasi,
    this.sesi = 1,
    required this.jadwal,
    required this.waktu,
    this.kadaluarsa = "Timeless",
    this.harga = 300000,
    this.appTax = 15000,
    this.admTax = 1000,
    required this.selectedID,
  });
}
