public struct AtomicCharacter: Equatable {
    
    /// The value associated with this atomic character.
    public let rawValue: Character
    
    /// The type of this atomic character.
    public var type: AtomicType
    
    /// A boolean value that indicates whether the letter case of the character is correct.
    ///
    /// - Note: `Nil` value means that the letter case doesn't matter.
    /// This is when the text is leaded to a certain version, for example, to its lowercase version.
    public var hasCorrectLetterCase: Bool?
    
    /// An uppercase version of this atomic character.
    ///
    ///     let atomicCharacter = AtomicCharacter("a", type: .misspell("b"))
    ///     print(atomicCharacter.uppercased)
    ///     // AtomicCharacter("A", type: .misspell("B"))
    ///
    internal var uppercased: AtomicCharacter {
        let newRawValue = rawValue.uppercased().toCharacter!
        let newType: AtomicType
        switch self.type {
        case .misspell(let correctChar):
            let newCorrectChar = correctChar.uppercased().toCharacter!
            newType = AtomicType.misspell(newCorrectChar)
        default:
            newType = type
        }
        return AtomicCharacter(newRawValue, type: newType)
    }
    
    /// A lowercase version of this atomic character.
    ///
    ///     let atomicCharacter = AtomicCharacter("A", type: .misspell("B"))
    ///     print(atomicCharacter.lowercased)
    ///     // AtomicCharacter("a", type: .misspell("b"))
    ///
    internal var lowecased: AtomicCharacter {
        let newRawValue = rawValue.lowercased().toCharacter!
        let newType: AtomicType
        switch self.type {
        case .misspell(let correctChar):
            let newCorrectChar = correctChar.lowercased().toCharacter!
            newType = AtomicType.misspell(newCorrectChar)
        default:
            newType = type
        }
        return AtomicCharacter(newRawValue, type: newType)
    }
    
    /// Creates an atomic character instance.
    public init(_ rawValue: Character, type: AtomicType, hasCorrectLetterCase: Bool? = nil) {
        self.rawValue = rawValue
        self.type = type
        self.hasCorrectLetterCase = hasCorrectLetterCase
    }
    
}


extension AtomicCharacter {
    
    public enum AtomicType: Equatable {
        case correct, swapped, missing, extra
        case misspell(_ correctChar: Character)
        
        public init() { self = .extra }
    }
    
}


extension AtomicCharacter {
    
    public static func == (lhs: AtomicCharacter, rhs: AtomicCharacter) -> Bool {
        if lhs.rawValue == rhs.rawValue, lhs.type == rhs.type, lhs.hasCorrectLetterCase == rhs.hasCorrectLetterCase {
            return true
        } else {
            return false
        }
    }
    
}
