// swiftlint:disable all
import Amplify
import Foundation

public struct Register: Model {
  public let id: String
  public var name: String
  public var lastname: String
  public var username: String
  public var mail: String
  public var priority: Priority?
  
  public init(id: String = UUID().uuidString,
      name: String,
      lastname: String,
      username: String,
      mail: String,
      priority: Priority? = nil) {
      self.id = id
      self.name = name
      self.lastname = lastname
      self.username = username
      self.mail = mail
      self.priority = priority
  }
}