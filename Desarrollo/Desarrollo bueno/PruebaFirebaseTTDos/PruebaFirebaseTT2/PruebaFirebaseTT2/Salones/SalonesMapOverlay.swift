//
//  SalonesMapOverlay.swift
//  PruebaFirebaseTT2
//
//  Created by Cesar Avila on 09/05/18.
//  Copyright © 2018 Cesar Avila. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class SalonesMapOverlay:NSObject,MKOverlay{
    var coordinate: CLLocationCoordinate2D
    var boundingMapRect: MKMapRect
    
    init(park: Park) {
        boundingMapRect = park.overlayBoundingMapRect
        coordinate = park.midCoordinate
    }
}
