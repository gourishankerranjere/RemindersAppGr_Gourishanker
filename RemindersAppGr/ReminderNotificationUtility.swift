//
//  ReminderNotificationUtility.swift
//  RemindersAppGr
//
//  Created by Gourishanker on 14/10/23.
//

import Foundation
import UserNotifications

class ReminderNotificationUtility
{
    let notificationCentre = UNUserNotificationCenter.current()
    
    
    var isAuthorized = false
    init()
    {
        askAuthorization()
    }
    
    
    func askAuthorization()
    {
        notificationCentre.getNotificationSettings { setting in
            
            if setting.authorizationStatus  == .authorized{
                print("already authorized")
                self.isAuthorized = true
            }else{
                print("not authorized")
                self.notificationCentre.requestAuthorization(options: [.alert,.badge,.sound]) { allowed, _ in
                    if allowed{
                        print("permission granted")
                        self.isAuthorized = true
                    }else{
                        print("permission denied")
                        self.isAuthorized = false
                    }
                }
            }
        }
    }
    
    
    
    
    func addReminderNotifcation(titleN : String ,descN : String, dateN : Date)
    {
        let content = UNMutableNotificationContent()
        content.title = titleN
        content.body = descN
        content.sound = .default
        //content.badge = 1
        
        
        
       
        var  dComponent = DateComponents()
        
        dComponent.calendar = .current
        
       // dComponent.timeZone = .current
        
        let formatingDay =  DateFormatter()
        formatingDay.dateFormat = "dd"
        let dayString = formatingDay.string(from: dateN)
        
        let formatingMonth =  DateFormatter()
        formatingMonth.dateFormat = "MM"
        let monthString = formatingMonth.string(from: dateN)
        
        let formatingHour =  DateFormatter()
        formatingHour.dateFormat = "hh"
        let hourString = formatingHour.string(from: dateN)
        
        
        let formatingMin =  DateFormatter()
        formatingMin.dateFormat = "mm"
        let minString = formatingMin.string(from: dateN)
        
       
        
        print(dateN.description)
        
        dComponent.day = Int(dayString)
        
        
        
        
        dComponent.month = Int(monthString)
        
        
        
        dComponent.hour = Int(hourString)
        
        dComponent.minute = Int(minString)
        
        
        
        
//        if let x = Int(minString) {
//            print(x)
//            dComponent.minute = x
//        }else{
//            print("error conerting")
//        }
//        type(of: dComponent.minute)
       // dComponent.
        
        
        // 2. create trigger
//       let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
        
        let newDate = dateN.addingTimeInterval(-10 * 60)

                

                var dComp = Calendar.current.dateComponents([.day,.month, .year, .hour, .minute], from: newDate)

                
        let trigger = UNCalendarNotificationTrigger(dateMatching: dComp, repeats: false)
        
        
        // 3. add request
        
        let req =  UNNotificationRequest(identifier: "meeting", content: content, trigger: trigger)
        notificationCentre.add(req)
        
        
    }
    
}
