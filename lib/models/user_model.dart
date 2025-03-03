/***********************************************************************************************************************
* 
*                                                  Public
* 
***********************************************************************************************************************/

class UserData {
  final String userId;
  final String name;
  final String email;
  final bool isAdmin;

  UserData({
    this.userId = '',
    this.name = '',
    this.email = '',
    this.isAdmin = false,
  });

  // Converte um Map<String, dynamic> para um objeto User
  factory UserData.fromMap(Map<String, dynamic> data) {
    return UserData(
      userId: data['userId'] ?? '',
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      isAdmin:
          data['isAdmin'] is bool ? data['isAdmin'] : data['isAdmin'] == 'true',
    );
  }
}
