//
//  GraphView.swift
//  MemorizeApp
//
//  Created by tandyys on 10/07/24.
//

import SwiftUI
import Charts

struct GraphView: View {
    private var areaBackground: Gradient {
        return Gradient(colors: [Color.red, Color.red.opacity(0.1)])
      }
    
    private var secAreaBackground: Gradient {
        return Gradient(colors: [Color.orange, Color.orange.opacity(0.1)])
      }
    
    //    var datas = [
    //        GlutenData(day: "Mon", amount: 17),
    //        GlutenData(day: "Mon", amount: 24, type: "After eat"),
    //        GlutenData(day: "Tue", amount: 20),
    //        GlutenData(day: "Tue", amount: 30, type: "After eat"),
    //        GlutenData(day: "Wed", amount: 12),
    //        GlutenData(day: "Wed", amount: 17, type: "After eat"),
    //        GlutenData(day: "Thu", amount: 30),
    //        GlutenData(day: "Thu", amount: 35, type: "After eat"),
    //        GlutenData(day: "Fri", amount: 22),
    //        GlutenData(day: "Fri", amount: 27, type: "After eat"),
    //        GlutenData(day: "Sat", amount: 15),
    //        GlutenData(day: "Sat", amount: 16, type: "After eat"),
    //        GlutenData(day: "Sun", amount: 18),
    //        GlutenData(day: "Sun", amount: 21, type: "After eat"),
    //    ]
    //    let datas = [
    //        WeeklyData(date: Date.from(year: 2024, month: 7, day: 10), glutenAmount: 17)
    //    ]
    
    let data: [WeeklyData] = [
        .init(date: Date.from(year: 2024, month: 7, day: 10), glutenAmount: 94),
        .init(date: Date.from(year: 2024, month: 7, day: 10), glutenAmount: 112, type: "After eat"),
        .init(date: Date.from(year: 2024, month: 7, day: 11), glutenAmount: 141),
        .init(date: Date.from(year: 2024, month: 7, day: 11), glutenAmount: 158, type: "After eat"),
        .init(date: Date.from(year: 2024, month: 7, day: 12), glutenAmount: 101),
        .init(date: Date.from(year: 2024, month: 7, day: 12), glutenAmount: 175, type: "After eat"),
        .init(date: Date.from(year: 2024, month: 7, day: 13), glutenAmount: 91),
        .init(date: Date.from(year: 2024, month: 7, day: 13), glutenAmount: 134, type: "After eat"),
        .init(date: Date.from(year: 2024, month: 7, day: 14), glutenAmount: 104),
        .init(date: Date.from(year: 2024, month: 7, day: 14), glutenAmount: 172, type: "After eat"),
        .init(date: Date.from(year: 2024, month: 7, day: 15), glutenAmount: 75),
        .init(date: Date.from(year: 2024, month: 7, day: 15), glutenAmount: 115, type: "After eat"),
        .init(date: Date.from(year: 2024, month: 7, day: 16), glutenAmount: 96),
        .init(date: Date.from(year: 2024, month: 7, day: 16), glutenAmount: 123, type: "After eat"),
        .init(date: Date.from(year: 2024, month: 7, day: 17), glutenAmount: 83),
        .init(date: Date.from(year: 2024, month: 7, day: 17), glutenAmount: 142, type: "After eat")
//        .init(date: Date.from(year: 2024, month: 7, day: 18), glutenAmount: 400)
//        .init(date: Date.from(year: 2024, month: 7, day: 18), glutenAmount: 126, type: "After eat"),
//        .init(date: Date.from(year: 2024, month: 7, day: 19), glutenAmount: 90),
//        .init(date: Date.from(year: 2024, month: 7, day: 19), glutenAmount: 126, type: "After eat")
    ]
    
    var highestAmount:Int? {
        return data.map{ $0.glutenAmount }.max()
    }
    
    var filteredTypeBefore:[WeeklyData] {
        return data.filter{$0.type == "Before eat"}
    }
    
    var filteredTypeAfter:[WeeklyData] {
        return data.filter{$0.type == "After eat"}
    }
    
