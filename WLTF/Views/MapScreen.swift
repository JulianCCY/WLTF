//
//  MapScreen.swift
//  WLTF
//
//  Created by iosdev on 27.4.2022.
//
// This is the map screen, navigated from ShoppingList(GroceryList)
// User can search places with the search bar on top

import SwiftUI
import CoreLocation

struct MapScreen: View {
    
    @StateObject var mapData = MapViewModel()
    @State var locationManager = CLLocationManager()
    
    var body: some View {
        
        ZStack {
            
            MapView()
                .environmentObject(mapData)
                .ignoresSafeArea()
            
            VStack {
                
                VStack(spacing: 0) {
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        TextField("Search", text: $mapData.searchText)
                            .colorScheme(.light)
                    }
                    .padding(.vertical, 10)
                    .padding(.horizontal)
                    .background(.white)
                    
                    if !mapData.locations.isEmpty && mapData.searchText != "" {
                        ScrollView {
                            VStack(spacing: 15) {
                                ForEach(mapData.locations) { i in
                                    VStack {
                                        Text(i.place.name ?? "")
                                            .fontWeight(.bold)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                        HStack {
                                            Text(i.place.thoroughfare ?? "")
                                            Text(i.place.subThoroughfare ?? "")
                                            Text(i.place.postalCode ?? "")
                                        }
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    }
                                    .foregroundColor(.black)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.leading)
                                    .onTapGesture {
                                        mapData.selectPlace(location: i)
                                    }
                                    
                                    Divider()
                                }
                            }
                            .padding(.top)
                        }
                        .background(.white)
                    }
                 
                }
                .padding()
                
                Spacer()
                
                VStack {
                    
                    Button{
                        mapData.requestLocation()
                        mapData.findYourself()
                    } label: {
                        Image(systemName: "location.fill")
                            .font(.title3)
                            .padding(10)
                            .foregroundColor(.white)
                            .background(Color("PrimaryColor"))
                            .clipShape(Circle())
                    }

                    Button(action: mapData.updateMapType, label: {
                        Image(systemName: mapData.mapType == .standard ? "network" : "map")
                            .font(.title3)
                            .padding(10)
                            .foregroundColor(Color("SecondaryColor"))
                            .background(Color("PrimaryColor"))
                            .clipShape(Circle())
                    })
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding()
            }
            .navigationBarTitle("", displayMode: .inline)
        }
        .onAppear(perform: {
            locationManager.delegate = mapData
            locationManager.requestWhenInUseAuthorization()
        })
        .alert(isPresented: $mapData.permissionDenined, content: {
            Alert(title: Text("Permission denied"),
                  message: Text("Your fridge wants to stalk you ;)"),
                  dismissButton: .default(Text("Go to settings"),
                  action: {
                    UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
            }))
        })
        .onChange(of: mapData.searchText, perform: { value in
            let delay = 0.2
            
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                if value == mapData.searchText {
                    self.mapData.searchPlaces()
                }
            }
        })
    }
}

struct MapScreen_Previews: PreviewProvider {
    static var previews: some View {
        MapScreen()
    }
}
