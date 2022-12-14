//
//  ViewController.swift
//  mapkit-tut
//
//  Created by Risetime on 14.12.2022.
//

import UIKit
import MapKit
import CoreLocation
import CoreData

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate{
        
    var selectedLocation : LocationModel?
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var noteField: UITextField!
    @IBOutlet weak var nameField: UITextField!
    
    var selectedLongitude : Double?
    var selectedLatitude : Double?
    
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        mapView.delegate = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
       
        // Do any additional setup after loading the view.
        if(selectedLocation != nil){
            noteField.text = selectedLocation?.note
            nameField.text = selectedLocation?.name
            saveButton.isEnabled = false
            locationManager.stopUpdatingLocation()
            
        } else {
           
            let gestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(selectLocation(gestureRecognizer: )))
            
            gestureRecognizer.minimumPressDuration = 2
            mapView.addGestureRecognizer(gestureRecognizer)
        }
        
        super.viewDidLoad()
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if(selectedLocation != nil){
            let location = CLLocationCoordinate2D(latitude: selectedLocation?.latitude as? CLLocationDegrees ?? CLLocationDegrees() , longitude: selectedLocation?.longitude as? CLLocationDegrees ?? CLLocationDegrees())
            let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
            let region = MKCoordinateRegion(center: location, span:span)
            mapView.setRegion(region, animated: true)
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = location
            annotation.title = selectedLocation?.name
            annotation.subtitle = selectedLocation?.note
            self.mapView.addAnnotation(annotation)
        }
        else {
            let location = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
            
            let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
            let region = MKCoordinateRegion(center: location, span:span)
            mapView.setRegion(region, animated: true)
        }
        
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation is MKUserLocation {
            return nil
        }
        
        let reuseId = "myLocation"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKMarkerAnnotationView
        
        if pinView == nil {
            pinView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView?.canShowCallout = true
            pinView?.tintColor = UIColor.black
            
            let button = UIButton(type: UIButton.ButtonType.detailDisclosure)
            pinView?.rightCalloutAccessoryView = button
            
        } else {
            pinView?.annotation = annotation
        }
        
        return pinView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if selectedLocation != nil {
            print("selectedLocation is not nil")
            let requestLocation = CLLocation(latitude: CLLocationDegrees(selectedLocation!.latitude), longitude: CLLocationDegrees(selectedLocation!.longitude))
                
            CLGeocoder().reverseGeocodeLocation(requestLocation) {
                (placemarks, error) in
                if let placemark = placemarks {
                    if placemark.count > 0{
                        let newPlacemark = MKPlacemark(placemark: placemark[0])
                        let item = MKMapItem(placemark: newPlacemark)
                        item.name = self.selectedLocation!.name
                        let launchOptions = [MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving]
                        item.openInMaps(launchOptions: launchOptions)
                        
                    }
                }
            }
        }
        
    }
    
    @objc func selectLocation(gestureRecognizer : UILongPressGestureRecognizer){
        print("heyyo")
        
        if gestureRecognizer.state == .began {
            
            let touchedPoint = gestureRecognizer.location(in: self.mapView)
            let touchedCoordinate = self.mapView.convert(touchedPoint, toCoordinateFrom: self.mapView)
            
            selectedLatitude = touchedCoordinate.latitude
            selectedLongitude = touchedCoordinate.longitude
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = touchedCoordinate
            
            annotation.title = nameField.text
            annotation.subtitle = noteField.text
            
            self.mapView.addAnnotation(annotation)
        }
    }
    
    @objc func addLocation() {
       
    }

    @IBAction func saveLocation(_ sender: Any) {
        if(selectedLatitude == nil && selectedLongitude == nil){
            return
        } else {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            
            let newPlace = NSEntityDescription.insertNewObject(forEntityName: "LocationEntity", into: context)
            
            newPlace.setValue(nameField.text, forKey: "name")
            newPlace.setValue(noteField.text, forKey: "comment")
            newPlace.setValue(selectedLongitude, forKey: "longitude")
            newPlace.setValue(selectedLatitude, forKey: "latitude")
            newPlace.setValue(UUID(), forKey: "id")
            
            do {
                try context.save()
                print("success")
            } catch {
                print("error")
            }
            
            NotificationCenter.default.post(name: NSNotification.Name("newData"), object: nil)
            navigationController?.popViewController(animated: true)
        }
        
       
    }
}

