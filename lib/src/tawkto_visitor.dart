/// [TawkToVisitor] This is the visitor class for the TawkTo API.
class TawkToVisitor {
  /// Name of the visitor.
  final String? name;

  /// Email of the visitor.
  final String? email;

  /// This parameter is used for securemode
  final String? hash;

  TawkToVisitor({
    required this.name,
    required this.email,
    this.hash,
  });

  Map<String, dynamic> toJson() => {
        'name': name ?? "",
        'email': email ?? "",
        'hash': hash ?? "",
      };
}
