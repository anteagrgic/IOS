//
//  TramStationDataView.swift
//  PrijevOs
//
//  Created by user236283 on 2/2/23.
//

import SwiftUI
import MapKit

    
    
    
struct TramStationDataView: View {
    
    @EnvironmentObject var dateUtility: DateUtility
    @EnvironmentObject var stationData: StationData
    var station: TramStation
    
    var schedules: [Schedule]{
        return stationData.schedules.filter{ schedule in
            return schedule.stationId == station.id
        }.sorted(by: { $0.time < $1.time })
    }

    var routes: [Route] {
        var routes: [Route] = []
        for schedule in self.schedules {
            let route = stationData.routes.filter{  route in
                return route.id == schedule.routeID
            }.first
            routes.append(route!)
        }
        return routes
    }

    var routeNumbers: [String]{
        var numbers:[String] = []
        for route in self.routes {
            if !numbers.contains(route.number) {
                numbers.append(route.number)
            }
        }
        return numbers.sorted(by: { $0 < $1})
    }

    
        var body: some View {
            
            VStack{
            
                VStack{
            
                    HStack{
                        Image(systemName: "tram.tunnel.fill")
                            .foregroundColor(Color(hue: 0.624, saturation: 1.0, brightness: 1.0))
                            .padding(EdgeInsets(top: 1,leading: 0, bottom: 1, trailing: 8))
                        ForEach(routeNumbers) { number in
                            if number != routeNumbers.last {
                                Text(number + ",")
                                    .foregroundColor(.black.opacity(0.6))
                            }
                            else{
                                Text(number)
                                    .foregroundColor(.black.opacity(0.6))
                            }
                        }
                        Spacer()
                    }
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 15, trailing: 0))
                    
                    HStack{
                        Text("ROUTES")
                            .font(.subheadline)
                            .foregroundColor(.black.opacity(0.7))
                        Text("DESTINATION")
                            .font(.subheadline)
                            .foregroundColor(.black.opacity(0.7))
                        Spacer()
                        Text("ARRIVAL")
                            .font(.subheadline)
                            .foregroundColor(.black.opacity(0.7))
                    }
                }
                .padding(EdgeInsets(top: 18, leading: 18, bottom: 0, trailing: 18))
                
                List(schedules) { schedule in
                    if schedule.time >= dateUtility.dateForComparing(existingDate: schedule.time){
                        TramScheduleView(schedule: schedule)
                    }
                }
                .listStyle(.plain)
                
                Spacer()
            }
            .navigationBarTitle(Text(station.name),displayMode: .inline)
        }
    }

struct TramStationDataView_Previews: PreviewProvider {
    static var previews: some View {
        TramStationDataView(station: TramStation(name: "Okretiste Visnjevac", latitude: 45.53174, longitude: 18.67185))
            .environmentObject(DateUtility())
            .environmentObject(StationData())
    }
}
