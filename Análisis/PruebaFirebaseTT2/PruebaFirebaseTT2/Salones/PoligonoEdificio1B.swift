//
//  PoligonoEdificio1B.swift
//  Conexión iE
//
//  Created by Cesar Avila on 15/10/17.
//  Copyright © 2017 Cesar Avila. All rights reserved.
//


import MapKit

@objc class PoligonoEdificio1B: NSObject {
    var title: String?
    var subtitle: String?
    var coordinate: CLLocationCoordinate2D

    init(title: String?, subtitle: String?, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
    }

    static func getPlaces() -> [PoligonoEdificio1B] {
        guard let path = Bundle.main.path(forResource: "PoligonoEdificio1B", ofType: "plist"), let array = NSArray(contentsOfFile: path) else { return [] }

        var places = [PoligonoEdificio1B]()

        for item in array {
            let dictionary = item as? [String : Any]
            let title = dictionary?["title"] as? String
            let subtitle = dictionary?["description"] as? String
            let latitude = dictionary?["latitude"] as? Double ?? 0, longitude = dictionary?["longitude"] as? Double ?? 0

            let place = PoligonoEdificio1B(title: title, subtitle: subtitle, coordinate: CLLocationCoordinate2DMake(latitude, longitude))
            places.append(place)
        }

        return places as [PoligonoEdificio1B]
    }
}

extension PoligonoEdificio1B:MKAnnotation{}
