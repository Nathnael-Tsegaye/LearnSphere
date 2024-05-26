class Profile {
  final String firstname;
  final String lastname;
  final String email;
  final String location ;
  final String imageUrl;


  Profile({
    required this.firstname,
    required this.lastname,
    required this.location,
    required this.imageUrl,
    required this.email
    }
    );

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      firstname: json['fisrtname'],
      lastname: json['lastname'],
      location: json['location'],
      email: json['email'],
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firstname': firstname,
      'lastname': lastname,
      'location': location,
      'email': email,
      'imageUrl': imageUrl,
    };
  }
}