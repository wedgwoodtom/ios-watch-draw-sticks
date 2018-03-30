//
//  TeacherDataClient.swift
//  DrawSticks
//
//  Created by Tom Patterson on 3/28/18.
//  Copyright © 2018 Tom Patterson. All rights reserved.
//

import Foundation

//
//  TeacherDataClient.swift
//
//  Created by Tom Patterson
//  Copyright © 2018 Tom Patterson. All rights reserved.
//
//  https://medium.com/swift-programming/http-in-swift-693b3a7bf086
//
//  Ug! - just use Swifty or somthing more elegant FFS
//

import Foundation


public class TeacherDataClient {
    
    let SERVICE_URL = "https://m6ex37btfb.execute-api.us-west-2.amazonaws.com/test"
    
    public init() {
    }
    
    public func findCurrentStudents(teacherId: String, currentTime: Int64, callBack: @escaping ([String]) -> Void) {
        let jsonRequestPayload: [String: Any] = [ "teacherId": teacherId, "currentTime": currentTime]
        
        HTTPPostJSON(url: SERVICE_URL+"/findCurrentStudents", jsonObj: jsonRequestPayload as AnyObject) { (jsonResponse: Dictionary<String, AnyObject>) in
            callBack(self.parseData(json: jsonResponse))
        }
    }
    
    private func parseData(json: Dictionary<String, AnyObject>) -> [String] {
        var studentList: [String] = []
        
        if let scores = json["students"] as? [String] {
            for score in (scores) {
                studentList.append(score)
            }
        }
        return studentList
    }
    
    // TODO: Move all this stuff to a utility class (or just use Swifty or similar)
    
    
    private func HTTPPostJSON(url: String,
                              jsonObj: AnyObject,
                              callback: @escaping (Dictionary<String, AnyObject>) -> Void) {
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let jsonString = JSONStringify(value: jsonObj)
        let data: Data = jsonString.data(
            using: String.Encoding.utf8)!
        request.httpBody = data
        HTTPsendRequest(request: request, callback: callback)
    }
    
    private func JSONStringify(value: AnyObject, prettyPrinted: Bool = true) -> String {
        let options = prettyPrinted ? JSONSerialization.WritingOptions.prettyPrinted : nil
        if JSONSerialization.isValidJSONObject(value) {
            do {
                let data = try JSONSerialization.data(withJSONObject: value, options: options!)
                if let string = NSString(data: data, encoding: String.Encoding.utf8.rawValue) {
                    return string as String
                }
            }  catch {
                print("Error in generating JSON String from object!")
                return ""
            }
        }
        return ""
    }
    
    private func JSONParseDict(jsonString:String) -> Dictionary<String, AnyObject> {
        
        if let data: Data = jsonString.data(
            using: String.Encoding.utf8){
            
            do{
                if let jsonObj = try JSONSerialization.jsonObject(
                    with: data,
                    options: JSONSerialization.ReadingOptions(rawValue: 0)) as? Dictionary<String, AnyObject> {
                    return jsonObj
                }
            }catch{
                print("Error parsing JSON from \(jsonString)")
            }
        }
        return [String: AnyObject]()
    }
    
    private func HTTPsendRequest(request: URLRequest, callback: @escaping (Dictionary<String, AnyObject>) -> Void) {
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let data = data, error == nil else {
                print("Error:" + (error?.localizedDescription)! )
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(String(describing: response))")
            }
            
            let responseString = String(data: data, encoding: .utf8)!
            
            print("responseString = \(responseString)")
            
            callback(self.JSONParseDict(jsonString: responseString))
        }
        task.resume()
    }
    
    
    
    
}
