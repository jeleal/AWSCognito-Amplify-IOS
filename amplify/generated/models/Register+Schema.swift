// swiftlint:disable all
import Amplify
import Foundation

extension Register {
  // MARK: - CodingKeys 
   public enum CodingKeys: String, ModelKey {
    case id
    case name
    case lastname
    case username
    case mail
    case priority
  }
  
  public static let keys = CodingKeys.self
  //  MARK: - ModelSchema 
  
  public static let schema = defineSchema { model in
    let register = Register.keys
    
    model.pluralName = "Registers"
    
    model.fields(
      .id(),
      .field(register.name, is: .required, ofType: .string),
      .field(register.lastname, is: .required, ofType: .string),
      .field(register.username, is: .required, ofType: .string),
      .field(register.mail, is: .required, ofType: .string),
      .field(register.priority, is: .optional, ofType: .enum(type: Priority.self))
    )
    }
}