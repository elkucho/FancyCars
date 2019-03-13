

/*
 
 I decided to add my SeerviecCall struct here just to show my methods to work with Service Calls.
 I'm not using any service calls for this exercise.
 This work is from my personal App in the App Store and was made to attend my needs.
 
 */





//import DeviceCheck
//import Foundation
//import KeychainSwift
//import CommonCrypto
//import CryptoSwift
//
//struct ServiceCalls {
//
//    static func getJSON(completion: @escaping (_ result: Bool) -> Void) {
//
//
//        guard let urlString = getURL() else { return }
//
//        guard let url = URL(string: urlString) else { return }
//
//        let session = URLSession.shared      // create the session object
//        let request = URLRequest(url: url)   // now create the URLRequest object using the url object
//
//        //create dataTask using the session object to send data to the server
//
//
//
//        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
//
//            guard error == nil else {
//                completion(false)
//                return
//            }
//
//            guard
//                let fulldata = data,
//                let encryptedData = String(bytes: fulldata, encoding: String.Encoding.utf8) else {
//                    completion(false)
//                    return
//            }
//
//            let fullkey = ...
//            var splitkey = [String]()
//            for char in fullkey {
//                splitkey.append(String(char))
//            }
//
//            let iv = ...
//
//
//            let key = ...
//
//            do {
//
//                let aes = try AES(key: key, iv: iv, padding: Padding.....)
//                let decdata = try encryptedData.decryptBase64ToString(cipher: aes)
//
//                keychain.set(decdata, forKey: defaultValues().vehiclejson)
//
//                VehiclesModel.loadVehicles()
//                completion(true)
//
//            } catch {
//                print(error)
//                completion(false)
//            }
//
//        })
//
//        task.resume()
//
//    }
//
//    func getDataFromLocalJson(url: String, parameter: String, completion: @escaping (_ success: [String : AnyObject]) -> Void) {
//
//        var request = URLRequest(url: URL(string: url)!)
//        request.httpMethod = "GET"
//        let postString = parameter
//
//        request.httpBody = postString.data(using: .utf8)
//        let task = URLSession.shared.dataTask(with: request) { Data, response, error in
//
//            guard let data = Data, error == nil else {  // check for fundamental networking error
//
//                print("error=\(String(describing: error))")
//                return
//            }
//
//            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {  // check for http errors
//
//                print("statusCode should be 200, but is \(httpStatus.statusCode)")
//                print(response!)
//                return
//
//            }
//
//            let responseString  = try! JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String : AnyObject]
//            completion(responseString)
//
//
//
//        }
//        task.resume()
//    }
//
//
//
//    private static func getURL() -> String? {
//
//        // Read plist from bundle and get Root Dictionary out of it
//        var dictRoot: NSDictionary?
//        if let path = Bundle.main.path(forResource: "My App Plist File", ofType: "plist") {
//            dictRoot = NSDictionary(contentsOfFile: path)
//        }
//
//        if let dictionary = dictRoot {
//
//            guard (dictionary["....."] as? String) != nil else { return "" }
//
//            let theURL = dictionary[...] as? String
//
//            let deviceToken = .....
//
//            guard let newURL = theURL?.replacingOccurrences(of: "...", with: "......") else {
//                return nil
//            }
//
//            return newURL
//        }
//
//        return ""
//
//    }
//
//}
//
