class TransactionModel {
  final String namaPsikiater;
  final String expertise;
  final String topik;
  final String metode;
  final int durasi;
  final int sesi;
  final String jadwal;
  final String waktu;
  final String kadaluarsa;
  final int harga;
  final int selectedID;
  final int appTax;
  final int admTax;

  TransactionModel(
      {required this.namaPsikiater,
      required this.expertise,
      this.topik = "Consultation",
      this.metode = "Chat",
      this.durasi = 90,
      this.sesi = 1,
      required this.jadwal,
      required this.waktu,
      this.kadaluarsa = "Timeless",
      this.harga = 300000,
      this.appTax = 15000,
      this.admTax = 1000,
      required this.selectedID});
}
