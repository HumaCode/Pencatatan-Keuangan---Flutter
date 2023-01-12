class History {
  History({
    this.idHistory,
    this.idUser,
    this.type,
    this.date,
    this.total,
    this.datalist,
    this.createdAt,
    this.updatedAt,
  });

  String? idHistory;
  String? idUser;
  String? type;
  String? date;
  String? total;
  String? datalist;
  String? createdAt;
  String? updatedAt;

  factory History.fromJson(Map<String, dynamic> json) => History(
        idHistory: json["id_history"],
        idUser: json["id_user"],
        type: json["type"],
        date: json["date"],
        total: json["total"],
        datalist: json["datalist"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id_history": idHistory,
        "id_user": idUser,
        "type": type,
        "date": date,
        "total": total,
        "datalist": datalist,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
