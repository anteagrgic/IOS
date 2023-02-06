//
//  MAP.swift
//  PrijevOs
//
//  Created by user236283 on 2/2/23.
//

import MapKit
import SwiftUI
import UIKit


class StationAnnotation: MKPointAnnotation {
    var station: TramStation
    init(station: TramStation) {
        self.station = station
        super.init()
        self.coordinate = CLLocationCoordinate2D(latitude:station.latitude, longitude: station.longitude)
        self.title = station.name
    }
}


struct MapView: UIViewRepresentable {
    
    @EnvironmentObject var stationData: StationData
    let osijekLocation = CLLocation(latitude: 45.5550, longitude: 18.6955)
    
    
    var annotations: [MKAnnotation]{
            var annotations: [MKAnnotation] = []
            for station in stationData.stations {
                let annotation = StationAnnotation(station: station)
                annotations.append(annotation)
            }
            return annotations
        }
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView(frame: .zero)
        mapView.delegate = context.coordinator
        return mapView
    }
    
    func updateUIView(_ view: MKMapView, context: Context) {
        view.centerToLocation(osijekLocation)
        view.addAnnotations(annotations)
        
    }
    
    func makeCoordinator() -> Coordinator {
            Coordinator(self)
        }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView
        init(_ parent: MapView) {
                self.parent = parent
            }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            let identifier = "station"
            if annotation is StationAnnotation {
                let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) ??
                    MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                annotationView.image = UIImage(systemName: "mappin.and.ellipse")?.withTintColor(UIColor(hue: 0.624, saturation: 1.0, brightness: 1.0, alpha: 0.1))
                
                    
                
                
                return annotationView
            }
            return nil
        }
        
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            if overlay is MKPolyline {
                let renderer = MKPolylineRenderer(overlay: overlay)
                renderer.strokeColor = .blue
                renderer.lineWidth = 5
                return renderer
            }
            return MKOverlayRenderer()
        }
    }
}


private extension MKMapView {
    
    func centerToLocation( _ location: CLLocation, regionRadius: CLLocationDistance = 3000) {
        let coordinateRegion = MKCoordinateRegion(
            center: location.coordinate,
            latitudinalMeters: regionRadius,
            longitudinalMeters: regionRadius)
        setRegion(coordinateRegion, animated: true)
    }
    
    
}

struct Place: Identifiable {
  let id = UUID()
  var name: String
  var coordinate: CLLocationCoordinate2D
}



