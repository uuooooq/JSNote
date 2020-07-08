//
//  ContentView.swift
//  PersonalerMac
//
//  Created by zhu dongwei on 2020/7/6.
//  Copyright © 2020 zhu dongwei. All rights reserved.
//

import SwiftUI

struct Street: Identifiable,Hashable {
    var id = UUID()
    var name:String
}

struct StreetRow : View {
    //var name: String
    var street: Street
    
    var body: some View{
        Text("The street name is \(street.name)").foregroundColor(.red)
    }
}

struct ListDetailView :View {
    
    var body: some View{
        Text("detail view")
    }
    
}

struct ContentView: View {
    
    @State private var streets = [Street(name: "The Lodon Street"),
                                  Street(name: "The Joe's Street1"),
                                  Street(name: "the House Street")]
    
    var body: some View {
//        Text("Hello, World!")
//            .frame(maxWidth: .infinity, maxHeight: .infinity)
//        func deleteRow(atoffsets:IndexPath){
//            streets.remove(at: atoffsets.)
//        }
        
        
//        return List{
//            ForEach(streets, id: \.self){
//                street in StreetRow(street: street)
//            }
//        }
//    }
        
        return NavigationView{
            List(streets){street in
                NavigationLink(destination: ListDetailView()){
                    StreetRow(street: street)
                }
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
