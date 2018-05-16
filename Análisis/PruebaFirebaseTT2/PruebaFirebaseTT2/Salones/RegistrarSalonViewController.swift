//
//  RegistrarSalonViewController.swift
//  PruebaFirebaseTT2
//
//  Created by Cesar Avila on 23/04/18.
//  Copyright © 2018 Cesar Avila. All rights reserved.
//

import UIKit
import Firebase
import MapKit

class RegistrarSalonViewController: UIViewController {
    @IBOutlet weak var lalutidlbl: UILabel!
    @IBOutlet weak var longitudlbl: UILabel!
    @IBOutlet weak var nombreSalon: UITextField!
    @IBOutlet weak var grupoSalon: UITextField!
    @IBOutlet weak var nivelSalon: UISegmentedControl!
    @IBOutlet weak var edificioSalon: UISegmentedControl!
    
    
    
    @IBOutlet weak var escomMapa: MKMapView!
    
    
    
    var salon : Salon!
    let locationManager = CLLocationManager() // VARIABLE PARA LA LOCALIZACIÓN DEL USUARIO
    let puntos = PoligonoEdificio1A.getPlaces() // DECLARANDO UNA INSTANCIA DEL OBJETO POLIGONO EDIFICIO 1A PARA LOS PUNTOS DEL POLIGONO
    
    override func viewDidLoad() {
        addAnnotations()
        addPolyline()
        escomMapa.delegate = self
        // CREANDO LA LATITUD Y LONGITUD DEL MAPA
        let latitude : CLLocationDegrees = 19.5047729
        let longitude : CLLocationDegrees = -99.1467951
        // CREAMOS EL CAMPO DE VISIÓN DEL MAPA, ES DECIR, LA EXTENSIÓN DE ÁREA VISIBLE CUANDO ESTE CARGUE
        let latDelta : CLLocationDegrees = 0.0015
        let longDelta : CLLocationDegrees = 0.0015
        // CON LA LATITUD, LATITUD Y EL CAMPO DE VISIÓN PODEMOS CREAL EL SPAN Y LA LOCATION
        let span : MKCoordinateSpan = MKCoordinateSpanMake(latDelta, longDelta)
        let location : CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        // CREANDO REGIÓN FINAL
        let region : MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        // AÑADIR REGIÓN AL MAPA
        escomMapa.setRegion(region, animated: true)
        
        /*let gestureRecognizer = UITapGestureRecognizer(target: self, action:Selector(("handleTap:")))
        gestureRecognizer.delegate = (self as? UIGestureRecognizerDelegate)
        escomMapa.addGestureRecognizer(gestureRecognizer)
        */
        
        
    }
    
   /* func handleTap(gestureReconizer: UILongPressGestureRecognizer) {
        
        let location = gestureReconizer.location(in: escomMapa)
        let coordinate = escomMapa.convert(location,toCoordinateFrom: escomMapa)
        
        // Add annotation:
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        escomMapa.addAnnotation(annotation)
        
    }*/
    
    func pedirUbicacion(){
        let status = CLLocationManager.authorizationStatus()
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            return
        case .denied, .restricted:
            print("location access denied")
        default:
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func addAnnotations() { // AGREGANDO ANOTACIONES PERZONALIZADAS AL MAPA
        escomMapa?.delegate = self
        //escomMapa?.addAnnotations(edificios)
        // necesitamos decirle a MapKit que queremos mostrar superposiciones en nuestro mapa
        // let overlays = edificios.map { MKCircle(center: $0.coordinate, radius: 1) }
        // escomMapa?.addOverlays(overlays) // Agregando la superposicion
        
        // AÑADIENDO EL MARCADOR AL MAPA
        // MARCADORES PARA EDIFCIOS
        let latitudSalon = Double(19.504566)
        let longitudSalon = Double(-99.146918)
        let locationEdificioESCOM : CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitudSalon, longitudSalon)
        let edificioESCOM = MKPointAnnotation()
        edificioESCOM.coordinate = locationEdificioESCOM
        edificioESCOM.subtitle = "ESCOM"
        escomMapa.addAnnotation(edificioESCOM)
        lalutidlbl.text = "\(latitudSalon)"
        longitudlbl.text = "\(longitudSalon)"
    }
    
    // FUNCION PARA CREAR POLILINEAS
    func addPolyline(){
        escomMapa.delegate = self
        var locations = puntos.map{$0.coordinate }
        let polyline = MKPolyline(coordinates: &locations, count: locations.count)
        escomMapa?.add(polyline)
    }
    // FUNCION PARA CREAR EL POLIGONO DEL EDIFICIO 1
    func addPolygon(){
        escomMapa.delegate = self
        var locations = puntos.map {$0.coordinate}
        let polygon = MKPolygon(coordinates: &locations, count: locations.count)
        escomMapa?.add(polygon)
    }
    
}

extension RegistrarSalonViewController:MKMapViewDelegate{
    // Función de Marcador Personalizado
    // EN ESTA FUNCION ESAMOS PERZONALIZANDO LOS POLIGONOS CON QUE COLOR SE VAN A DIBUJAR Y QUE TAMAÓ TNEDRA LA LINEA
    // comprobamos qué tipo de superposición estamos representando y actuamos en consecuencia.
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKPolyline {
            let renderer = MKPolylineRenderer(overlay: overlay)
            renderer.strokeColor = UIColor.orange
            renderer.lineWidth = 5
            return renderer
        } else if overlay is MKPolygon{
            let renderer = MKPolygonRenderer(overlay:overlay)
            renderer.fillColor = UIColor.yellow.withAlphaComponent(0.5)
            renderer.strokeColor = UIColor.yellow
            renderer.lineWidth = 5
            addAnnotations()
            return renderer
            
        }
        return MKOverlayRenderer()
    }
}

extension RegistrarSalonViewController:CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error de localización")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let newLocation = locations.last else {return}
        let userCord = newLocation.coordinate
        let latitud = Double(userCord.latitude)
        let longitud = Double(userCord.longitude)
        
        lalutidlbl.text = "\(latitud)"
        longitudlbl.text = "\(longitud)"
    }
}

