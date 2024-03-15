
# Basics of Swift

**Q:** What is Swift, and what makes it different from Objective-C?
**A:** Here are some key differences between Swift and Objective-C:

`Syntax`: One of the most apparent differences is in the syntax. Swift has a more `modern` and `concise` syntax compared to Objective-C. It adopts features from other modern programming languages like `Python` and `Ruby`, making it easier to read and write code.

`Safety`: Swift was designed with safety in mind. It provides features like `optionals`, which help prevent `null pointer errors`, and `type interference`, which reduces the likelihood of type-related bugs. Objective-C, being a superset of C, doesn't have these features built-in.

`Performance`: Swift is often touted as being faster than Objective-C due to various language design decisions and optimization efforts by Apple. However, the difference might not always be significant, and it depends on the specific use case.

`Interoperability`: Swift is designed to work seamlessly with existing Objective-C codebases. You can integrate Swift into Objective-C projects and vice versa, allowing developers to gradually adopt Swift without rewriting their entire codebase.

`Open Source`: Swift is an open-source language, allowing developers to contribute to its development, report bugs, and even port it to other platforms. This openness fosters a vibrant community around the language and accelerates its evolution.

`Playgrounds`: Swift comes with a feature called Playgrounds, which provides an `interactive environment` for experimenting with Swift code. This feature is particularly useful for learning Swift and quickly prototyping ideas.

Overall, while both Swift and Objective-C are capable programming languages for Apple's platforms, Swift's modern syntax, safety features, and performance improvements make it an attractive choice for many developers. However, Objective-C still has its place, especially in legacy projects and when working with existing codebases.


**Q:** Explain the concept of type inference in Swift?
**A:** Type inference in Swift is a feature that allows the compiler to automatically deduce the data type of a variable or expression based on its initial value and context, `without requiring explicit type annotations` from the programmer.

Here's how type inference works in Swift:

`Variable Initialization`: When you declare and initialize a variable using the var keyword without specifying its type explicitly, Swift infers the type from the type of the initial value assigned to it.

```
var number = 42 // Inferred type: Int
var message = "Hello, world!" // Inferred type: String
```

`Function Return Types`: Swift can also infer the return type of functions based on the types of values returned from within the function body.

```
func add(a: Int, b: Int) -> Int {
    return a + b // Inferred return type: Int
}
```

`Expression Evaluation`: When you perform operations or expressions involving variables or literals, Swift uses type inference to determine the resulting type.

```
let result = 3.14 * 2 // Inferred type: Double
```

`Collections`: When you create arrays, dictionaries, or other collection types, Swift infers the type of the collection based on the types of the elements provided.
```
let numbers = [1, 2, 3, 4, 5] // Inferred type: [Int]
let person = ["name": "John", "age": 30] // Inferred type: [String: Any]
```

**Q:** Discuss the differences between value types and reference types in Swift.
**A:** In Swift, types can be categorized into two main categories based on `how they are stored` and `passed around in memory`: `value types` and `reference types`.

Value Types:

`Data Storage`: For value types, data is stored in `stack` memory.

`Assignment`: When you assign a value type to another variable, a copy of the data is made. Changes to one copy of the data do not affect the other copies.

`Example Types`: _Structs, enums, integers, floating-point numbers, booleans, strings, arrays,_ and _dictionaries_ are all examples of value types.

`Immutability`: Value types are often `immutable` by default, meaning their properties cannot be modified after initialization, unless they are declared with var and marked as mutable.

`Passing by Value`: When passing a value type as an argument to a function or method, a copy of the value is passed.

Reference Types:

`Data Storage`: Reference types store a reference (or pointer)(of heap memory) to the location in memory where the actual data is stored(Stack). When you create a new instance of a reference type, you're essentially creating a new reference to the same data.

`Assignment`: When you assign a reference type to another variable, both variables point to the same underlying data. Changes made through one reference affect all other references to the same data.

`Example Types`: `Classes` are the primary example of reference types in Swift. `Functions` and `closures` are also reference types.

`Mutability`: Reference types are `mutable` by default. Changes made to properties of an instance through one reference affect all other references to the same instance.

`Passing by Reference`: When passing a reference type as an argument to a function or method, a reference to the same instance is passed. Changes made to the instance within the function affect the original instance outside the function.

Differences in Usage:

`Performance`: Value types are generally more efficient in terms of memory usage and can lead to better performance in certain scenarios. Reference types, on the other hand, involve additional overhead due to memory allocation and deallocation.

`Mutability and Immutability`: Value types are often immutable by default, while reference types are mutable by default. This impacts how you design and use types in your codebase.

`Copying Behavior`: Value types are copied when assigned to a new variable or passed as a function argument, while reference types are not copied, but rather referenced.

**Q:** What is type aliasing in Swift, and why might you use it?
**A:** Type aliasing in Swift is a feature that allows you to create alternate names for existing types.

`Readability`: Creating aliases with more descriptive names can make your code easier to understand, especially when dealing with complex types or generics.

`Abstraction`: Type aliases can hide implementation details and provide a more abstract interface, making your code more maintainable and easier to modify in the future.

`Code Reusability`: Aliases allow you to reuse complex type definitions in multiple places without duplicating code.

> typealias CompletionHandler<T> = (Result<T, Error>) -> Void

```
func fetchData(completion: CompletionHandler<Data>) {
    // Implementation
}
```
