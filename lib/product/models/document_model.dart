class DocumentModel {
  final String base64document;
  final String filename;
  final String mimetype;

  DocumentModel({
    required this.base64document,
    required this.filename,
    required this.mimetype,
  });

  factory DocumentModel.fromJson(Map<String, dynamic> json) {
    return DocumentModel(
      base64document: json['base64document'],
      filename: json['filename'],
      mimetype: json['mimetype'],
    );
  }

  Map<String, dynamic> toJson() => {
        'base64document': base64document,
        'filename': filename,
        'mimetype': mimetype,
      };
}
