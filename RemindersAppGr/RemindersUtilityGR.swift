//
//  RemindersUtilityGR.swift
//  RemindersAppGr
//
//  Created by Gourishanker on 09/10/23.
//

import Foundation
import UIKit

struct RemindersUtilityGR
{
    
    private init()
    {
        
    }
    static var instance = RemindersUtilityGR()
    var dbConText = (UIApplication.shared        .delegate as! AppDelegate).persistentContainer.viewContext
    
    
    
    
    func addReminder(title : String , type : String , date : Date , time: Date, desc : String, notification : Bool) throws
    {
        let rem = RemindersTable(context: dbConText)
        rem.title = title
        rem.desc = desc
        rem.date = date
        rem.time = time
        rem.notification = notification
        
        rem.type = type
        
        try dbConText.save()
       // ReminderVCtbl.reloadData()
        
        
        
        
        
    }
    
    
    func deleteReminder(remToDelete : RemindersTable) throws
    {
        dbConText.delete(remToDelete)
        try dbConText.save()
    }
    
    
    func getRemindersList() throws -> [RemindersTable]
    {
        
            let fRequest = RemindersTable.fetchRequest()
            
            let result = try dbConText.fetch(fRequest)
            
            return result
        
    }
    
}
