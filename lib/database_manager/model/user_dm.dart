class UserDM {
  static UserDM? currentUser;

  static const String collectionName = 'users';
  String id;
  String fullName;
  String userName;
  String email;

  UserDM(
      {required this.id,
      required this.fullName,
      required this.userName,
      required this.email});

  Map<String, dynamic> addUserToFireStore() => {
        'id': id,
        'fullName': fullName,
        'userName': userName,
        'email': email,
      };

  UserDM.getUserFromFireStore(Map<String, dynamic> data)
      : this(
          id: data['id'],
          fullName: data['fullName'],
          userName: data['userName'],
          email: data['email'],
        );
}
