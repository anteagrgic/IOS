//
//  ContentView.swift
//  PrijevOs
//
//  Created by user236283 on 2/1/23.
//

import SwiftUI
import MapKit

struct PlaceT: Identifiable {
  let id = UUID()
  var name: String
  var coordinate: CLLocationCoordinate2D
  var station: TramStation
}

struct ContentView: View {
    
    @EnvironmentObject var stationData: StationData
    
    var places: [PlaceT] {
        var places: [PlaceT] = []
        for station in stationData.stations{
            let place = PlaceT(name: station.name, coordinate: CLLocationCoordinate2D(latitude: station.latitude, longitude: station.longitude), station: station)
            places.append(place)
        }
        return places
    }
    
    
  @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 45.5550, longitude: 18.6955), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
  
  
  var body: some View {
    NavigationView {
      Map(coordinateRegion: $region, annotationItems: places) { place in
        MapAnnotation(coordinate: place.coordinate) {
          NavigationLink {
              TramStationDataView(station: place.station)
          } label: {
             
              PlaceAnnotationView(title: place.name)
              
          }
          //.onLongPressGesture(perform: <#T##() -> Void#>)
        }
      }
     
      .navigationBarTitleDisplayMode(.inline)
    }
  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            
    }
}
