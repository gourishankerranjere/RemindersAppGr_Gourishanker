//
//  RemindersVC.swift
//  RemindersAppGr
//
//  Created by Gourishanker on 09/10/23.
//

import UIKit

class RemindersVC: UIViewController{
    
    @IBOutlet weak var typeOutlet: UISegmentedControl!
    
    @IBOutlet weak var titleTF: UITextField!
    
   
    
    @IBOutlet weak var datepicker: UIDatePicker!
    
    
    
   
    @IBOutlet weak var descriptionTF: UITextView!
    
    
    
    @IBOutlet weak var switchOutlet: UISwitch!
    
    
    
    
    var remindersList : [RemindersTable] = []
    
    let notificationUtility = ReminderNotificationUtility()
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        notificationUtility.notificationCentre.delegate = self
            
        
        
    }
   
    
    //var desctopass : String = ""
    @IBAction func setClick(_ sender: Any)
    {
        
        let titletoPass = titleTF.text ?? ""
        let timetoPass = datepicker.date
        let notificationtoPass = switchOutlet.isOn
        let datetoPass = datepicker.date
        let typetoPass = typeOutlet.titleForSegment(at: typeOutlet.selectedSegmentIndex) ?? ""
        print(typetoPass)
        
         let desctopass = descriptionTF.text ?? ""
        

        print(desctopass)
        
       do
       {
           try RemindersUtilityGR.instance.addReminder(title: titletoPass, type: typetoPass, date: datetoPass, time: timetoPass, desc: desctopass, notification: notificationtoPass)
           
           
          remindersList = try  RemindersUtilityGR.instance.getRemindersList()
           
           //viewDidLoad()
               
          //self.tbl.reloadData()
       }catch{
           print("Not able to adddd")
       }
       // dismiss(animated: true)
        
        view.backgroundColor = .gray
        
        
        if notificationtoPass
        {
            notificationUtility.addReminderNotifcation(titleN: titletoPass, descN: desctopass, dateN: datepicker.date)
        }
        
 
        
        
       
        navigationController?.popViewController(animated: true)
        
    }
    
    

}







extension UIViewController {
    
    func showAlert(title : String?, msg: String?)
    {
        let alertVC = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .default)
        
        alertVC.addAction(okAction)
        
        present(alertVC, animated: false)
    }
}




extension RemindersVC : UNUserNotificationCenterDelegate
{
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        print("did rreceive : app not in foreground and user selected noification")
    
    }
    
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        print(" will present : app is in foreground")
        

        completionHandler([.banner,.sound])
    }
}





