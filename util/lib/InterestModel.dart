

import 'dart:convert';

InterestHistory interestHistoryFromJson(String str) {
  final jsonData = json.decode(str);
  return InterestHistory.fromMap(jsonData);
}

String interestHistoryToJson(InterestHistory data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}


class InterestHistory {
   int id = 0;
   String title;
   String fromDate;
   String toDate;
   int amount;
   double rate;
   double total;

  InterestHistory({    
    required this.id,
    required this.title,
    required this.fromDate,
    required this.toDate,    
    required this.amount,
    required this.rate,
    required this.total
  });

  factory InterestHistory.fromMap(Map<String, dynamic> json) => new InterestHistory(
        id: json["id"] as int,
        title: json["title"],
        fromDate: json["from_date"],
        toDate: json["to_date"],
        amount: json["amount"],
        rate: double.parse(json["rate"].toString()),
        total: double.parse(json["total"].toString()),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "from_date": fromDate,
        "to_date": toDate,
        "amount": amount,
        "rate": rate,
        "total": total,
      };
}