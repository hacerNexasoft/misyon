class ProjectTeamModel {
  List<Member> participantMembers;
  List<Member> teamMembers;

  ProjectTeamModel({
    required this.participantMembers,
    required this.teamMembers,
  });

  factory ProjectTeamModel.fromJson(Map<String, dynamic> json) {
    return ProjectTeamModel(
      participantMembers:
          (json['participantMembers'] as List).map((e) => Member.fromJson(e)).toList(),
      teamMembers: (json['teamMembers'] as List).map((e) => Member.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'participantMembers': participantMembers.map((e) => e.toJson()).toList(),
      'teamMembers': teamMembers.map((e) => e.toJson()).toList(),
    };
  }
}

class Member {
  String name;
  int memberType;
  String? mail;
  String? linkedIn;
  String? facebook;
  String? youtube;
  String? instagram;
  String? webSite;
  String? twitter;
  String description;
  String? imageurl;
  String? imageurlMimeType;
  String title;
  double partnershipPercentage;

  Member({
    required this.name,
    required this.memberType,
    this.mail,
    this.linkedIn,
    this.facebook,
    this.youtube,
    this.instagram,
    this.webSite,
    this.twitter,
    required this.description,
    this.imageurl,
    this.imageurlMimeType,
    required this.title,
    required this.partnershipPercentage,
  });

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      name: json['name'],
      memberType: json['memberType'],
      mail: json['mail'],
      linkedIn: json['linkedIn'],
      facebook: json['facebook'],
      youtube: json['youtube'],
      instagram: json['instagram'],
      webSite: json['webSite'],
      twitter: json['twitter'],
      description: json['description'],
      imageurl: json['imageurl'],
      imageurlMimeType: json['imageurlMimeType'],
      title: json['title'],
      partnershipPercentage: json['partnershipPercentage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'memberType': memberType,
      'mail': mail,
      'linkedIn': linkedIn,
      'facebook': facebook,
      'youtube': youtube,
      'instagram': instagram,
      'webSite': webSite,
      'twitter': twitter,
      'description': description,
      'imageurl': imageurl,
      'imageurlMimeType': imageurlMimeType,
      'title': title,
      'partnershipPercentage': partnershipPercentage,
    };
  }
}
