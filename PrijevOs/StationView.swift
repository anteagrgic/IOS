//
//  StopView.swift
//  PrijevOs
//
//  Created by user236283 on 2/1/23.
//

import SwiftUI
import MapKit



extension String: Identifiable{
    public var id: String {self}
}


struct StationView: View {
    var tramStation: TramStation
    @EnvironmentObject var date: DateUtility
    @EnvironmentObject var stationData: StationData
    var schedules: [Schedule]{
        return stationData.schedules.filter{ schedule in
            return schedule.stationId == tramStation.id
        }
    }
    var routes:[Route]{
        var routes: [Route] = []
        for schedule in schedules {
            let route = stationData.routes.filter{ route in
                return schedule.routeID == route.id
            }.first
            routes.append(route!)
        }
        return routes
        
    }
    
    var routeNumbers: [String]{
        var numbers: [String] = []
        for route in routes{
            if !numbers.contains(route.number){
                numbers.append(route.number)
            }
        }
        return numbers
    }
    
    var body: some View {
            VStack{
                Spacer()
                HStack{
                    Image(systemName: "tram.fill")
                        .foregroundColor(Color(hue: 0.624, saturation: 1.0, brightness: 1.0))
                        .frame(width: 0.0, height: 0.0)
                        .font(.largeTitle)
                        .padding(EdgeInsets(top: 0, leading: 20, bottom: 15, trailing: 15))
                    
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 1, trailing: 0))
                    
                    Text(tramStation.name)
                        .font(.title3)
                        .foregroundColor(.black)
                        .padding(EdgeInsets(top: 0, leading:0, bottom: 15, trailing: 0))
                    Spacer()
                    
                }
                
                
                HStack{
                    
                    Text("Routes:")
                        .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0))
                        
                    ForEach(routes) { route in
                        if route.id != routes.last?.id {
                            Text(route.number + ",")
                                .foregroundColor(.black.opacity(0.7))
                        }
                        else{
                            Text(route.number)
                                .foregroundColor(.black.opacity(0.7))
                        }
                    }
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    
                    Spacer()
                }
                
                HStack{
                    Image(systemName: "arrow.right")
                        .foregroundColor(Color(hue: 0.624, saturation: 1.0, brightness: 1.0))
                        .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0))
                    ForEach(routes.prefix(1)) { route in
                        if route.id != routes.prefix(1).last?.id {
                            Text(route.destination + ",")
                                .fixedSize()
                                .foregroundColor(.black.opacity(0.7))
                        }
                        else{
                            Text(route.destination + "...")
                                .foregroundColor(.black.opacity(0.7))
                        }
                    }
                    Spacer()
                }
                .padding(EdgeInsets(top: -5, leading: 0, bottom: 0, trailing: 0))
                Spacer()
                    
                
            }
           
    }
}

struct StationView_Previews: PreviewProvider {
    static var previews: some View {
        StationView(tramStation: TramStation(name: "STROSSMAYEROVA 247 / KOLODVORRETFALA III", latitude: 45.56515657560434,  longitude: 18.648036364999744))
            .environmentObject(StationData())
    }
}
