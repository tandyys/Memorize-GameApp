//
//  GrapChartView.swift
//  MemorizeApp
//
//  Created by tandyys on 11/07/24.
//

import SwiftUI
import SwiftData
import Charts

struct GrapChartView: View {
    @StateObject var viewModel: GraphChartVM = GraphChartVM(dataSource: .shared)
    
    @State private var inputAmount:Int = 0
    @State private var selectedType:String = "Before eat"
    @State private var inputDate:Date = .now
    
    var body: some View {
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
                print("Button tapped!")
                print(viewModel.items)
                viewModel.addData(inputDate, inputAmount, selectedType)
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
            
            ZStack {
                Chart {
                    ForEach(viewModel.items.filter{$0.type == "Before eat"}) { item in
                        LineMark(x: PlottableValue.value("Date", item.date), y: PlottableValue.value("Amount", item.amount))
                            .symbol(.circle)
                            .foregroundStyle(.blue)
                            .interpolationMethod(.monotone)
                            .lineStyle(StrokeStyle(lineWidth: 3))
                    }
                }
                .frame(height: 250)
                .chartYAxis(.hidden)
                .padding()
                
                Chart {
                    ForEach(viewModel.items.filter{$0.type == "After eat"}) { item in
                        LineMark(x: PlottableValue.value("Date", item.date), y: PlottableValue.value("Amount", item.amount))
                            .symbol(.circle)
                            .foregroundStyle(.pink)
                            .interpolationMethod(.monotone)
                    }
                }
                .frame(height: 250)
                .chartYAxis(.hidden)
                .padding()
            }
            
            List {
                ForEach(viewModel.items) { item in
                    HStack {
                        Text(dateFormatter.string(from: item.date))
                        Divider()
                        Text("\(String(item.amount)) mg/dL")
                        Divider()
                        Text(item.type)
                    }
                    .padding()
                }
                .onDelete { indexes in
                    for index in indexes {
                        viewModel.removeData(viewModel.items[index])
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
}

#Preview {
    GrapChartView()
}
