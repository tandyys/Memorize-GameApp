//
//  HomeView.swift
//  MemorizeApp
//f
//  Created by tandyys on 10/07/24.
//

import SwiftUI
import SwiftData
import Charts

struct HomeView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @Environment (\.modelContext) var context
    @Query var items: [GlutenData]
    
    @State private var inputAmount:Int = 0
    @State private var selectedType:String = "Before eat"
    @State private var inputDate:Date = .now
    
    var body: some View {
        var sortedItem = items.sorted{$0.date < $1.date}
        var sevenRecentData = Array(sortedItem.suffix(16))
        
        VStack {
            DatePicker("Date :", selection: $inputDate, displayedComponents: .date)
                .datePickerStyle(CompactDatePickerStyle())
                .accentColor(.green)
            HStack {
                Text("Gluten Levels :")
                TextField("Input here. . .", value: $inputAmount, format: .number)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.numberPad)
                Text("mg/dL")
            }
            Picker("Select Option", selection: $selectedType) {
                Text("Before eat").tag("Before eat")
                Text("After eat").tag("After eat")
            }
            .pickerStyle(SegmentedPickerStyle())
            
            Button(action: {
                addItem(inputDate, inputAmount, selectedType)
                inputAmount = 0
                selectedType = "Before eat"
                hideKeyboard()
            }) {
                Text("Add")
                    .foregroundColor(.white)
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                    .padding([.top, .bottom], 10)
                    .frame(maxWidth: .infinity)
                    .background(Color.green)
                    .cornerRadius(10)
            }
            .padding()
            
            if items.count < 4 {
                NoGrapChart()
            } else {
                Chart {
                    ForEach(sevenRecentData) { item in
                        LineMark(x: PlottableValue.value("Date", item.date), y: PlottableValue.value("Amount", item.amount))
                            .symbol(.circle)
                            .foregroundStyle(by: PlottableValue.value("Type", item.type))
//                            .interpolationMethod(.monotone)
                            .lineStyle(StrokeStyle(lineWidth: 3.75))
                    }
                }
                .chartForegroundStyleScale([
                    "Before eat" : Color.blue,
                    "After eat" : Color.pink
                ])
                .chartLegend(alignment: .centerLastTextBaseline, spacing: 10, content: {
                    LegendContent()
                })
                .frame(height: 250)
                .chartXAxis {
                    AxisMarks(values: .stride(by: .day, count: 1)) { value in
                        AxisGridLine()
                        AxisTick()
                        AxisValueLabel {
                            if let dateValue = value.as(Date.self) {
                                Text(dateValue, format: Date.FormatStyle()
                                    .month(.abbreviated)
                                    .day(.defaultDigits))
                                .font(.caption2)
                                .bold()
                                .foregroundColor(colorScheme == .dark ? .white : .black)
                            }
                        }
                    }
                }
                .chartYAxis {
                    AxisMarks(preset: .aligned, values: .automatic) { value in
                        AxisGridLine()
                        AxisValueLabel() {
                            if let intValue = value.as(Int.self) {
                                Text("\(intValue)")
                                    .font(.subheadline)
                                    .bold()
                                    .foregroundColor(colorScheme == .dark ? .white : .black)
                            }
                        }
                    }
                }
                .padding()
            }
            
            List {
                ForEach(items.reversed()) { item in
                    HStack {
                        Text(dateFormatter.string(from: item.date))
                        Divider()
                        VStack {
                            Text("\(String(item.amount)) mg/dL")
                            Text("\(String(item.mmolAmount)) mmol/L")
                        }
                        Divider()
                        Text(item.type)
                    }
                    .padding()
                }
                .onDelete { indexes in
                    for index in indexes {
                        let originIndex = items.count - 1 - index
                        removeItem(items[originIndex])
                    }
                }
            }
        }
        .padding(.all)
    }
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
    
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct LegendContent: View {
    var body: some View {
        HStack(alignment: .center, spacing: 10) {
            HStack {
                Circle()
                    .fill(Color.blue)
                    .frame(width: 12, height: 12)
                Text("Before eat")
                    .font(.subheadline)
                    .bold()
                    .foregroundColor(.primary)
            }
            HStack {
                Circle()
                    .fill(Color.pink)
                    .frame(width: 12, height: 12)
                Text("After eat")
                    .font(.subheadline)
                    .bold()
                    .foregroundColor(.primary)
            }
        }
    }
}

struct NoGrapChart: View {
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .frame(height: 250)
                .shadow(color: Color.gray.opacity(0.5), radius: 10, x: 0, y: 5)
                .padding()
                .foregroundColor(.white)
            
            VStack {
                Text("Graphic stats will appear after you enter minimum of your 2 days data")
                    .frame(width: 300)
                    .font(.title)
                    .bold()
                    .multilineTextAlignment(.leading)
                    .foregroundColor(colorScheme == .dark ? .black : .black)
            }
        }
    }
}

#Preview {
    //    HomeView()
    NoGrapChart()
}
