class AddressModel {
  final String name;
  final String phone;
  final String address;
  final String type;
  final bool isDefault;

  AddressModel({
    required this.name,
    required this.phone,
    required this.address,
    required this.type,
    this.isDefault = false,
  });

  AddressModel copyWith({
    String? name,
    String? phone,
    String? address,
    String? type,
    bool? isDefault,
  }) {
    return AddressModel(
      name: name ?? this.name,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      type: type ?? this.type,
      isDefault: isDefault ?? this.isDefault,
    );
  }
} 