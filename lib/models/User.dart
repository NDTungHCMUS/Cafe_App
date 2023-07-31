class User {
  User({required this.imagePath, required this.fullName, required this.phoneNumber, required this.email, required this.address, required this.isDarkMode});
  String imagePath;
  String fullName;
  String phoneNumber;
  String email;
  String address;
  bool isDarkMode;
  User.empty()
      : imagePath = '',
        fullName = '',
        phoneNumber = '',
        email = '',
        address = '',
        isDarkMode = false;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      fullName: json['fullName'],
      phoneNumber: json['phoneNumber'],
      email: json['email'],
      address: json['address'],
      imagePath: json['imagePath'],
      isDarkMode: false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'email': email,
      'address': address,
      'imagePath': imagePath,
    };
  }
}