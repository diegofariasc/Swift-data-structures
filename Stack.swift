/*
Implementation of the stack data structure
Final project for the course: Selected topics I (TIS-4011)
Autumn 2020
Diego Farias Castro Id. 159918
*/

public class Stack {

    ///////////////////////////////////////////////////////////
    // Attributes of the objects

    private var head : StackNode?
    private var length : Int
    public var count : Int 
    { 
        get 
        {
            return length
        } // End get
    } // End count
    public var isEmpty : Bool 
    {
        get 
        {
            return length == 0
        } // End get
    } // End isEmpty


    ///////////////////////////////////////////////////////////
    // Methods 

    // Constructor
    init() {
        head = nil
        length = 0
    } // End init

    
    // Push method
    public func push ( _ object : Any ) {
        
        // Create new node
        let newNode = StackNode( object )

        // Check if stack is empty 
        if ( isEmpty ){
            head = newNode
        } // End if
        else {
            newNode.next = head
            head = newNode
        } // End else

        length += 1

    } // End push


    // Peek method
    public func peek() -> Any? {
        
        if ( isEmpty ) {
            return nil
        } // End if
        else {
            return head!.payload
        } // End else

    } // End peek

    // Pop method 
    public func pop() -> Any? {

        // Store value to pop out
        var poppedValue : Any? = nil

        // Move pointers if not empty
        if ( !isEmpty ) {
            poppedValue = head!.payload
            head = head?.next
            length -= 1
        } // End else
        
        return poppedValue

    } // End pop



} // End class


// Definition of the nodes
fileprivate class StackNode {


    ///////////////////////////////////////////////////////////
    // Attributes of the objects
    public var payload : Any
    public var next : StackNode? 

    ///////////////////////////////////////////////////////////
    // Methods

    // Constructor
    init( _ payload : Any ) {
        self.payload = payload
        self.next = nil
    } // End init

} // End struct