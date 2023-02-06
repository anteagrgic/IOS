//
//  StationsView.swift
//  PrijevOs
//
//  Created by user236283 on 2/2/23.
//

import SwiftUI
import MapKit
import UIKit

struct StationsView: View {
    
    @State var query: String = ""
    
    @EnvironmentObject var stationData: StationData
    
    var foundStations: [TramStation]{
        return stationData.stations.filter{ station in
            return station.name.lowercased()
                .contains(query.lowercased())
        }
        .sorted(by: { $0.name < $1.name })
    }
    
    
    var foundStops: [TramStation]{
        return stationData.stations.filter{ station in
            return station.name.lowercased()
                .contains(query.lowercased())
        }
    }
    
    
    var body: some View {
        
        NavigationView{
            VStack{
                HStack{
                    TextField("Search station", text: $query)
                        .textFieldStyle(.roundedBorder)
                    Image(systemName:"location.magnifyingglass")
                        .foregroundColor(.blue)
                        .font(.title2)
                }
                .padding()
                
                if query != "" {
                    List(foundStops) {station in
                        NavigationLink(destination: TramStationDataView(station: station)){
                            StationView(tramStation: station)
                        }
                    }
                    .listStyle(.plain)
                    .frame(alignment: .leading)
                }
                else {
                    List(stationData.stations) { station in
                        NavigationLink(destination: TramStationDataView(station: station)){
                            StationView(tramStation: station)
                        }
                    }
                    .listStyle(.plain)
                    .frame(alignment: .leading)
                }
                
                Spacer()
            }
            
        }
    }
}
   

struct StationsView_Previews: PreviewProvider {
    static var previews: some View {
        StationsView()
    }
}
