//登录账户的数据和工厂转换函数
class UserInfo {
  String account;
  String avatar;//头像地址
  String birthday;
  String cityCode;
  String gender;
  String id;
  String mobile;
  String nickname;//昵称
  String profession;
  String provinceCod;
  String token; 

  UserInfo({
    required this.account,
    required this.avatar,
    required this.birthday,
    required this.cityCode,
    required  this.gender,
    required this.id,
    required this.mobile,
    required this.nickname,
    required this.profession,
    required this.provinceCod,
    required this.token,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      account: json['account'] ?? '', // 如果没有 account 字段，默认使用空字符串
      avatar: json['avatar'] ?? '', // 如果没有 avatar 字段，默认使用空字符串
      birthday: json['birthday'] ?? '', // 如果没有 birthday 字段，默认使用空字符串
      cityCode: json['cityCode'] ?? '', // 如果没有 cityCode 字段，默认使用空字符串
      gender: json['gender'] ?? '', // 如果没有 gender 字段，默认使用空字符串
      id: json['id'] ?? '', // 如果没有 id 字段，默认使用空字符串
      mobile: json['mobile'] ?? '', // 如果没有 mobile 字段，默认使用空字符串
      nickname: json['nickname'] ?? '', // 如果没有 nickname 字段，默认使用空字符串
      profession: json['profession'] ?? '', // 如果没有 profession 字段，默认使用空字符串
      provinceCod: json['provinceCode'] ?? '', // 如果没有 provinceCode 字段，默认使用空字符串
      token: json['token'] ?? '', // 如果没有 token 字段，默认使用空字符串
    );
  }
}