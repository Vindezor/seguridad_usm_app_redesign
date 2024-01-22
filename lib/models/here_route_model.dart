// To parse this JSON data, do
//
//     final hereRouteModel = hereRouteModelFromJson(jsonString);

import 'dart:convert';

HereRouteModel hereRouteModelFromJson(String str) => HereRouteModel.fromJson(json.decode(str));

String hereRouteModelToJson(HereRouteModel data) => json.encode(data.toJson());

class HereRouteModel {
    List<Notice>? notices;
    List<Route> routes;

    HereRouteModel({
        required this.notices,
        required this.routes,
    });

    factory HereRouteModel.fromJson(Map<String, dynamic> json) => HereRouteModel(
        notices: json["notices"] != null ? List<Notice>.from(json["notices"].map((x) => Notice.fromJson(x))) : null,
        routes: List<Route>.from(json["routes"].map((x) => Route.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "notices": notices != null ? List<dynamic>.from(notices!.map((x) => x.toJson())) : null,
        "routes": List<dynamic>.from(routes.map((x) => x.toJson())),
    };
}

class Notice {
    String title;
    String code;
    String severity;

    Notice({
        required this.title,
        required this.code,
        required this.severity,
    });

    factory Notice.fromJson(Map<String, dynamic> json) => Notice(
        title: json["title"],
        code: json["code"],
        severity: json["severity"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "code": code,
        "severity": severity,
    };
}

class Route {
    String id;
    List<Section> sections;

    Route({
        required this.id,
        required this.sections,
    });

    factory Route.fromJson(Map<String, dynamic> json) => Route(
        id: json["id"],
        sections: List<Section>.from(json["sections"].map((x) => Section.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "sections": List<dynamic>.from(sections.map((x) => x.toJson())),
    };
}

class Section {
    String id;
    String type;
    Arrival departure;
    Arrival arrival;
    Summary summary;
    String polyline;
    Transport transport;

    Section({
        required this.id,
        required this.type,
        required this.departure,
        required this.arrival,
        required this.summary,
        required this.polyline,
        required this.transport,
    });

    factory Section.fromJson(Map<String, dynamic> json) => Section(
        id: json["id"],
        type: json["type"],
        departure: Arrival.fromJson(json["departure"]),
        arrival: Arrival.fromJson(json["arrival"]),
        summary: Summary.fromJson(json["summary"]),
        polyline: json["polyline"],
        transport: Transport.fromJson(json["transport"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "departure": departure.toJson(),
        "arrival": arrival.toJson(),
        "summary": summary.toJson(),
        "polyline": polyline,
        "transport": transport.toJson(),
    };
}

class Arrival {
    DateTime time;
    Place place;

    Arrival({
        required this.time,
        required this.place,
    });

    factory Arrival.fromJson(Map<String, dynamic> json) => Arrival(
        time: DateTime.parse(json["time"]),
        place: Place.fromJson(json["place"]),
    );

    Map<String, dynamic> toJson() => {
        "time": time.toIso8601String(),
        "place": place.toJson(),
    };
}

class Place {
    String type;
    Location location;
    Location originalLocation;

    Place({
        required this.type,
        required this.location,
        required this.originalLocation,
    });

    factory Place.fromJson(Map<String, dynamic> json) => Place(
        type: json["type"],
        location: Location.fromJson(json["location"]),
        originalLocation: Location.fromJson(json["originalLocation"]),
    );

    Map<String, dynamic> toJson() => {
        "type": type,
        "location": location.toJson(),
        "originalLocation": originalLocation.toJson(),
    };
}

class Location {
    double lat;
    double lng;

    Location({
        required this.lat,
        required this.lng,
    });

    factory Location.fromJson(Map<String, dynamic> json) => Location(
        lat: json["lat"]?.toDouble(),
        lng: json["lng"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "lat": lat,
        "lng": lng,
    };
}

class Summary {
    int duration;
    int length;
    int baseDuration;

    Summary({
        required this.duration,
        required this.length,
        required this.baseDuration,
    });

    factory Summary.fromJson(Map<String, dynamic> json) => Summary(
        duration: json["duration"],
        length: json["length"],
        baseDuration: json["baseDuration"],
    );

    Map<String, dynamic> toJson() => {
        "duration": duration,
        "length": length,
        "baseDuration": baseDuration,
    };
}

class Transport {
    String mode;

    Transport({
        required this.mode,
    });

    factory Transport.fromJson(Map<String, dynamic> json) => Transport(
        mode: json["mode"],
    );

    Map<String, dynamic> toJson() => {
        "mode": mode,
    };
}
