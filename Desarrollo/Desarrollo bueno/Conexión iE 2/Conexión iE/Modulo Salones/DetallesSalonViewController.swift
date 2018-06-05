//
//  DetallesSalonViewController.swift
//  Conexión iE
//
//  Created by Cesar Avila on 17/10/17.
//  Copyright © 2017 Cesar Avila. All rights reserved.
//

import UIKit
import MapKit

class DetallesSalonViewController: UIViewController{
    @IBOutlet weak var nivelSalon: UIImageView! // VARIABLE DECLARADA PARA LA FOTO DEL NIVEL
    @IBOutlet weak var escomMapa: MKMapView! // VARIABLE DECLARADA PARA EL MAPA
    @IBOutlet weak var tituloMapa: UILabel! // VARIABLE DECLARADA PARA EL TITULO DEL MAPA
    @IBOutlet weak var segmentedControl: UISegmentedControl! // VARAIBLE DECLARADA PARA EL SEGMENTCONTROL NIVEL-SALON
    // PROGRAMANDO LA VISTA QUE SE MOSTRARA CON BASE EN LA ELECCION DEL SEGMENTCONTROL SELECCIONADO
    @IBAction func eleccionNivelSalon(_ sender: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex{
        case 0:
            if let fotonivelSalon = salon.imagenNivel{
                self.nivelSalon.image = UIImage(named: fotonivelSalon)
            }
        case 1:
            if let fotonivelSalon = salon.imagenSalon{
                self.nivelSalon.image = UIImage(named: fotonivelSalon)
            }
        default:
            break
        }
    }
    
   // DECLARANDO VARAIBLE SALON
    var salon : Salon!
    let locationManager = CLLocationManager() // VARIABLE PARA LA LOCALIZACIÓN DEL USUARIO
    let puntos = PoligonoEdificio1A.getPlaces() // DECLARANDO UNA INSTANCIA DEL OBJETO POLIGONO EDIFICIO 1A PARA LOS PUNTOS DEL POLIGONO
    let puntosEB = PoligonoEdificio1B.getPlaces() // DECLARANDO UNA INSTANCIA DEL OBJETO POLIGONO EDIFICIO 1B PARA LOS PUNTOS DEL POLIGONO
     let puntosEC = PoligonoEdificioCentral.getPlaces() // DECLARANDO UNA INSTANCIA DEL OBJETO POLIGONO EDIFICIO CENTRAL PARA LOS PUNTOS DEL POLIGONO
    let puntosE2A = PoligonoEdificio2A.getPlaces() // DECLARANDO UNA INSTANCIA DEL OBJETO POLIGONO EDIFICIO CENTRAL PARA LOS PUNTOS DEL POLIGONO
     let puntosE2B = PoligonoEdificio2B.getPlaces() // DECLARANDO UNA INSTANCIA DEL OBJETO POLIGONO EDIFICIO CENTRAL PARA LOS PUNTOS DEL POLIGONO
    
    override func viewDidLoad() {
        pedirUbicacion()
       
       // addPolyline()
        addPolygon()
        self.title = "Ubicación del salón: \(self.salon.nombreSalon!)"
        self.tituloMapa.text = "Edificio \(self.salon.numeroEdifico!)"
        if let fotonivelSalon = salon.imagenNivel{
            self.nivelSalon.image = UIImage(named:fotonivelSalon)
        }
// =========================================================================
//PROGRAMACIÓN DEL MAPA DE ESCOM
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
        //  AÑADIR MARCADOR AL MAPA QUE ESTAMOS VIENDO
/*      let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = "Escuela Superior de Cómputo"
        escomMapa.addAnnotation(annotation)
*/
    }
//=============================================================================================================
    // FUNCION PARA PEDIR AL USUARIO QUE NOS DEJE VER SU APLICACIÓN, TUVIMOS QUE AGREGAR UN ATRIBUTO EN EL MAPKITSTARTER
    func pedirUbicacion() {
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
        let latitudSalon = Double(salon.latitudSalon!)
        let longitudSalon = Double(salon.longitudSalon!)
        let locationEdificioESCOM : CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitudSalon!, longitudSalon!)
        let edificioESCOM = MKPointAnnotation()
        edificioESCOM.coordinate = locationEdificioESCOM
        edificioESCOM.subtitle = "\(salon.numeroEdifico!)"
        escomMapa.addAnnotation(edificioESCOM)
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
        switch self.salon.numeroEdifico {
        case "1A":
            // EDIFICIO 1A
            var locations = puntos.map {$0.coordinate}
            let polygon = MKPolygon(coordinates: &locations, count: locations.count)
            escomMapa?.add(polygon)
        case "1B":
            // EDIFICIO 1B
            var locationsEB = puntosEB.map {$0.coordinate}
            let polygonEB = MKPolygon(coordinates: &locationsEB, count: locationsEB.count)
            escomMapa?.add(polygonEB)
        case "2A":
            // EDIFICIO 2A
            var locationsE2A = puntosE2A.map {$0.coordinate}
            let polygonE2A = MKPolygon(coordinates: &locationsE2A, count: locationsE2A.count)
            escomMapa?.add(polygonE2A)
        case "2B":
            // EDIFICIO 2B
            var locationsE2B = puntosE2B.map {$0.coordinate}
            let polygonE2B = MKPolygon(coordinates: &locationsE2B, count: locationsE2B.count)
            escomMapa?.add(polygonE2B)
        case "Central":
            // EDIFICIO CENTRAL
            var locationsEC = puntosEC.map {$0.coordinate}
            let polygonEC = MKPolygon(coordinates: &locationsEC, count: locationsEC.count)
            escomMapa?.add(polygonEC)
        default:
            break
        }
    }
    @IBAction func close(segue: UIStoryboardSegue){
        
    }
    // FUNCION PARA MANDAR LA INFORMACIÓN DEL NOMBRE DEL SALON A LA PANTALLA EDIFICIOSVIEWCONTROLLER
    // ESTO MEDIANTE LA VARIABLE NOMBRE QUE ESTA DEFINIDA EN ESA PANTALLA
    // DECIMOS QUE PASE LOS DATOS AL DESTIONATION EDIFICIOSVIEWCONTROLLER
    // DESPUES LE ASIGNAMOS EL NUMERO DE EDIFICIO A LA VARIABLE NOMBRE
    // ESTO QUIERE DECIR QUE CUANDO TOQUEMOS EL BOTON DE INFO ESTE MANDARA POR MEDIO DE ESE SEGUE EL NUMERO DE EDIFICIO QUE SE HA SELECCIONADO
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let DestViewController : EdificiosViewController = segue.destination as! EdificiosViewController
        
            DestViewController.nombre = self.salon.numeroEdifico
    }
    

}
extension DetallesSalonViewController:MKMapViewDelegate{
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
