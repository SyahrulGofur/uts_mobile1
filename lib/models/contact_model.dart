class Contact {
  String id;
  String nama;
  String email;
  String telp;

  Contact({
    required this.id,
    required this.nama,
    required this.email,
    required this.telp,
  });

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      id: json['id'],
      nama: json['nama'],
      email: json['email'],
      telp: json['telp'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nama': nama,
      'email': email,
      'telp': telp,
    };
  }
}
