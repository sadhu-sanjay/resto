//
//  ViewController.swift
//  Resto
//
//  Created by developer on 7/31/16.
//  Copyright © 2016 Monday Ventures. All rights reserved.
//

import UIKit
import Firebase


class ViewController: UIViewController, UITextFieldDelegate{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    
    @IBAction func CreateOrLogIn(_ sender: AnyObject) {
        
        resignFirstResponder()
        if Reachability.isConnectedToNetwork() == true   {
            
            let userEmail = email.text
            let userPassword = password.text
            
            if (userEmail!.isEmpty){
                
                let alert = UIAlertController(title: "Email Required", message: "Plese Enter a Email Address", preferredStyle: UIAlertControllerStyle.alert)
                
                let alertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
                
                alert.addAction(alertAction)
                self.present(alert, animated: true, completion: nil)
                return
                
            }else if (userPassword!.isEmpty){
                
                let passwordAlert = UIAlertController(title: "Password Required", message: "Plese Enter your Password", preferredStyle: UIAlertControllerStyle.alert)
                
                let otherAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
                
                passwordAlert.addAction(otherAlertAction)
                self.present(passwordAlert, animated: true, completion: nil)
                return
            }
            
            if isValidEmail(testStr: userEmail!){
                
                
                activityIndicator.startAnimating()
                FIRAuth.auth()?.signIn(withEmail: email.text!, password: password.text!, completion: { (user, error) in
                    
                    // Error Checking if the Password entered is Wrong
                    if error != nil {
                        
                        print("\(error)")
                        let alert: UIAlertController = UIAlertController(title: "Invalid Details", message: ("Invalid Username Or password"), preferredStyle: UIAlertControllerStyle.alert)
                        
                        let alertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default){(ACTION) in
                            print("pressing the action OK button")}
                        
                        alert.addAction(alertAction)
                        self.present(alert, animated: true, completion: nil)
                        
                        print("Wrong User Name Or password")
                        
                    }else{
                        
                        //                Connecting UI Thru Code OPtional
                        //  let aViewController = UIViewController(nibName: nil, bundle: nil)
                        //                self.navigationController?.pushViewController(aViewController, animated: true)
                        
                        self.performSegue(withIdentifier: "toTheTables", sender: sender)
                        print("User Logged In")
                        //                print(" \(user)")
                    }
                    self.activityIndicator.stopAnimating()

                    }
                )
            }else {
                let emailAlert = UIAlertController(title: "Valid Email Required", message: "Please Enter a Valid Email Address", preferredStyle: UIAlertControllerStyle.alert)
                let emailAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
                emailAlert.addAction(emailAlertAction)
                self.present(emailAlert, animated: true, completion: nil)
                
            }
            //        scrollView.setContentOffset(CGPoint(x: 0,y: 0), animated: true)
            //getting rid of the keyboard
            self.view.endEditing(true)
        }else{
            print("Internet connection FAILED")
            let alert: UIAlertController = UIAlertController(title: "No Internet Connection", message: "Make sure your device is connected to the internet.", preferredStyle: UIAlertControllerStyle.alert)
            
            let okButtton = UIAlertAction(title: "OK", style: UIAlertActionStyle.default){(ACTION) in
                print("pressing the action OK button")}
            
            alert.addAction(okButtton)
            self.present(alert, animated: true, completion: nil)
            
            self.resignFirstResponder()
            
        }
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        scrollView.setContentOffset(CGPoint(x: 0,y: 240), animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        scrollView.setContentOffset(CGPoint(x: 0,y: 0), animated: true)
    }
    
}


