//
//  ContentView.swift
//  Lettery
//
//  Created by Robert Clarke on 07/07/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
        HStack {
            VStack {
                Text("F")
                    .font(.largeTitle)
                Text("Foxtrot")
                    .font(.caption)
            }
            VStack {
                Text("O")
                    .font(.largeTitle)
                Text("Oscar")
                    .font(.caption)
            }
            VStack {
                Text("X")
                    .font(.largeTitle)
                Text("X-Ray")
                    .font(.caption)
            }
            VStack {
                Text("T")
                    .font(.largeTitle)
                Text("Tango")
                    .font(.caption)
            }
            VStack {
                Text("R")
                    .font(.largeTitle)
                Text("Romeo")
                    .font(.caption)
            }
            VStack {
                Text("O")
                    .font(.largeTitle)
                Text("Oscar")
                    .font(.caption)
            }
            VStack {
                Text("T")
                    .font(.largeTitle)
                Text("Tango")
                    .font(.caption)
            }
        }
        .padding(10.0)
            Spacer()
            HStack {
                VStack {
                    Text("Foxtrot")
                        .font(.caption)
                    Text("F")
                        .font(.largeTitle)
                }
                VStack {
                    Text("Oscar")
                        .font(.caption)
                    Text("O")
                        .font(.largeTitle)
                }
                VStack {
                    Text("X-Ray")
                        .font(.caption)
                    Text("X")
                        .font(.largeTitle)
                }
                VStack {
                    Text("Tango")
                        .font(.caption)
                    Text("T")
                        .font(.largeTitle)
                }
                VStack {
                    Text("Romeo")
                        .font(.caption)
                    Text("R")
                        .font(.largeTitle)
                }
                VStack {
                    Text("Oscar")
                        .font(.caption)
                    Text("O")
                        .font(.largeTitle)
                }
                VStack {
                    Text("Tango")
                        .font(.caption)
                    Text("T")
                        .font(.largeTitle)
                }

            }
            .padding(10.0)
            
            HStack {
                VStack {
                    Text("At")
                        .font(.caption)
                    Text("@")
                        .font(.largeTitle)
                }

            }
            .padding(10.0)

            HStack {
                VStack {
                    Text("Foxtrot")
                        .font(.caption)
                    Text("F")
                        .font(.largeTitle)
                }
                VStack {
                    Text("Oscar")
                        .font(.caption)
                    Text("O")
                        .font(.largeTitle)
                }
                VStack {
                    Text("X-Ray")
                        .font(.caption)
                    Text("X")
                        .font(.largeTitle)
                }
                VStack {
                    Text("Tango")
                        .font(.caption)
                    Text("T")
                        .font(.largeTitle)
                }
                VStack {
                    Text("Romeo")
                        .font(.caption)
                    Text("R")
                        .font(.largeTitle)
                }
                VStack {
                    Text("Oscar")
                        .font(.caption)
                    Text("O")
                        .font(.largeTitle)
                }
                VStack {
                    Text("Tango")
                        .font(.caption)
                    Text("T")
                        .font(.largeTitle)
                }

            }
            .padding(10.0)

            HStack {
                VStack {
                    Text("Dot")
                        .font(.caption)
                    Text(".")
                        .font(.largeTitle)
                }

            }
            .padding(10.0)


            HStack {
                VStack {
                    Text("Charlie")
                        .font(.caption)
                    Text("C")
                        .font(.largeTitle)
                }
                VStack {
                    Text("Oscar")
                        .font(.caption)
                    Text("O")
                        .font(.largeTitle)
                }
                VStack {
                    Text("Mike")
                        .font(.caption)
                    Text("M")
                        .font(.largeTitle)
                }
            }
            .padding(10.0)

        }
        .padding(10.0)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
