//
//  PoligonoEdificioCentral.swift
//  Conexión iE
//
//  Created by Cesar Avila on 15/10/17.
//  Copyright © 2017 Cesar Avila. All rights reserved.
//


import MapKit

@objc class PoligonoEdificioCentral: NSObject {
    var title: String?
    var subtitle: String?
    var coordinate: CLLocationCoordinate2D
    
    init(title: String?, subtitle: String?, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
    }
    
    static func getPlaces() -> [PoligonoEdificioCentral] {
        guard let path = Bundle.main.path(forResource: "PoligonoEdificioCentral", ofType: "plist"), let array = NSArray(contentsOfFile: path) else { return [] }
        
        var places = [PoligonoEdificioCentral]()
        
        for item in array {
            let dictionary = item as? [String : Any]
            let title = dictionary?["title"] as? String
            let subtitle = dictionary?["description"] as? String
            let latitude = dictionary?["latitude"] as? Double ?? 0, longitude = dictionary?["longitude"] as? Double ?? 0
            
            let place = PoligonoEdificioCentral(title: title, subtitle: subtitle, coordinate: CLLocationCoordinate2DMake(latitude, longitude))
            places.append(place)
        }
        
        return places as [PoligonoEdificioCentral]
    }
}

extension PoligonoEdificioCentral:MKAnnotation{}

