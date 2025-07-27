//
//  File.swift
//  swift-authentication
//
//  Created by Coen ten Thije Boonkkamp on 27/07/2025.
//

import Foundation
import Parsing

extension Conversion {
    @inlinable
    @_disfavoredOverload
    public static func memberwise<Values, Struct>(
        _ initializer: @escaping (Values) throws -> Struct
    ) -> Self where Self == Conversions.ThrowingMemberwise<Values, Struct> {
        .init(initializer: initializer)
    }
}

extension Conversions {
    public struct ThrowingMemberwise<Values, Struct>: Conversion {
        @usableFromInline
        let initializer: (Values) throws -> Struct
        
        @usableFromInline
        init(initializer: @escaping (Values) throws -> Struct) {
            self.initializer = initializer
        }
        
        @inlinable
        public func apply(_ input: Values) throws -> Struct {
            try self.initializer(input)
        }
        
        @inlinable
        public func unapply(_ output: Struct) throws -> Values {
            let ptr = unsafeBitCast(Struct.self as Any.Type, to: UnsafeRawPointer.self)
            guard ptr.load(as: Int.self) == 512
            else {
                throw ConvertingError(
            """
            memberwise: Can't convert \(Values.self) to non-struct type \(Struct.self). This \
            conversion should only be used with a memberwise initializer matching the memory layout \
            of the struct. The "memberwise" initializer is the internal, compiler-generated \
            initializer that specifies its arguments in the same order as the struct specifies its \
            properties.
            """
                )
            }
            guard
                MemoryLayout<Struct>.alignment == MemoryLayout<Values>.alignment,
                MemoryLayout<Struct>.size == MemoryLayout<Values>.size
            else {
                throw ConvertingError(
            """
            memberwise: Can't convert \(Values.self) type \(Struct.self) as their memory layouts \
            differ. This conversion should only be used with a memberwise initializer matching the \
            memory layout of the struct. The "memberwise" initializer is the internal, \
            compiler-generated initializer that specifies its arguments in the same order as the \
            struct specifies its properties.
            """
                )
            }
            return unsafeBitCast(output, to: Values.self)
        }
    }
}


@usableFromInline
struct ConvertingError: Error {
  @usableFromInline
  let message: String

  @usableFromInline
  init(_ message: String = "") {
    self.message = message
  }
}
