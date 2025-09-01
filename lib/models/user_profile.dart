import 'dart:convert';

class UserProfile {
  final String username;
  final String nickname;
  final int gender;
  final String? idCard;
  final String address;
  final String? birthday;
  final String? signature;
  final String? avatar;
  final String lastLoginTime;
  final int totalCheckInDays;
  final int continuousCheckInDays;
  final String? lastCheckInTime;
  final int privacySetting;
  final bool isEncrypted;
  final String? encryptionPassword;

  UserProfile({
    required this.username,
    required this.nickname,
    required this.gender,
    this.idCard,
    required this.address,
    this.birthday,
    this.signature,
    this.avatar,
    required this.lastLoginTime,
    required this.totalCheckInDays,
    required this.continuousCheckInDays,
    this.lastCheckInTime,
    required this.privacySetting,
    required this.isEncrypted,
    this.encryptionPassword,
  });

  // 从Map转换为UserProfile实例的静态方法
  static UserProfile fromMap(Map<String, dynamic> map) {
    return UserProfile(
      username: map['username'] as String,
      nickname: map['nickname'] as String,
      gender: map['gender'] as int,
      idCard: map['idCard'] as String?,
      address: map['address'] as String,
      birthday: map['birthday'] as String?,
      signature: map['signature'] as String?,
      avatar: map['avatar'] as String?,
      lastLoginTime: map['lastLoginTime'] as String,
      totalCheckInDays: map['totalCheckInDays'] as int,
      continuousCheckInDays: map['continuousCheckInDays'] as int,
      lastCheckInTime: map['lastCheckInTime'] as String?,
      privacySetting: map['privacySetting'] as int,
      isEncrypted: map['isEncrypted'] as bool,
      encryptionPassword: map['encryptionPassword'] as String?,
    );
  }

  // 转换为Map的方法
  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'nickname': nickname,
      'gender': gender,
      'idCard': idCard,
      'address': address,
      'birthday': birthday,
      'signature': signature,
      'avatar': avatar,
      'lastLoginTime': lastLoginTime,
      'totalCheckInDays': totalCheckInDays,
      'continuousCheckInDays': continuousCheckInDays,
      'lastCheckInTime': lastCheckInTime,
      'privacySetting': privacySetting,
      'isEncrypted': isEncrypted,
      'encryptionPassword': encryptionPassword,
    };
  }

  // 从JSON字符串转换为UserProfile实例
  static UserProfile fromJson(String source) => fromMap(json.decode(source) as Map<String, dynamic>);

  // 转换为JSON字符串
  String toJson() => json.encode(toMap());

  // 复制方法，用于更新部分字段
  UserProfile copyWith({
    String? username,
    String? nickname,
    int? gender,
    String? idCard,
    String? address,
    String? birthday,
    String? signature,
    String? avatar,
    String? lastLoginTime,
    int? totalCheckInDays,
    int? continuousCheckInDays,
    String? lastCheckInTime,
    int? privacySetting,
    bool? isEncrypted,
    String? encryptionPassword,
  }) {
    return UserProfile(
      username: username ?? this.username,
      nickname: nickname ?? this.nickname,
      gender: gender ?? this.gender,
      idCard: idCard ?? this.idCard,
      address: address ?? this.address,
      birthday: birthday ?? this.birthday,
      signature: signature ?? this.signature,
      avatar: avatar ?? this.avatar,
      lastLoginTime: lastLoginTime ?? this.lastLoginTime,
      totalCheckInDays: totalCheckInDays ?? this.totalCheckInDays,
      continuousCheckInDays: continuousCheckInDays ?? this.continuousCheckInDays,
      lastCheckInTime: lastCheckInTime ?? this.lastCheckInTime,
      privacySetting: privacySetting ?? this.privacySetting,
      isEncrypted: isEncrypted ?? this.isEncrypted,
      encryptionPassword: encryptionPassword ?? this.encryptionPassword,
    );
  }

  @override
  String toString() {
    return 'UserProfile(username: $username, nickname: $nickname, gender: $gender, idCard: $idCard, address: $address, birthday: $birthday, signature: $signature, avatar: $avatar, lastLoginTime: $lastLoginTime, totalCheckInDays: $totalCheckInDays, continuousCheckInDays: $continuousCheckInDays, lastCheckInTime: $lastCheckInTime, privacySetting: $privacySetting, isEncrypted: $isEncrypted, encryptionPassword: $encryptionPassword)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    
    return other is UserProfile &&
        other.username == username &&
        other.nickname == nickname &&
        other.gender == gender &&
        other.idCard == idCard &&
        other.address == address &&
        other.birthday == birthday &&
        other.signature == signature &&
        other.avatar == avatar &&
        other.lastLoginTime == lastLoginTime &&
        other.totalCheckInDays == totalCheckInDays &&
        other.continuousCheckInDays == continuousCheckInDays &&
        other.lastCheckInTime == lastCheckInTime &&
        other.privacySetting == privacySetting &&
        other.isEncrypted == isEncrypted &&
        other.encryptionPassword == encryptionPassword;
  }

  @override
  int get hashCode {
    return username.hashCode ^
        nickname.hashCode ^
        gender.hashCode ^
        idCard.hashCode ^
        address.hashCode ^
        birthday.hashCode ^
        signature.hashCode ^
        avatar.hashCode ^
        lastLoginTime.hashCode ^
        totalCheckInDays.hashCode ^
        continuousCheckInDays.hashCode ^
        lastCheckInTime.hashCode ^
        privacySetting.hashCode ^
        isEncrypted.hashCode ^
        encryptionPassword.hashCode;
  }
}