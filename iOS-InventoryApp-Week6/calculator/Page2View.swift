//
//  Page2View.swift
//  calculator
//
//  Created by Harnoor Singh on 2/24/24.
//

import SwiftUI


extension View {
    @ViewBuilder func isHidden(_ isHidden: Bool) -> some View {
        if isHidden {
            self.hidden()
        } else {
            self
        }
    }
}

struct Page2View: View {
//    @Binding var textFromPage1: String
    @State var response: [Inventory]? // nil
    
    @State var inventories: [Inventory]?
    @StateObject private var viewModel = Page2ViewModel()
    @State var isHidden = false
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            List {
                ForEach(inventories ?? []) { inventory in
                    Text("Name: \(inventory.name)")
                    AsyncImage(url: URL(string: inventory.url)) {image in
                        image.resizable()
                            .scaledToFit()
                            .frame(width: 600, height: 300)
                    } placeholder: {
                        ProgressView()
                    }
                    Stepper {
                        Text("Count: \(inventory.count)")
                    } onIncrement: {
                        Task {
                            await incrementStep(inventory_obj: inventory)
                            do {
                                response = try await viewModel.getResponseFromServer() // todo pass text3
                                inventories = response
                                isHidden = true
                            } catch InventoryError.URLError {
                                print("Error found in the URL")
                            } catch InventoryError.ResponseError {
                                print("Server down")
                            } catch {
                                print("Something else", error)
                            }
                        }
                    } onDecrement: {
                        Task {
                            await decrementStep(inventory_obj: inventory)
                            do {
                                response = try await viewModel.getResponseFromServer() // todo pass text3
                                inventories = response
                                isHidden = true
                            } catch InventoryError.URLError {
                                print("Error found in the URL")
                            } catch InventoryError.ResponseError {
                                print("Server down")
                            } catch {
                                print("Something else", error)
                            }
                        }
                    }
                    
                    // 2. Camera Recognition
                }
            }
        }
        .padding()
        .task {
            do {
                response = try await viewModel.getResponseFromServer() // todo pass text3
                inventories = response
                isHidden = true
            } catch InventoryError.URLError {
                print("Error found in the URL")
            } catch InventoryError.ResponseError {
                print("Server down")
            } catch {
                print("Something else", error)
            }
        }
    }
    
    func incrementStep(inventory_obj: Inventory) async {
        do {
            try await viewModel.incrementInventoryCountInDatabase(inventory_obj: inventory_obj)
        } catch InventoryError.URLError {
            print("Error found in the URL")
        } catch InventoryError.ResponseError {
            print("Server down")
        } catch {
            print("Something else", error)
        }
    }
    
    func decrementStep(inventory_obj: Inventory) async {
        do {
            try await viewModel.decrementInventoryCountInDatabase(inventory_obj: inventory_obj)
        } catch InventoryError.URLError {
            print("Error found in the URL")
        } catch InventoryError.ResponseError {
            print("Server down")
        } catch {
            print("Something else", error)
        }
    }

}


#Preview {
    Page2View()
}
