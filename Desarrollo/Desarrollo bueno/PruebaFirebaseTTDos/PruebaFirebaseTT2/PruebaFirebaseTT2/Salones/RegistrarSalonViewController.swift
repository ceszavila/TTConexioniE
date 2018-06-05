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

var refSalones : DatabaseReference!

class RegistrarSalonViewController: UIViewController {
    @IBOutlet weak var lalutidlbl: UILabel!
    @IBOutlet weak var longitudlbl: UILabel!
    @IBOutlet weak var nombreSalon: UITextField!
    @IBOutlet weak var grupoSalon: UITextField!
    @IBOutlet weak var nivelSalon: UISegmentedControl!
    @IBOutlet weak var edificioSalon: UISegmentedControl!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var msjlbl: UILabel!
    
    var salonList = [Salon]()
    var nivel : String = ""
    var edificio : String = ""
    let locationManager = CLLocationManager() // VARIABLE PARA LA LOCALIZACIÓN DEL USUARIO
    let puntos = PoligonoEdificio1A.getPlaces()// DECLARANDO UNA INSTANCIA DEL OBJETO POLIGONO EDIFICIO 1A PARA LOS PUNTOS DEL POLIGONO
    let puntosuno = PoligonoEdificio1B.getPlaces()
    let puntosdos = PoligonoEdificio2A.getPlaces()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
        msjlbl.text = ""
        //Descomentar, si el tap no debe interferir o cancelar otras acciones
        tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tap)
        
        refSalones = Database.database().reference().child("salones");
        
        pedirUbicacion()
        addAnnotations()
        addPolyline()
        mapView.delegate = self
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
        mapView.setRegion(region, animated: true)
    }
    
    @objc func dismissKeyboard() {
        //Las vistas y toda la jerarquía renuncia a responder, para esconder el teclado
        view.endEditing(true)
    }
    
    @IBAction func handleLongTap(gestureReconizer: UILongPressGestureRecognizer) {
      
            let annotationsToRemove = mapView.annotations.filter
            { $0 !== mapView.userLocation }
            mapView.removeAnnotations( annotationsToRemove )
            print("funcionando")
            addAnnotations()
            // add new annon
            let location = gestureReconizer.location(in: mapView)
            let coordinate = mapView.convert(location, toCoordinateFrom: mapView)
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            mapView.addAnnotation(annotation)
            lalutidlbl.text = "\(coordinate.latitude)"
            longitudlbl.text = "\(coordinate.longitude)"
        
        
        
        
        
    }
    
    
  /*  @IBAction func handleTap(_ sender: UITapGestureRecognizer) {
        let annotationsToRemove = mapView.annotations.filter
        { $0 !== mapView.userLocation }
        mapView.removeAnnotations( annotationsToRemove )
        print("LongTouch")
    }
    
    */
    
    
   
    
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
        mapView?.delegate = self
        //escomMapa?.addAnnotations(edificios)
        // necesitamos decirle a MapKit que queremos mostrar superposiciones en nuestro mapa
        // let overlays = edificios.map { MKCircle(center: $0.coordinate, radius: 1) }
        // escomMapa?.addOverlays(overlays) // Agregando la superposicion
        
        // AÑADIENDO EL MARCADOR AL MAPA
        // MARCADORES PARA EDIFCIOS
       let latitudSalon = Double(19.5051637586259)
        let longitudSalon = Double(-99.1458884448829)
        let locationEdificioESCOM : CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitudSalon, longitudSalon)
        let edificioESCOM = MKPointAnnotation()
        edificioESCOM.coordinate = locationEdificioESCOM
        edificioESCOM.subtitle = "Entrada Principal"
        mapView.addAnnotation(edificioESCOM)
        
        let latCafeteria = Double(19.5041899695014)
        let longCafeteria = Double(-99.1477566436529)
        let locationCafeteria : CLLocationCoordinate2D = CLLocationCoordinate2DMake(latCafeteria, longCafeteria)
        let cafeteria = MKPointAnnotation()
        cafeteria.coordinate = locationCafeteria
        cafeteria.subtitle = "Cafeteria"
        mapView.addAnnotation(cafeteria)
        
       let latEntradaMetro = Double(19.5037154329629)
        let longEntradaMetro = Double(-99.1475034737054)
        let locationEntradaMetro : CLLocationCoordinate2D = CLLocationCoordinate2DMake(latEntradaMetro, longEntradaMetro)
        let entradaMetro = MKPointAnnotation()
        entradaMetro.coordinate = locationEntradaMetro
        entradaMetro.subtitle = "Entrada Secundaria"
        mapView.addAnnotation(entradaMetro)
        
       let latBarraCafe = Double(19.5047582434172)
        let longBarraCafe = Double(-99.1469187110126)
        let locationBarraCafe : CLLocationCoordinate2D = CLLocationCoordinate2DMake(latBarraCafe, longBarraCafe)
        let barraCafe = MKPointAnnotation()
        barraCafe.coordinate = locationBarraCafe
        barraCafe.subtitle = "Barra de café"
        mapView.addAnnotation(barraCafe)
 
    }
    
    // FUNCION PARA CREAR POLILINEAS
    func addPolyline(){
        mapView.delegate = self
        var locations = puntos.map{$0.coordinate }
        let polyline = MKPolyline(coordinates: &locations, count: locations.count)
        mapView?.add(polyline)
        var locationsuno = puntosuno.map {$0.coordinate}
        let polygonuno = MKPolyline(coordinates: &locationsuno, count: locationsuno.count)
        mapView?.add(polygonuno)
        var locationsdos = puntosdos.map {$0.coordinate}
        let polygondos = MKPolyline(coordinates: &locationsdos, count: locationsdos.count)
        mapView?.add(polygondos)
    }
    // FUNCION PARA CREAR EL POLIGONO DEL EDIFICIO 1
    func addPolygon(){
        mapView.delegate = self
        var locations = puntos.map {$0.coordinate}
        let polygon = MKPolygon(coordinates: &locations, count: locations.count)
        mapView?.add(polygon)
    }
    
    
    @IBAction func eleccionNivel(_ sender: UISegmentedControl) {
        switch nivelSalon.selectedSegmentIndex {
        case 0:
            nivel = "PlantaBaja"
        case 1:
            nivel = "PrimerPiso"
        case 2:
            nivel = "SegundoPiso"
        default:
            break
        }
    }
    
    @IBAction func eleccionEdificio(_ sender: UISegmentedControl) {
        switch edificioSalon.selectedSegmentIndex {
        case 0:
            edificio = "1A"
        case 1:
            edificio = "2A"
        case 2:
            edificio = "1B"
        case 3:
            edificio = "2B"
        case 4:
            edificio = "Central"
        default:
            break
        }
    }
    
    
    
    
    @IBAction func registrarSalon(_ sender: Any) {
        if(nombreSalon.text != "" && grupoSalon.text != "" && lalutidlbl.text != "" && longitudlbl.text != ""){
    let key = refSalones.childByAutoId().key
        let salon = ["id_salon" : key,
                     "nombre_salon" : nombreSalon.text! as String,
                     "grupo_salon" : grupoSalon.text! as String,
                     "imagenaerea_salon" : nivel as String,
                     "imagennivel_salon" : nivel as String,
                     "latitud_salon" : lalutidlbl.text! as String,
                     "longitud_salon" : longitudlbl.text! as String,
                     "numero_edificio" : edificio as String
                     ]
        refSalones.child(key).setValue(salon)
        msjlbl.text = "El salón se registró exitosamente"
        
        nombreSalon.text = ""
        grupoSalon.text = ""
        lalutidlbl.text = ""
        longitudlbl.text = ""
        
        }else{
            msjlbl.textColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
            msjlbl.text = "Faltan campos obligtorios"
        }
    }
}

extension RegistrarSalonViewController:MKMapViewDelegate{
    // Función de Marcador Personalizado
    // EN ESTA FUNCION ESAMOS PERZONALIZANDO LOS POLIGONOS CON QUE COLOR SE VAN A DIBUJAR Y QUE TAMAÓ TNEDRA LA LINEA
    // comprobamos qué tipo de superposición estamos representando y actuamos en consecuencia.
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKPolyline {
            let renderer = MKPolylineRenderer(overlay: overlay)
            renderer.strokeColor = UIColor.black
            renderer.lineWidth = 2
            return renderer
        } else if overlay is MKPolygon{
            let renderer = MKPolygonRenderer(overlay:overlay)
            renderer.fillColor = UIColor.yellow.withAlphaComponent(0.5)
            renderer.strokeColor = UIColor.yellow
            renderer.lineWidth = 1
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
}

