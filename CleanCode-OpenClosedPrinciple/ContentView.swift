//
//  ContentView.swift
//  CleanCode-OpenClosedPrinciple
//
//  Created by Eric on 07/07/2023.

/*
 Open Closed Principle
 "Software entities (classes, modules, functions, etc.) should be open for extension, but closed for modification."
 
 Dependency Injection
 1. Struct Protocol (Model View Architecture)
 2. Class ObservableObject Inheritance vs Protocol, MVVM Architecture
 */


import SwiftUI

protocol ClockModelProtocol {
    var hours: String { set get }
    var minutes: String { set get }
    var seconds: String { set get }
    
    mutating func update()
}


struct ClockModel: ClockModelProtocol {
    var hours = "00"
    var minutes = "11"
    var seconds = "30"
    
   mutating func update() {
       let date = Date()
       let calendar = Calendar.current
       
       let hour = calendar.component(.hour, from: date)
       let minute = calendar.component(.minute, from: date)
       let second = calendar.component(.second, from: date)
       
       self.hours = String(format: "%02d", hour)
       self.minutes = String(format: "%02d", minute)
       self.seconds = String(format: "%02d", second)
    }
}

struct ClockModelTwo: ClockModelProtocol {
    var hours = "00"
    var minutes = "11"
    var seconds = "30"
    
   mutating func update() {
       hours = "12"
       minutes = "22"
       seconds = "00"
    }
}


struct ClockView: View {
    @State var vm : ClockModelProtocol
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        HStack {
            Text(vm.hours)
            Text(":")
            Text(vm.minutes)
            Text(":")
            Text(vm.seconds)
        }
        .font(.largeTitle).monospacedDigit()
        .onReceive(timer) { _ in
            vm.update()
        }
    }
}


struct ContentView: View {
    var body: some View {
        VStack {
            ClockView(vm: ClockModel())
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
