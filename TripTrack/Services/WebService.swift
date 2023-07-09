//
//  WebService.swift
//  TripTrack
//
//  Created by Vardges Gasparyan on 2023-06-25.
//

import Foundation

class WebService {
    
    let vinCode = UserDefaults.standard.string(forKey: "vinCode") ?? ""
    
//    MARK: - Parse JSON
    
    func parseJSON(scanResVM: ScanResultViewModel) {

        let address = "https://vpic.nhtsa.dot.gov/api/vehicles/decodevinvaluesextended/\(vinCode)?format=json"

        guard let url = URL(string: address) else { return }

        URLSession.shared.dataTask(with: url) { (data, response, err) in
            DispatchQueue.main.async {

                if let err = err {

                    print("Failed to get data from URL", err)
                    return
                }
                guard let jsonData = data else { return }

                let veh = Vehicle()
                
                veh.vin = self.vinCode

                do {

                    if let json = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] {

                        if let endResults = json["Results"] as? Array<Dictionary<String, Any>> {

                            for endResult in endResults {

                                if let make = endResult["Make"] as? String {
                                    veh.make = String(make)
                                    print("\(veh.make) Vin API-ic")
                                }
                                if let model = endResult["Model"] as? String {
                                    veh.model = String(model)
                                    print(model)
                                }
                                if let year = endResult["ModelYear"] as? String {
                                    veh.year = String(year)
                                    print(year)
                                }
                                if let madeIn = endResult["PlantCountry"] as? String {
                                    veh.madeIn = String(madeIn)
                                    print(madeIn)
                                }
                                if let manufacturer = endResult["Manufacturer"] as? String {
                                    veh.manufacturer = String(manufacturer)
                                    print(manufacturer)
                                }
                            }
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {

                            let delegateVehicle: UploadVehicleDelegate? = scanResVM
                            delegateVehicle?.getVehicleInfo(vehicle: veh)

//                            print("VehicleInfo: \n\(veh.make),\n\(veh.model),\n\(veh.year),\n\(veh.madeIn),\n\(veh.manufacturer)")
                        })
                    }
                } catch {

                    print(err?.localizedDescription ?? "Error Localize")
                }
            }
        }.resume()
    }
}
