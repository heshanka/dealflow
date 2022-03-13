class Creator {
  String? id;
  String? createdAt;
  String? name;
  String? lastName;
  String? username;
  String? avatar;
  String? email;
  String? country;
  String? company;
  int? netWorth;
  int? followers;

  Creator(
      {this.id,
      this.createdAt,
      this.name,
      this.lastName,
      this.username,
      this.avatar,
      this.email,
        this.country,
        this.company,
        this.netWorth,
        this.followers
      });

  Map<String, dynamic>? jsonMap;

  factory Creator.fromJson(Map<String, dynamic> json) {
    return Creator(
      id: json['id'],
      createdAt: json['createdAt'],
      name: json['name'],
      lastName: json['lastname'],
      username: json['username'],
      avatar: json['avatar'],
      email: json['email'],
      country: json['country'],
      company: json['company'],
        netWorth: json['netWorth'],
      followers: json['followers']
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = <String, dynamic>{
      'id': id,
      'createdAt': createdAt,
      'name': name,
      'lastname': lastName,
      'username': username,
      'avatar': avatar,
      'email': email,
      'country':country,
      'company': company,
      'netWorth': netWorth,
      'followers': followers
    };
    return map;
  }
}
