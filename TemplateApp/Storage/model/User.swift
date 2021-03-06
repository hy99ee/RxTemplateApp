import Foundation

struct User {
    let id: Int
    let name: String
    let description: String
    let age: Int

    static func create() -> User {
        User(
            id: Int.random(in: ClosedRange(uncheckedBounds: (lower: 0, upper: 100))),
            name: "Name",
            description: "Description",
            age: 99
        )
    }

    func sequence() -> [String] {
        [String(self.id), self.name, self.description, String(self.age)]
    }
}
