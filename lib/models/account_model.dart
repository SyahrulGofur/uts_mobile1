class Akun {
  String id;
  String nama;
  String email;
  String password;

  Akun(
      {required this.id,
      required this.nama,
      required this.email,
      required this.password});
  factory Akun.fromJson(Map<String, dynamic> json) {
    return Akun(
      id: json['id'],
      nama: json['nama'],
      email: json['email'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nama': nama,
      'email': email,
      'password': password,
    };
  }
}
