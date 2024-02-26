enum AreaError:Error {
    case ValueError
}


// Area using classes

protocol Shape {
    func area (a: Float, b: Float) throws -> Float;
}

class Rectangle: Shape {
    func area(a: Float, b: Float) -> Float {
        return a * b;
    }
}

class Square: Shape {
    func area(a: Float, b: Float) throws -> Float {
        if (a == b) {
            return a * a;
        } else {
            print("Square should have equal sides");
            throw AreaError.ValueError;
        }
    }
}

class Triangle: Shape {
    func area(a: Float, b: Float) -> Float {
        return (a * b) / 2;
    }
    
}

// Can use polymorphism with classes. Also, assigning to var shape variable is by pointer
var shape: Shape = Rectangle();
print("Area of Rectangle using a class: \(try shape.area(a: 2.0, b: 3.0))");

shape = Square();
print("Area of Square using a class: \(try shape.area(a: 2.0, b: 2.0))");

shape = Triangle();
print("Area of Triangle using a class: \(try shape.area(a: 2.0, b: 2.0))");

print()

// Area using structs

struct RectangleArea {
    func area(a: Float, b: Float) -> Float {
        return a * b;
    }
}

struct SquareArea {
    func area(a: Float, b: Float) throws -> Float {
        if (a == b) {
            return a * a;
        } else {
            print("Square should have equal sides");
            throw AreaError.ValueError;
        }
    }
}

struct TriangleArea {
    func area(a: Float, b: Float) -> Float {
        return (a * b) / 2;
    }
    
}

// Cannot use polymorphism with structs
var rectangle_shape_as_a_struct = RectangleArea();
print("Area of Rectangle using a struct: \(rectangle_shape_as_a_struct.area(a: 2.0, b: 3.0))");

var square_shape_as_a_struct = SquareArea();
print("Area of Square using a struct: \(try square_shape_as_a_struct.area(a: 2.0, b: 2.0))");

var triangle_shape_as_a_struct = TriangleArea();
print("Area of Triangle using a struct: \(triangle_shape_as_a_struct.area(a: 2.0, b: 2.0))");

print()

// Another way is to use struct with extensions. This allows you to extend your code without modifying the existing AreaCalculator struct

struct AreaCalculator {
    func rectangleArea(a: Float, b: Float) -> Float {
        return a * b;
    }
}

extension AreaCalculator {
    func squareArea (a: Float, b: Float) throws -> Float {
        if (a == b) {
            return a * a;
        } else {
            print("Square should have equal sides");
            throw AreaError.ValueError;
        }
    }
    func triangleArea(a: Float, b: Float) -> Float {
        return (a * b) / 2;
    }
}

var areaCalculator = AreaCalculator();
print("Area of a Rectangle with struct: \(areaCalculator.rectangleArea(a: 2.0, b: 3.0))");
print("Area of a Square with extension to AreaCalculator struct: \(try areaCalculator.squareArea(a: 2.0, b: 2.0))");
print("Area of a Triangle with extension to AreaCalculator struct: \(areaCalculator.triangleArea(a: 2.0, b: 2.0))");

