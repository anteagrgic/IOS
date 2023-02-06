//
//  StationData.swift
//  PrijevOs
//
//  Created by user236283 on 2/2/23.
//

import Foundation


struct TramStation: Identifiable, Codable{
    var id = UUID().uuidString
    let name: String
    let latitude: Double
    let longitude: Double
}


struct Route: Identifiable, Codable {
    var id = UUID().uuidString
    let number: String
    let destination: String
}

struct Schedule: Identifiable, Codable {
    var id = UUID().uuidString
    let stationId: String
    let routeID: String
    let time: Date
    }



class  StationData: ObservableObject{
    
    @Published var stations:[TramStation] = []
    @Published var routes: [Route] = []
    @Published var schedules: [Schedule] = []
    
    @MainActor @Sendable
    func fetchTramStations() async{
        do{
            let url = URL(string: "https://prijevosbase-default-rtdb.firebaseio.com/stations.json")!
            let (data, _) = try await URLSession.shared.data(from: url)
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let json = try decoder.decode([String: TramStation].self, from: data)
            stations = [TramStation](json.values)
        }catch let error{
            print(error)
        }
    }
    
    @MainActor @Sendable
    func sendTramStations(tramStation: TramStation) async{
        do {
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .iso8601
            let json = try encoder.encode(tramStation)
            let url = URL(string: "https://prijevosbase-default-rtdb.firebaseio.com/stations.json")!
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.httpBody = json
            
            let(_, response) = try await URLSession.shared.data(for: request)
            print(response)
        }catch let error {
            print(error)
        }
    }
    
    
    @MainActor @Sendable
    func fetchRoutes() async{
        do{
            let url = URL(string: "https://prijevosbase-default-rtdb.firebaseio.com/routes.json")!
            let (data, _) = try await URLSession.shared.data(from: url)
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let json = try decoder.decode([String: Route].self, from: data)
            routes = [Route](json.values)
        }catch let error{
            print(error)
        }
    }
    
    @MainActor @Sendable
    func sendRoutes(route: Route) async{
        do {
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .iso8601
            let json = try encoder.encode(route)
            let url = URL(string: "https://prijevosbase-default-rtdb.firebaseio.com/routes.json")!
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.httpBody = json
            
            let(_, response) = try await URLSession.shared.data(for: request)
            print(response)
        }catch let error {
            print(error)
        }
    }
    
    
    @MainActor @Sendable
    func fetchSchedule() async{
        do{
            let url = URL(string: "https://prijevosbase-default-rtdb.firebaseio.com/schedules.json")!
            let (data, _) = try await URLSession.shared.data(from: url)
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let json = try decoder.decode([String: Schedule].self, from: data)
            schedules = [Schedule](json.values)
        }catch let error{
            print(error)
        }
    }
    
    @MainActor @Sendable
    func sendSchedule(schedule: Schedule) async{
        do {
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .iso8601
            let json = try encoder.encode(schedule)
            let url = URL(string: "https://prijevosbase-default-rtdb.firebaseio.com/schedules.json")!
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.httpBody = json
            
            let(_, response) = try await URLSession.shared.data(for: request)
            print(response)
        }catch let error {
            print(error)
        }
    }
}
