//
//  PrijevOsApp.swift
//  PrijevOs
//
//  Created by user236283 on 2/1/23.
//

import SwiftUI



@main
struct PrijevOsApp: App {
    @StateObject var stationData: StationData = StationData()
    var data: DateUtility = DateUtility()
    var body: some Scene {
        WindowGroup {
            
           
            
            TabView{
                PrijevOsView()
                    .tabItem {
                        Label("Map", systemImage: "map.circle.fill")
                    }
                StationsView()
                    .tabItem{
                        Label("Stations", systemImage: "tram.circle.fill")
                        
                    }
            }
                
                    .environmentObject(stationData)
                    .task(stationData.fetchRoutes)
                    .task(stationData.fetchSchedule)
                    .task(stationData.fetchTramStations)
                    .environmentObject(data)
            }
    }
}

