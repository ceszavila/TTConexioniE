//
//  EditarSalonViewController.swift
//  PruebaFirebaseTT2
//
//  Created by Cesar Avila on 10/05/18.
//  Copyright © 2018 Cesar Avila. All rights reserved.
//

import UIKit
import Firebase
import MapKit

var referenceSalonesEditar : DatabaseReference!

class EditarSalonViewController: UIViewController {
    
    var salon : Salon!
    
    @IBOutlet weak var titulolbl: UILabel!
    @IBOutlet weak var editarbtnLabel: UIButton!
    @IBOutlet weak var eliminarbtnlabel: UIButton!
    @IBOutlet weak var edifcioLabel: UILabel!
    @IBOutlet weak var nivelLabel: UILabel!
    @IBOutlet weak var grupoLabel: UILabel!
    @IBOutlet weak var nombrelabel: UILabel!
    @IBOutlet weak var longitudlabel: UILabel!
    @IBOutlet weak var latitudlabel: UILabel!
    @IBOutlet weak var msjlbl: UILabel!
    @IBOutlet weak var lbllatitud: UILabel!
    @IBOutlet weak var lblLongitud: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var nombreSalon: UITextField!
    @IBOutlet weak var grupoSalon: UITextField!
    @IBOutlet weak var seleccionNivel: UISegmentedControl!
    @IBOutlet weak var seleccionEdificio: UISegmentedControl!
    var salonList = [Salon]()
    var nivel : String = ""
    var edificio : String = ""
    let puntos = PoligonoEdificio1A.getPlaces()
    let puntosuno = PoligonoEdificio1B.getPlaces()
    let puntosdos = PoligonoEdificio2A.getPlaces()
    let locationManager = CLLocationManager ()
    
    override func viewDidLoad() {
        msjlbl.text = ""
        pedirUbicacion()
        addPolyline()
        addAnnotations()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
        //Descomentar, si el tap no debe interferir o cancelar otras acciones
        tap.cancelsTouchesInView = false
        referenceSalonesEditar = Database.database().reference().child("salones");
        view.addGestureRecognizer(tap)
        super.viewDidLoad()
        let idSalon = salon.idSalon
        
        lbllatitud.text = salon.latitudSalon!
        lblLongitud.text = salon.longitudSalon!
        nombreSalon.text = salon.nombreSalon!
        grupoSalon.text = salon.grupo!
        
        mapView.delegate = self as? MKMapViewDelegate
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
        
        

        // Do any additional setup after loading the view.
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
        lbllatitud.text = "\(coordinate.latitude)"
        lblLongitud.text = "\(coordinate.longitude)"
        
        }
    
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
    
    @IBAction func eleccionNivel(_ sender: UISegmentedControl) {
        switch seleccionNivel.selectedSegmentIndex {
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
        switch seleccionEdificio.selectedSegmentIndex {
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

    @IBAction func editarSalon(_ sender: Any) {
        let idSalones = self.salon.idSalon!
        
        if(nombreSalon.text != "" && grupoSalon.text != "" && lbllatitud.text != "" && lblLongitud.text != ""){
          
            let salon = ["id_salon" : idSalones,
                         "nombre_salon" : nombreSalon.text! as String,
                         "grupo_salon" : grupoSalon.text! as String,
                         "imagenaerea_salon" : nivel as String,
                         "imagennivel_salon" : nivel as String,
                         "latitud_salon" : lbllatitud.text! as String,
                         "longitud_salon" : lblLongitud.text! as String,
                         "numero_edificio" : edificio as String
            ]
            referenceSalonesEditar.child(idSalones).setValue(salon)
            msjlbl.textColor = #colorLiteral(red: 0.3084011078, green: 0.5618229508, blue: 0, alpha: 1)
            msjlbl.text = "El salón se editó exitosamente"
            
            nombreSalon.text = ""
            grupoSalon.text = ""
            lbllatitud.text = ""
            lblLongitud.text = ""
            
        }else{
            msjlbl.textColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
            msjlbl.text = "Faltan campos obligtorios"
        }
    }
    
    func borrarSalon(idSalones:String){
        referenceSalonesEditar.child(idSalones).setValue(nil)
        editarbtnLabel.isHidden = true
        eliminarbtnlabel.isHidden = true
        edifcioLabel.isHidden = true
        nivelLabel.isHidden = true
        grupoLabel.isHidden = true
        nombrelabel.isHidden = true
        longitudlabel.isHidden = true
        latitudlabel.isHidden = true
        lblLongitud.isHidden = true
        lbllatitud.isHidden = true
        mapView.isHidden = true
        nombreSalon.isHidden = true
        grupoSalon.isHidden = true
        seleccionNivel.isHidden = true
        seleccionEdificio.isHidden = true
        msjlbl.text = "Por favor seleccione el botón atras"
        titulolbl.text = "El salón ha sido eliminado "
        
        let alertController = UIAlertController(title: "El salón se eliminó exitosamente", message: "", preferredStyle: .alert)
        let aceptarOperación = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
        alertController.addAction(aceptarOperación)
        present(alertController, animated: true, completion: nil)
        
    }
    
    @IBAction func eliminarSalon(_ sender: Any) {
        let alertController = UIAlertController(title: salon.nombreSalon, message: "", preferredStyle: .alert)
        let eliminarProfesro = UIAlertAction(title: "Eliminar", style: .destructive) { (_) in
            self.borrarSalon(idSalones: self.salon.idSalon)
        }
        let cancelarOperacion = UIAlertAction(title: "Cancelar", style: .default, handler: nil)
        alertController.addAction(eliminarProfesro)
        alertController.addAction(cancelarOperacion)
        present(alertController, animated: true, completion: nil)
    }
}

extension EditarSalonViewController:MKMapViewDelegate{
    // Función de Marcador Personalizado
    // EN ESTA FUNCION ESAMOS PERZONALIZANDO LOS POLIGONOS CON QUE COLOR SE VAN A DIBUJAR Y QUE TAMAÓ TNEDRA LA LINEA
    // comprobamos qué tipo de superposición estamos representando y actuamos en consecuencia.
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKPolyline {
            let renderer = MKPolylineRenderer(overlay: overlay)
            renderer.strokeColor = UIColor.black
            renderer.lineWidth = 1
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

extension EditarSalonViewController:CLLocationManagerDelegate{
}


