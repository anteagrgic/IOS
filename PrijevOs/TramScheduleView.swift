//
//  TramView.swift
//  PrijevOs
//
//  Created by user236283 on 2/2/23.
//

import SwiftUI



struct TramScheduleView: View {
    
    @EnvironmentObject var stationData: StationData
    
    @EnvironmentObject var dateUtility: DateUtility
    
    var schedule:Schedule
    
    var route: Route {
        return stationData.routes.filter{ route in
            return route.id == schedule.routeID
        }.first!
    }
    
    @State private var isCommingInFifteenMinutes = false
    @State private var isArrived = false
    let timer = Timer.publish(every: 60, on: .main, in: .common).autoconnect()
        
    private var todaySchedule: Date {
        return dateUtility.getNewDateWithTimeFromToday(schedule.time)
        }
    
    var body: some View {
        
        HStack{
            Text(route.number)
                .font(.title2)
                .foregroundColor(.blue)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 35))
            Text(route.destination)
                .font(.title2)
            Spacer()
            
            if isArrived {
                Text("Arrived")
                .font(.title2)
                .foregroundColor(.blue)
            }
            else if isCommingInFifteenMinutes {
                Text(todaySchedule, style: .relative)
                .font(.title2)
                .foregroundColor(.blue)
            }
            else {
                Text(dateUtility.display24HoursTime(date: todaySchedule))
                .font(.title2)
                .foregroundColor(.blue)
            }
        }
        .padding(.vertical)
        .task {
            self.isCommingInFifteenMinutes = todaySchedule.timeIntervalSince(Date()) < 900
            self.isArrived = todaySchedule <= Date()
        }
        .onReceive(timer){ time in
            self.isCommingInFifteenMinutes = todaySchedule.timeIntervalSince(Date()) < 900
            self.isArrived = todaySchedule <= Date()
        }
    }
}

struct TramScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        TramScheduleView( schedule: Schedule(stationId: "3", routeID: "3",
                        time: Date(timeIntervalSinceNow: TimeInterval(3630))))
        .environmentObject(StationData())
        .environmentObject(DateUtility())
    }
}
