//
//  HistoryListView.swift
//  TripTrack
//
//  Created by Vardges Gasparyan on 2023-07-08.
//

import SwiftUI
import FirebaseAuth
import FirebaseDatabase
import Firebase

struct HistoryListView: View {
    //    MARK: - PROPERTIES
    
    let backImage = "back"
    
    @State private var isHistoryEmpty = false
    @State private var selection: Trip? = nil
    @State private var showAlert = false
    @State private var showTrashAlert = false
    
    @Binding var tabSelected: Tab
    
    @StateObject var historyVM: HistoryViewModel
    
    //    MARK: - BODY
    var body: some View {
        
        VStack {
            
            if historyVM.tripsArray.isEmpty {
                
                ZStack {
                    
                    ActivityIndicator(shouldAnimate: $historyVM.shouldAnimate)
                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .center)
                        .background( Color.black.opacity(0.7) )
                        .onChange(of: historyVM.isHistoryEmpty, perform: { newValue in
                            showAlert = newValue
                        })
                    Text("Loading...")
                        .font(.system(size: 15))
                        .foregroundColor(.white)
                        .tint(.white)
                        .padding(.top, 50)
                }
            } else {
                List {
                    ForEach(historyVM.tripsArray) { trip in
                        ZStack(alignment: .leading) {
                            HistoryCellView(trip: trip)
                                .onTapGesture { selection = trip }
                                .swipeActions(allowsFullSwipe: false) {
                                    
                                    Button {
                                        showTrashAlert.toggle()
                                    } label: {
                                        Label("Delete", systemImage: "trash")
                                    }
                                    .tint(Color("projectRed"))
                                }
                                .confirmationDialog("Are you sure?", isPresented: $showTrashAlert, actions: {
                                    
                                    Button("Delete", role: .destructive) {
                                        deleteRow(trip)
                                    }
                                    Button("Cancel", role: .cancel) { }

                                }, message: {
                                    Text("Do you really want to delete current trip?")
                                })
                        }
                        
                    }
                    .listRowBackground(Color.clear)
                    .animation(.default, value: true)
                    .listRowInsets(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 5))
                    .sheet(item: $selection,
                           onDismiss: { self.selection = nil }) { trip in
                        SingleTripView(trip: trip)
                            .overlay(
                                Button(action: {
                                    self.selection = nil
                                }) {
                                    Image(systemName: "xmark.circle.fill")
                                        .font(.title3)
                                        .foregroundColor(.gray)
                                }
                                    .padding(.top, 16)
                                    .padding(.trailing, 16)
                                , alignment: .topTrailing
                            )
                    }
                } .scrollContentBackground(.hidden)
                    .background(Color.clear)
            }
        }
        .onAppear { historyVM.loadHistory() }
        .alert(LocalizedStringKey(stringLiteral: "NO HISTORY!!!"), isPresented: $showAlert) {
            Button("OK") {
                tabSelected = .home
            }
        } message: {
            Text("You have no trip history")
        }
    }
    
    func deleteRow(_ trip: Trip) {
        
        var ref: DatabaseReference!
        let userID = Auth.auth().currentUser?.uid
        
        let currentTrip = trip
        let tripID = currentTrip.tripId
        ref = Database.database().reference()
        
        withAnimation {
            ref.child("users").child(userID!).child("trips").child(tripID).removeValue()
        }
        historyVM.loadHistory()
    }
}
//  MARK: - PREVIEW
struct HistoryListView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryListView(tabSelected: .constant(.history), historyVM: HistoryViewModel())
    }
}
