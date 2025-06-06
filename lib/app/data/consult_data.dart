class ConsultHistory {
  final String status;
  final String nama;
  final String counselorId;
  final String tanggal;
  final String waktuMulai;
  final String waktuSelesai;
  final String durasi;
  final String? problem;
  final String? summary;
  final String? description;
  final String profileUrl;

  ConsultHistory({
    required this.status,
    required this.profileUrl,
    required this.nama,
    required this.counselorId,
    required this.tanggal,
    required this.waktuMulai,
    required this.waktuSelesai,
    required this.durasi,
    this.problem,
    this.summary,
    this.description,
  });
}
