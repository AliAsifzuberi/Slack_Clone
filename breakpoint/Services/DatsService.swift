//
//  DatsService.swift
//  breakpoint
//
//  Created by Ali Zuberi  on 2018-11-24.
//  Copyright © 2018 Ali Zuberi . All rights reserved.
//

import Foundation
import Firebase

// get firebase root refernce(base url)
let DB_BASE = Database.database().reference()

class DataService {
    static let instance = DataService()
    
    //private variables to create childs
    private var _REF_BASE = DB_BASE
    private var _REF_USERS = DB_BASE.child("users")
    private var _REF_GROUPS = DB_BASE.child("groups")
    private var _REF_FEED = DB_BASE.child("feed")
   
    // public variable
    var REF_BASE :DatabaseReference {
        return _REF_BASE
    }
    
    var REF_USERS :DatabaseReference {
        return _REF_USERS
    }
    
    var REF_GROUPS :DatabaseReference {
        return _REF_GROUPS
    }
    
    var REF_FEED :DatabaseReference {
        return _REF_FEED
    }
    
    // creating db user
    func createDBUer(uid :String, userData:Dictionary<String, Any>) {
        REF_USERS.child(uid).updateChildValues(userData)
    }
    
    // function upload post
    
    func uploadPost(withMessage message:String, forUID uid: String, WithGroupKey groupKey: String?, sendComplete: @escaping(_ status: Bool) -> ()) {
        // check if there is group key
        
        if groupKey != nil {
            REF_GROUPS.child(groupKey!).child("messages").childByAutoId().updateChildValues(["content" : message, "senderID": uid])
            sendComplete(true)
        } else {
            // pass it into the feed
            REF_FEED.childByAutoId().updateChildValues(["content": message, "senderID": uid])
            sendComplete(true)
            
        }
        
        
        
        
    }
    
    // fucntion to get messages from firebase database also returns an array of messages
    func getAllFeedMessages(handler: @escaping (_ messages: [Message]) -> ()) {
        var messageArray = [Message]()
        REF_FEED.observeSingleEvent(of: .value) { (feedMessageSnapshot) in
            guard let feedMessageSnapshot = feedMessageSnapshot.children.allObjects as? [DataSnapshot] else { return }
            // loop goes through data snapshot and appends all data to the messageArray
            for message in feedMessageSnapshot {
                let content = message.childSnapshot(forPath: "content").value as! String
                let senderID = message.childSnapshot(forPath: "senderID").value as! String
                // creates a message using messagae model in class
                let message = Message(content: content, senderID: senderID)
                
                messageArray.append(message)
                
            }
            
            handler(messageArray)
        }
        
    }
    
    // function to switch uid to email or username
    
    func getUsername(forUID uid:String, handler: @escaping (_ username:String) -> ()) {
        REF_USERS.observeSingleEvent(of: .value) { (userSnapshot) in
            guard let userSnapshot = userSnapshot.children.allObjects as? [DataSnapshot] else {return}
            for user in userSnapshot {
                if user.key == uid {
                    handler(user.childSnapshot(forPath: "email").value as! String)
                }
            }
            
        }
        
    }
    
    
    
    // function to search for emails from database
    
    func getEmail(forSearchQuery query: String, handler: @escaping (_ emailArray: [String]) -> ()){
        
        var emailArray = [String]()
        REF_USERS.observe(.value) { (userSnapshot) in
            guard let userSnapshot = userSnapshot.children.allObjects as? [DataSnapshot] else {return}
            for user in userSnapshot {
                let email = user.childSnapshot(forPath: "email").value as! String
                
                if email.contains(query) == true && email != Auth.auth().currentUser?.email  {
                    emailArray.append(email)
                    
                }
            }
            handler(emailArray)
            
        }
        
    }
    // get user ID's
    func getIds(forUsernames usernames: [String], handler: @escaping (_ uidArray: [String]) -> ()) {
        REF_USERS.observeSingleEvent(of: .value) { (userSnapshot) in
            var idArray = [String]()
            guard let userSnapshot = userSnapshot.children.allObjects as? [DataSnapshot] else {return}
            for user in userSnapshot {
                  let email = user.childSnapshot(forPath: "email").value as! String
                if usernames.contains(email){
                    idArray.append(user.key)
                    print("ALIZUBEIR",idArray)
                }
            }
            handler(idArray)
            
        }
    }
    
    // creating group function
    
    func createGropu(withTitle title:String, andDescritpiton description:String, forUSerIds ids: [String], handler: @escaping (_ groupCreated: Bool) -> ()) {
        REF_GROUPS.childByAutoId().updateChildValues(["title": title, "descrtiption": description, "members":ids])
        
        handler(true)
    }
    
    // push or upload all the groups from firebase
    
    func CreatGroup(withTitle title:String, andDescription description:String, forUserIds: [String], handler: @escaping (_ groupCreated:Bool)->()) {
        REF_GROUPS.childByAutoId().updateChildValues(["title": title, "description": description, "members": forUserIds])
        handler(true)
    }
    
    
    // function to get all group
    
    func getAllGroups(handler: @escaping (_ groupsArray: [Group]) -> ()) {
        var groupsArray = [Group]()
        REF_GROUPS.observeSingleEvent(of: .value) { (groupSnapshot) in
            guard let groupSnapshot = groupSnapshot.children.allObjects as? [DataSnapshot] else {return}
            for group in groupSnapshot {
                let memberArray = group.childSnapshot(forPath: "members").value as! [String]
                if memberArray.contains((Auth.auth().currentUser?.uid)!) {
                    let title = group.childSnapshot(forPath: "title").value as! String
                    let descritption = group.childSnapshot(forPath: "descrtiption").value as! String
                    let group = Group(title: title, descritption: descritption, key: group.key, members: memberArray, membersCound: memberArray.count)
                    groupsArray.append(group)
                    
                }
            }
            
            handler(groupsArray)
        }
    }
    
    
    // get all group messages for group
    
    
    func getAllMessagesFor(desiredGroup: Group, handler: @escaping (_ messagesArray: [Message])->()) {
        var groupMessageArray = [Message]()
        REF_GROUPS.child(desiredGroup.Key).child("messages").observeSingleEvent(of: .value) { (groupMessageSnapshot) in
            guard let groupMessageSnapshot = groupMessageSnapshot.children.allObjects as? [DataSnapshot] else {return}
            for groupMessage in groupMessageSnapshot {
                let content = groupMessage.childSnapshot(forPath: "content").value as! String
                let senderID = groupMessage.childSnapshot(forPath: "senderID").value as! String
                let groupmessage = Message(content: content, senderID: senderID)
                groupMessageArray.append(groupmessage)
            }
            handler(groupMessageArray)
        }
    }
    
}
