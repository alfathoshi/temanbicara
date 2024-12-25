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

  TransactionModel(
      {required this.namaPsikiater,
      required this.expertise,
      this.topik = "Consultation",
      this.metode = "Call",
      this.durasi = 90,
      this.sesi = 1,
      required this.jadwal,
      required this.waktu,
      this.kadaluarsa = "Timeless",
      this.harga = 300000});
}
