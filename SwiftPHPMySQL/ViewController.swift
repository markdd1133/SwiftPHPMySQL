//
//  ViewController.swift
//  SwiftPHPMySQL
//
//  Created by Sheng Chi Chen on 2017/5/5.
//  Copyright © 2017年 Sheng Chi Chen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //URL to our web service
    let URL_SAVE_TEAM = URL(string: "http://192.168.1.2/MyWebService/api/createteam.php")
    
    //Textfields declarations
    @IBOutlet weak var textFieldName: UITextField!
    @IBOutlet weak var textFieldMember: UITextField!
    @IBOutlet weak var textFieldBrand: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    //Button action method
    @IBAction func buttonSave(_ sender: Any) {
        
        //creating NSMutableURLRequest
        let request = NSMutableURLRequest(url: URL_SAVE_TEAM!)
        
        //setting the method to post
        request.httpMethod = "POST"
        
        //getting values from text fields
        let teamName=textFieldName.text
        let memberCount = textFieldMember.text
        let teamBrand = textFieldBrand.text
        
        //creating the post parameter by concatenating the keys and values from text field
        let postParameters = "name="+teamName!+"&member="+memberCount!+"&brand="+teamBrand!;
        
        //adding the parameters to request body
        request.httpBody = postParameters.data(using: String.Encoding.utf8)
        
        
        //creating a task to send the post request
        let task = URLSession.shared.dataTask(with: request as URLRequest){
            data, response, error in
            
            if let err = error as NSError?{
                print("error is \(err)")
                return;
            }
            
            //parsing the response
            do {
                //converting resonse to NSDictionary
                let myJSON = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                
                //parsing the json
                if let parseJSON = myJSON {
                    
                    //creating a string
                    var msg : String!
                    
                    //getting the json response
                    msg = parseJSON["message"] as! String?
                    
                    //printing the response
                    print(msg)
                    
                }
            } catch {
                print(error)
            }
            
        }
        //executing the task
        task.resume()
    }
    
}

