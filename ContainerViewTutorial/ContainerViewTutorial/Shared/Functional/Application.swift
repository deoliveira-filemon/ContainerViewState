// swiftlint:disable identifier_name

// MARK: - Forward function application

precedencegroup ForwardApplication {
    associativity: left
    higherThan: AssignmentPrecedence, NilCoalescingPrecedence
}

infix operator |>: ForwardApplication

/// Forward function application.
///
/// Applies the function on the right to the value on the left.
/// Functions of >1 argument can be applied by placing their arguments in a tuple on the left hand side.
///
/// This is a useful way of clarifying the flow of data through a series of functions.
/// For example, you can use this to count the base-10 digits of an integer:
///
///     `let digits = 100 |> toString |> count // => 3`
func |> <A, B>(a: A, f: (A) -> B) -> B {

    return f(a)
}

@discardableResult
func |> <A: AnyObject>(a: A, f: (A) -> Void) -> A {

    f(a)
    return a
}

// give the type inferrer a hand so that this idiom can be used on non Void returning functions without explicit types
func |> <A: AnyObject, B>(a: A, f: (A) -> B) -> B {

    return f(a)
}

infix operator ?|>: ForwardApplication

@discardableResult
func ?|> <A, B>(a: A?, f: (A) -> B) -> B? {

    guard let a = a else { return nil }

    return f(a)
}

@discardableResult
func ?|> <A: AnyObject>(a: A?, f: (A) -> Void) -> A? {

    guard let a = a else { return nil }

    f(a)
    return a
}

// give the type inferrer a hand so that this idiom can be used on non Void returning functions without explicit types
@discardableResult
func ?|> <A: AnyObject, B>(a: A?, f: (A) -> B) -> B? {

    guard let a = a else { return nil }

    return f(a)
}

// MARK: - Backward function application

precedencegroup BackwardApplication {
    associativity: right
    higherThan: AssignmentPrecedence
}

infix operator <|: BackwardApplication

/// Backward function application.
///
/// Applies the function on the left to the value on the right.
/// Functions of >1 argument can be applied by placing their arguments in a tuple on the right hand side.
func <| <A, B>(f: (A) -> B, a: A) -> B {

    return f(a)
}

@discardableResult
func <| <A: AnyObject>(f: (A) -> Void, a: A) -> A {

    f(a)
    return a
}

// give the type inferrer a hand so that this idiom can be used on non Void returning functions without explicit types
func <| <A: AnyObject, B>(f: (A) -> B, a: A) -> B {

    return f(a)
}