    var body: some View {
        VStack {
            //            Chart {
            //                ForEach(datas) { data in
            //                    LineMark(x: PlottableValue.value("Day", data.day), y: PlottableValue.value("Gluten Amount", data.amount))
            //                        .annotation(position: .overlay) {
            //                            Text(String(data.amount))
            //                                .foregroundStyle(.white)
            //                        }
            //                        .foregroundStyle(by: PlottableValue.value("Type", data.type))
            //                }
            //            }
            //    //        .chartYScale(range: .plotDimension(padding: 10))
            //            .padding()
            //
            Text("Past 7 Days Graph")
                .font(.system(size: 24, weight: .bold, design: .rounded))
                .padding()
            ZStack {
                Chart(filteredTypeBefore) { d in
                    LineMark(x: PlottableValue.value("Date", d.date), y: PlottableValue.value("Amount", d.glutenAmount))
                        .symbol(.circle)
                        .foregroundStyle(.red)
                        .interpolationMethod(.monotone)
                    
//                    AreaMark(x: PlottableValue.value("Date", d.date), y: PlottableValue.value("Amount", d.glutenAmount))
//                        .interpolationMethod(.monotone)
//                        .foregroundStyle(areaBackground)
                }
//                .chartYScale(domain: 0...highestAmount!)
                .frame(height: 250)
                .chartYAxis(.hidden)
                
                Chart {
                    ForEach(data.filter{$0.type == "After eat"}) { d in
                        LineMark(x: PlottableValue.value("Date", d.date), y: PlottableValue.value("Amount", d.glutenAmount))
                            .symbol(.circle)
                            .foregroundStyle(.orange)
                            .interpolationMethod(.monotone)
                        
//                        AreaMark(x: PlottableValue.value("Date", d.date), y: PlottableValue.value("Amount", d.glutenAmount))
//                            .interpolationMethod(.monotone)
//                            .foregroundStyle(secAreaBackground)
                    }
                }
//                .chartYScale(domain: 0...highestAmount!)
                .frame(height: 250)
                .chartYAxis(.hidden)
                
//                Chart {
//                    ForEach(data) { d in
//                        PointMark(x: PlottableValue.value("Date", d.date, unit: .day), y: PlottableValue.value("Gluten Amount", d.glutenAmount))
//                            .foregroundStyle(by: PlottableValue.value("Type", d.type))
//                    }
//                }
//                .frame(height: 250)
//                .chartYScale(range: .plotDimension(padding: 10))
//                .chartYScale(domain: 10...35)
//                .padding()
                
//                Chart {
//                    ForEach(data) { d in
//                        LineMark(x: PlottableValue.value("Date", d.date, unit: .day), y: PlottableValue.value("Gluten Amount", d.glutenAmount))
//                            .foregroundStyle(by: PlottableValue.value("Type", d.type))
//                    }
//                }
//                .frame(height: 250)
//                .chartYScale(range: .plotDimension(padding: 10))
//                .chartYScale(domain: 10...35)
//                .padding()
                
//                Chart {
//                    ForEach(data.filter{ $0.type == "Before eat"}) { d in
//                        LineMark(x: PlottableValue.value("Date", d.date), y: PlottableValue.value("Amount", d.glutenAmount))
//                            .foregroundStyle(Color.gray)
//                            .opacity(0.35)
//                            .lineStyle(StrokeStyle(lineWidth: 1.5))
//                    }
//                }
//                .frame(height: 250)
//                .chartXAxis(.hidden)
//                .chartYAxis(.hidden)
//                .chartYScale(domain: 10...200)
//                .padding()
//                
//                Chart {
//                    ForEach(data.filter{ $0.type == "After eat"}) { d in
//                        LineMark(x: PlottableValue.value("Date", d.date), y: PlottableValue.value("Amount", d.glutenAmount))
//                            .foregroundStyle(Color.orange)
//                            .lineStyle(StrokeStyle(lineWidth: 3))
//                    }
//                }
//                .chartYAxis(.hidden)
//                .chartYScale(domain: 10...200)
//                .frame(height: 250)
//                .padding()
            }
            .padding()
            
            Rectangle()
                .ignoresSafeArea()
                .foregroundColor(.white)
        }
    }
}

#Preview {
    GraphView()
}
