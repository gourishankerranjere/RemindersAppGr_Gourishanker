//
//  ViewController.swift
//  RemindersAppGr
//
//  Created by Gourishanker on 06/10/23.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var tbl: UITableView!
   
    
    var remindersList : [RemindersTable] = []
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        print(NSHomeDirectory())
        
        tbl.dataSource = self
        tbl.delegate = self
        
        
        
        do {
            remindersList = try RemindersUtilityGR.instance.getRemindersList()
            if (remindersList.count == 0)
            {
                tbl.isHidden = true
                
            }
            self.tbl.reloadData()
            
            print(remindersList.count)
        }catch{
            print("error")
        }
            
    }
    

    // ...

    
    
    @IBAction func addReminderClick(_ sender: Any) {
        
        let vc  = storyboard?.instantiateViewController(identifier: "reminderUIVC") as! RemindersVC
        show(vc, sender: self)
        //present(vc, animated: true)
        print("executed")
        
         
        
    }
//    override func viewDidDisappear(_ animated: Bool) {
//        
//        tbl.reloadData()
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        do {
            remindersList = try RemindersUtilityGR.instance.getRemindersList()
            if (remindersList.count == 0)
            {
                tbl.isHidden = true
                
            }
            self.tbl.reloadData()
            
            print(remindersList.count)
        }catch{
            print("error")
        }
    }
    
    
    
    
    
    

}




//------------------DATA SOURCE-------------------//




extension ViewController : UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return remindersList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        ///
        ///creating reminders cell in ui
        let cell = tableView.dequeueReusableCell(withIdentifier: "remindercell", for: indexPath) as! RemindersCellGR
        
        // bind the data
        let reminder = remindersList[indexPath.row]
        cell.cellTitleLabel.text = reminder.title
        cell.cellTypeLabel.text = "type: \(reminder.type ?? "")"
        
        let selectedDate = reminder.date!
        let formatingDate = DateFormatter()
        formatingDate.dateFormat = "dd/MM/yyyy"
        let dateString = formatingDate.string(from: selectedDate)
        
        cell.cellDateLabel.text = dateString
        
        
        
        
//        let selectedTime = reminder.date!
//        let formatingTime = DateFormatter()
//        formatingTime.dateFormat = "HH:mm"
//        let timeString = formatingTime.string(from: selectedTime)
        
        let formattingTime = DateFormatter()
        formattingTime.dateFormat = "h:mm a"  // "h" for 12-hour format, "a" for AM/PM
        let timeString = formattingTime.string(from: selectedDate )  // Replace 'yourDate' with your date value
        print(timeString)  // This will print the time in 12-hour clock format

                
        cell.celltimeLabel.text = timeString
        
        
        
        
        
        
//        cell.celltimeLabel.text = "time : \(reminder.time)"
//        cell.cellDateLabel.text = "Date : \(reminder.date!)"
        print("poupulated data")
        
        return cell
    }
    
    
}


//-----------DELEGATE----------------------------//


extension ViewController : UITableViewDelegate
{
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let rem = remindersList[indexPath.row]
        
        let deleteAction = UIContextualAction(style: .destructive, title: "delete reminder") { _, _, _ in
            
            do{
                try RemindersUtilityGR.instance.deleteReminder(remToDelete: rem)
                self.remindersList.remove(at: indexPath.row) // list update
                self.tbl.deleteRows(at: [indexPath], with: .automatic)
                
            }catch{
                self.showAlert(title: "oops! try again", msg: nil)
            }
        }
        deleteAction.image = UIImage(systemName: "trash.fill")
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        var rem = remindersList[indexPath.row]
       
//       // let des : String
//
//        do {
//            
//          des =  try RemindersUtilityGR.instance.getRemindersList().description
//        }catch{
//            print("not found")
//        }
//        print(tableView.description)
        
        showAlert(title: "Description", msg:  rem.desc ?? "" )
    }
}



    




