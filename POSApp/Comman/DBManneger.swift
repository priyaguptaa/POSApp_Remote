//
//  DBManneger.swift
//  RestaurantMannegmentDemo1
//
//  Created by priya gupta on 21/11/17.
//  Copyright © 2017 Neosofttech Technologies. All rights reserved.
//

import Foundation
class DBManager: NSObject {
    var fieldFirstName = "firstName"
    var fieldLastName = "lastName"
    var fieldEmail = "email"
    var fieldPassword = "password"
    var autoIncrementId = "Id"
    
    var field_Name = "name"
    var field_Password = "password"
    var field_Role = "role"
    var field_Contact = "contact"
    var field_Address = "address"
    var field_Rate = "rate"
    var field_Hourly = "hourly"
    
    static let shared: DBManager = DBManager()
    
    let databaseFileName = "POSDB.sqlite"
    
    var pathToDatabase: String!
    
    var database: FMDatabase!
  
    func fetchTextFieldValue(withFirstName firstName: String, withLastName lastName: String, withEmail email: String, withPassword password: String){
    }
    override init() {
        super.init()
        
        let documentsDirectory = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString) as String
        pathToDatabase = documentsDirectory.appending("/\(databaseFileName)")
    }
    func createDatabase() -> Bool {
        var created = false
        
        if !FileManager.default.fileExists(atPath: pathToDatabase) {
            database = FMDatabase(path: pathToDatabase!)
            
            if database != nil {
                // Open the database.
                if database.open() {
                    let createUserTableQuery = "create table POSUSER (\(autoIncrementId) integer primary key autoincrement not null, \(fieldFirstName) text not null, \(fieldLastName) text not null, \(fieldEmail) text not null, \(fieldPassword) text not null)"
                    
                    do {
                        try database.executeUpdate(createUserTableQuery, values: nil)
                        created = true
                        print("table created")
                    }
                    catch {
                        print("Could not create table.")
                        print(error.localizedDescription)
                    }
                    self.createTable()
                    database.close()
                }
                else {
                    print("Could not open the database.")
                }
            }
        }
        
        return created
    }
    func openDatabase() -> Bool {
        if database == nil {
            if FileManager.default.fileExists(atPath: pathToDatabase) {
                database = FMDatabase(path: pathToDatabase)
            }
        }
        
        if database != nil {
            if database.open() {
                return true
            }
        }
        
        return false
    }
    
    func insertIntoPosUser(fname : String, lname : String, email : String, pwd : String) {
        
        if openDatabase() {
            do {
                var query = ""
                query = "insert into POSUSER (\(autoIncrementId),\(fieldFirstName), \(fieldLastName),\(fieldEmail), \(fieldPassword)) values (null, '\(fname)', '\(lname)','\(email)', '\(pwd)');"
                
                if !database.executeStatements(query) {
                    print("Failed to insert initial data into the database.")
                    print(database.lastError(), database.lastErrorMessage())
                }
                print("data inserted")
                
            }
           
            database.close()
        }
    }
    
    func fetchUsers(email : String) -> [UserInfo] {
        var users: [UserInfo] = []

        if  openDatabase()  {
            
                let queryStr = "select * from POSUSER where  \(fieldEmail)=? "
            
            do {
                print(database)
                let results = try database.executeQuery(queryStr, values: [email])
                    while results.next() {
                        let user = UserInfo (userId: Int(results.int(forColumn: self.autoIncrementId)), firstName: results.string(forColumn: self.fieldFirstName), lastName: results.string(forColumn: self.fieldLastName), email : results.string(forColumn: self.fieldEmail), password : results.string(forColumn: self.fieldPassword))
                        
                        print(" data printed: \(user)")
                        users.append(user)
                    }
               
                }
            
            catch {
                print(error.localizedDescription)
            }
            database.close()
        }
      
    return users
    }
    func updateUserInfo(firstName: String, lastName: String, email: String) {
        if openDatabase() {
            let query = "update POSUSER set \(fieldFirstName)=?, \(fieldLastName)=? where \(fieldEmail)=?"
            
            do {
                
                try database.executeUpdate(query, values: [firstName, lastName, email])
                
            }
            catch {
                print(error.localizedDescription)
            }
            
            database.close()
        }
    }
    
    func createTable() -> Bool {
        var created = false
        
        if FileManager.default.fileExists(atPath: pathToDatabase) {
            database = FMDatabase(path: pathToDatabase!)
            
            if database != nil {
                
                if database.open() {
                    let createUserTableQuery = "create table POSEmployee (\(autoIncrementId) integer primary key autoincrement not null, \(field_Name) text not null, \(field_Password) text not null, \(field_Role) text not null, \(field_Contact) text not null,\(field_Address) text not null, \(field_Rate) text not null, \(field_Hourly) text not null)"
                    
                    do {
                        try database.executeUpdate(createUserTableQuery, values: nil)
                        created = true
                        print("table created")
                    }
                    catch {
                        print("Could not create table.")
                        print(error.localizedDescription)
                    }
        
                    database.close()
                }
                else {
                    print("Could not open the database.")
                }
            }
        }
        
        return created
    }
    func insertIntoPOSEmployee(name : String, pwd : String, contact : String, address : String,role : String,rate : String,hourly : String) {
        
        if openDatabase() {
            do {
                var query = ""
                query = "insert into POSEmployee (\(autoIncrementId),\(field_Name), \(field_Password),\(field_Role), \(field_Contact), \(field_Address),\(field_Rate), \(field_Hourly)) values (null, '\(name)', '\(pwd)','\(contact)', '\(address)', '\(role)', '\(rate)', '\(hourly)');"
                
                if !database.executeStatements(query) {
                    print("Failed to insert initial data into the database.")
                    print(database.lastError(), database.lastErrorMessage())
                }
                print("data inserted")
                
            }
            
            database.close()
        }
    }
    
    
    func fetchEmployeeInfo() -> [EmployeeInfo] {
        var users: [EmployeeInfo] = []
        
        if  openDatabase()  {
            
            let queryStr = "select * from POSEmployee"
            
            do {
                print(database)
                let results = try database.executeQuery(queryStr, values:nil)
                while results.next() {
                    let user = EmployeeInfo (employeeId: Int(results.int(forColumn: self.autoIncrementId)), EmployeeName: results.string(forColumn: self.field_Name), password: results.string(forColumn: self.field_Password), role : results.string(forColumn: self.field_Role), contact : results.string(forColumn: self.field_Contact), address : results.string(forColumn: self.field_Address), rate : results.string(forColumn: self.field_Rate), hourly : results.string(forColumn: self.field_Hourly))
                    
                    
                    print(" data printed: \(user)")
                    users.append(user)
                }
                
            }
                
            catch {
                print(error.localizedDescription)
            }
            database.close()
        }
        
        return users
    }
    func updateEmployeeInfo(name : String, pwd : String, contact : String, address : String,role : String,rate : String,hourly : String) {
        if openDatabase() {
            let query = "update POSEmployee set \(field_Name)=?, \(field_Password)=?, \(field_Role)=?, \(field_Contact)=?, \(field_Address)=?, \(field_Rate)=?, \(field_Hourly)=? where \(field_Name)=?"
            
            do {
                try database.executeUpdate(query, values: [name, pwd,contact,address,role,rate,hourly,name])
            }
            catch {
                print(error.localizedDescription)
            }
            
            database.close()
        }
    }
    func deleteEmployeeInfo(withId Id :Int) -> Bool {
        var deleted = false
        
        if openDatabase() {
            let query = "delete from POSEmployee where \(autoIncrementId)=?"
            
            do {
                try database.executeUpdate(query, values: [Id])
                deleted = true
            }
            catch {
                print(error.localizedDescription)
            }
            
            database.close()
        }
        
        return deleted
    }
}

