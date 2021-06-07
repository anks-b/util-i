

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
   String fromDate;
   String toDate;
   int amount;
   int rate;
   int total;

  InterestHistory({    
    required this.id,
    required this.fromDate,
    required this.toDate,    
    required this.amount,
    required this.rate,
    required this.total
  });

  factory InterestHistory.fromMap(Map<String, dynamic> json) => new InterestHistory(
        id: json["id"] as int,
        fromDate: json["from_date"],
        toDate: json["to_date"],
        amount: json["amount"],
        rate: json["rate"],
        total: json["total"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "from_date": fromDate,
        "to_date": toDate,
        "amount": amount,
        "rate": rate,
        "total": total,
      };
}