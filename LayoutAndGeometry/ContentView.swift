//
//  ContentView.swift
//  LayoutAndGeometry
//
//  Created by Dmitry Reshetnik on 05.04.2020.
//  Copyright © 2020 Dmitry Reshetnik. All rights reserved.
//

import SwiftUI

struct OuterView: View {
    var body: some View {
        VStack {
            Text("Top")
            InnerView()
                .background(Color.green)
            Text("Bottom")
        }
    }
}

struct InnerView: View {
    var body: some View {
        HStack {
            Text("Left")
            GeometryReader { geo in
                Text("Center")
                    .background(Color.blue)
                    .onTapGesture {
                        print("Global center: \(geo.frame(in: .global).midX) x \(geo.frame(in: .global).midY)")
                        print("Custom center: \(geo.frame(in: .named("Custom")).midX) x \(geo.frame(in: .named("Custom")).midY)")
                        print("Local center: \(geo.frame(in: .local).midX) x \(geo.frame(in: .local).midY)")
                    }
            }
            .background(Color.orange)
            Text("Right")
        }
    }
}

struct ContentView: View {
    let colors: [Color] = [.red, .green, .blue, .orange, .pink, .purple, .yellow]
    
    var body: some View {
        GeometryReader { fullView in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(0..<50) { index in
                        GeometryReader { geo in
                            Rectangle()
                                .fill(self.colors[index % 7])
                                .frame(height: 150)
                                .rotation3DEffect(.degrees(-Double(geo.frame(in: .global).midX - fullView.size.width / 2) / 10), axis: (x: 0, y: 1, z: 0))
                        }
                        .frame(width: 150)
                    }
                }
                .padding(.horizontal, (fullView.size.width - 150) / 2)
            }
        }
        .edgesIgnoringSafeArea(.all)
//        GeometryReader { fullView in
//            ScrollView(.vertical) {
//                ForEach(0..<50) { index in
//                    GeometryReader { geo in
//                        Text("Row #\(index)")
//                            .font(.title)
//                            .frame(width: fullView.size.width)
//                            .background(self.colors[index % 7])
//                            .rotation3DEffect(.degrees(Double(geo.frame(in: .global).midY - fullView.size.height / 2) / 5), axis: (x: 0, y: 1, z: 0))
//                    }
//                    .frame(height: 40)
//                }
//            }
//        }
//        OuterView()
//            .background(Color.red)
//            .coordinateSpace(name: "Custom")
//        VStack {
//            GeometryReader { geometry in
//                Text("Hello, World!")
//                    .frame(width: geometry.size.width * 0.9)
//                    .background(Color.red)
//            }
//
//            Text("More text")
//                .background(Color.blue)
//        }
//        .background(Color.green)
//        Text("Hello, World!")
////            .background(Color.red)
////            .position(x: 100, y: 100)
//            .offset(x: 100, y: 100)
//            .background(Color.red)
//        HStack(alignment: .midAccountAndName) {
//            VStack {
//                Text("@nin")
//                    .alignmentGuide(.midAccountAndName) { d in d[VerticalAlignment.center] }
//                Image("nin")
//                    .resizable()
//                    .frame(width: 64, height: 64)
//            }
//
//            VStack {
//                Text("Full name:")
//                Text("TRENT REZNOR")
//                    .alignmentGuide(.midAccountAndName) { d in d[VerticalAlignment.center] }
//                    .font(.largeTitle)
//            }
//        }
//        Text("Live long and prosper")
//            .frame(width: 300, height: 300, alignment: .topLeading)
//        HStack(alignment: .lastTextBaseline) {
//            Text("Live")
//                .font(.caption)
//            Text("long")
//            Text("and")
//                .font(.title)
//            Text("prosper")
//                .font(.largeTitle)
//        }
//        VStack(alignment: .leading) {
//            Text("Hello, World!")
//                .alignmentGuide(.leading) { d in d[.trailing] }
//            Text("This is a longer line of text.")
//        }
//        .background(Color.red)
//        .frame(width: 400, height: 400)
//        .background(Color.blue)
//        VStack(alignment: .leading) {
//            ForEach(0..<10) { position in
//                Text("Number \(position)")
//                    .alignmentGuide(.leading) { _ in CGFloat(position) * -10}
//            }
//        }
//        .background(Color.red)
//        .frame(width:400, height: 400)
//        .background(Color.blue)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension VerticalAlignment {
    struct MidAccountAndName: AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            context[.top]
        }
    }
    
    static let midAccountAndName = VerticalAlignment(MidAccountAndName.self)
}
