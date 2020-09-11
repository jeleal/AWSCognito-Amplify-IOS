//
//  ContentView.swift
//  AWSCognito
//
//  Created by Jeremy Leal on 11/09/2020.
//  Copyright © 2020 Jeremy Leal. All rights reserved.
//

import SwiftUI
import Amplify
import AmplifyPlugins

struct ContentView: View {
    func doQuery() {
        let item = Todo(
            name: "Build iOS Application",
            description: "Build an iOS application using Amplify"
        )
        
        Amplify.DataStore.save(item) {
            (result) in switch(result) {
            case .success(let savedItem):
                print("Saved item: \(savedItem.name)")
            case .failure(let error):
                print("Could not save item to datastore: \(error)")
            }
        }
    }
    
    func getQuery() {
        Amplify.DataStore.query(Todo.self, completion: { result in
            switch(result) {
            case .success(let todos):
                for todo in todos {
                    print("==== Todo ====")
                    print("Name: \(todo.name)")
                    if let priority = todo.priority {
                        print("Priority: \(priority)")
                    }
                    if let description = todo.description {
                        print("Description: \(description)")
                    }
                }
            case .failure(let error):
                print("Could not query DataStore: \(error)")
            }
        })
    }
    
    func updateQuery() {
        Amplify.DataStore.query(
            Todo.self,
            where: Todo.keys.name.eq("Finish quarterly taxes"), completion: { result in
            switch(result) { case .success(let todos):
                guard todos.count == 1, var updatedTodo = todos.first else {
                    print("Did not find exactly one todo, bailing")
                    return
                }
                updatedTodo.name = "File quarterly taxes"
                Amplify.DataStore.save(updatedTodo, completion: { result in
                    switch(result) { case .success(let savedTodo):
                        print("Updated item: \(savedTodo.name )")
                    case .failure(let error):
                        print("Could not update data in Datastore: \(error)")
                    }
                })
            case .failure(let error):
                print("Could not query DataStore: \(error)")
            }
        })
    }
    
    func deleteQuery() {
        Amplify.DataStore.query(
            Todo.self,
            where: Todo.keys.name.eq("File quarterly taxes"), completion: {
                result in
             switch(result) {
             case .success(let todos):
                guard todos.count == 1, let toDeleteTodo = todos.first else {
                     print("Did not find exactly one todo, bailing")
                     return
                }
                Amplify.DataStore.delete(toDeleteTodo, completion: {
                    result in
                    switch(result) {
                    case .success:
                        print("Deleted item: \(toDeleteTodo.name)")
                    case .failure(let error):
                        print("Could not update data in Datastore: \(error)")
                    }
                })
             case .failure(let error):
                print("Could not query DataStore: \(error)")
            }
        })
    }

    var body: some View {
        VStack {
            Text("Hello, World!")
                .onAppear(){
                    self.doQuery()
            }
//            Button(action: { self.doQuery() }){
//                Text("Do query")
//            }
//            Button(action: { self.getQuery() }){
//                Text("Get query")
//            }
//            Button(action: { self.updateQuery() }){
//                Text("Update query")
//            }
//            Button(action: { self.deleteQuery() }){
//                Text("Delete query")
//            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
