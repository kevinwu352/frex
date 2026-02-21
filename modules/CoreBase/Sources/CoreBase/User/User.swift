//
//  User.swift
//  CoreBase
//
//  Created by Kevin Wu on 2/15/26.
//

import Foundation

public struct User: Codable, Equatable, Sendable {
  public let id: Int
  public let name: String
  public let username: String
  public let email: String
  public let phone: String
  public let website: String
  public let token: String

  public init() {
    id = 0
    name = ""
    username = ""
    email = ""
    phone = ""
    website = ""
    token = ""
  }

  public init(
    id: Int,
    name: String,
    username: String,
    email: String,
    phone: String,
    website: String,
    token: String
  ) {
    self.id = id
    self.name = name
    self.username = username
    self.email = email
    self.phone = phone
    self.website = website
    self.token = token
  }

  public func copyWith(
    id: Int? = nil,
    name: String? = nil,
    username: String? = nil,
    email: String? = nil,
    phone: String? = nil,
    website: String? = nil,
    token: String? = nil
  ) -> Self {
    .init(
      id: id ?? self.id,
      name: name ?? self.name,
      username: username ?? self.username,
      email: email ?? self.email,
      phone: phone ?? self.phone,
      website: website ?? self.website,
      token: token ?? self.token
    )
  }
}

public typealias Users = [User]

extension User {
  public static func load(username: String, token: String) -> User? {
    do {
      let data = try dataRead(pathmk("user.json", uid: username))
      let obj = try JSONDecoder().decode(Self.self, from: data)
      let user = obj.copyWith(token: token)
      print("user, load success, \(username) \(token)")
      return user
    } catch {
      print("user, load failed, \(username) \(token)")
      return nil
    }
  }
  public func save() {
    guard !username.isEmpty else { return }
    do {
      let user = copyWith(token: "")
      let data = try JSONEncoder().encode(user)
      try dataWrite(pathmk("user.json", uid: username), data: data)
      print("user, save success, \(username)")
    } catch {
      print("user, save failed, \(username)")
    }
  }
}

extension User {
  public static let kevin = User(
    id: 1,
    name: "Kevin",
    username: "kevin110",
    email: "kevin@gmail.com",
    phone: "13500001111",
    website: "kevin.com",
    token: "token111"
  )
  public static let eric = User(
    id: 1,
    name: "Eric",
    username: "eric110",
    email: "eric@gmail.com",
    phone: "13500002222",
    website: "eric.com",
    token: "token222"
  )
}
