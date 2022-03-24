//
//  SwiftUIView.swift
//  SearchSongs
//
//  Created by Алексей Каземиров on 3/24/22.
//

import SwiftUI

struct SwiftUIView: View {
    @State var isOn = false
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Toggle(isOn: $isOn) {
                        Text("Is Subscriber")
                    }
                    Toggle(isOn: $isOn) {
                        Text("Is Subscriber")
                    }
                    Toggle(isOn: $isOn) {
                        Text("Is Subscriber")
                    }
                }
                Spacer()
            }
            .navigationTitle("Settings")
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
