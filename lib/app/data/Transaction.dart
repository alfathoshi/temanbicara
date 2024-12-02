class TransactionModel {
  final String namaPsikiater;
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
      required this.topik,
      required this.metode,
      required this.durasi,
      required this.sesi,
      required this.jadwal,
      required this.waktu,
      required this.kadaluarsa,
      required this.harga});
}
