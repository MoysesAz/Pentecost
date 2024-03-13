//
//  StatisticsPresentation.swift
//  Pentecost
//
//  Created by Moyses Miranda do Vale Azevedo on 11/03/24.
//

import SwiftUI
import Charts

struct StatisticsPresentation: View {
    @ObservedObject var vm: StatisticsVM
    @State var data: [StatisticsGoalData] = [
        StatisticsGoalData(day: "10-05-1997", min: 30.0),
        StatisticsGoalData(day: "11-05-1997", min: 40.0),
        StatisticsGoalData(day: "12-05-1997", min: 20.0),
        StatisticsGoalData(day: "13-05-1997", min: 50.0),
        StatisticsGoalData(day: "14-05-1997", min: 45.0),
        StatisticsGoalData(day: "15-05-1997", min: 60.0),
        StatisticsGoalData(day: "16-05-1997", min: 55.0),
        StatisticsGoalData(day: "Total", min: 300.0)
    ]

    init(vm: StatisticsVM = StatisticsVM()) {
        self.vm = vm
    }

    var body: some View {
        VStack {
            Chart {
                ForEach (0..<data.count, id: \.self) { index in
                    BarMark(
                        x: .value("Day", data[index].day),
                        y: .value("Mins", data[index].min)
                    )
                }
            }
            .padding()
            .frame(maxWidth: 400, maxHeight: 350)
            .background(Color(.systemGray6))
        }
        .onAppear {
            data = vm.generateStatisticGoalData()
        }
    }
}

#Preview {
    StatisticsPresentation()
}
