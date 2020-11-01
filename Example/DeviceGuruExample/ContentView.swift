//
//  ContentView.swift
//  DeviceGuruExample
//
//  Created by Witek Bobrowski on 31/10/2020.
//

import SwiftUI
import DeviceGuru

struct ContentView: View {

    private let guru = DeviceGuru()

    private var name: Hardware { guru.hardware() }
    private var code: String { guru.hardwareString() }
    private var platform: Platform { guru.platform() }
    private var description: String? { guru.hardwareDescription() }
    private var deviceVersion: DeviceVersion? { guru.hardwareNumber() }

    var body: some View {
        VStack {
            Text(description ?? "This Device")
                .font(.title3).padding(.bottom)
            HStack {
                VStack {
                    headline("Device Name")
                    headline("Device Code")
                    headline("Platform")
                    headline("Device Version")
                }
                VStack {
                    value(String(describing: name))
                    value(code)
                    value(String(describing: platform))
                    value("\(String(describing: deviceVersion!.major)),\(deviceVersion!.minor)")
                }
            }
        }.padding()
        .background(Color(white: 0.92, opacity: 1))
        .clipShape(RoundedRectangle(cornerRadius: 25.0))
        .padding()
    }

    private func value(_ text: String) -> some View {
        Text(text)
            .multilineTextAlignment(.leading)
            .frame(minWidth: 0, idealWidth: 100, maxWidth: .infinity, alignment: .leading)
    }

    private func headline(_ text: String) -> some View {
        Text(text)
            .font(.headline)
            .multilineTextAlignment(.trailing)
            .frame(minWidth: 0, idealWidth: 100, maxWidth: .infinity, alignment: .trailing)
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
