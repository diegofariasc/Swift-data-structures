
/*
Implementation of the binary tree data structure
Final project for the course: Selected topics I (TIS-4011)
Autumn 2020
Diego Farias Castro Id. 159918
*/

// Definition of the nodes
fileprivate class TreeNode <T : Comparable> {


    ///////////////////////////////////////////////////////////
    // Attributes of the objects
    public var payload : T
    public var rightNode : TreeNode<T>? 
    public var leftNode : TreeNode<T>?

    ///////////////////////////////////////////////////////////
    // Methods

    // Constructor
    init( _ payload : T ) 
    {
        self.payload = payload
        self.rightNode = nil
        self.leftNode = nil
    } // End init

    // The method indicates if a node is a leaf node
    fileprivate func isLeaf() -> Bool
    {
        return (rightNode == nil) && (leftNode == nil)
    } // End isLeaf

} // End class



public class BinarySearchTree <T : Comparable>  
{
    ///////////////////////////////////////////////////////////
    // Attributes of the objects
    private var root : TreeNode<T>?
    private var length : Int
    public var count : Int 
    { 
        get 
        {
            return length
        } // End get
    } // End count

    init()
    {
        self.root = nil
        self.length = 0
    } // End constructor


    ///////////////////////////////////////////////////////////
    // Insertion methods

    // Recursive function to carry out the insertion of a TreeNode in the structure
    private func insert ( _ nodeToInsert : TreeNode<T>, _ searchNode : TreeNode<T> )
    {
        // Check if value to insert is lower or equal than the one in the current node 
        if ( nodeToInsert.payload <= searchNode.payload )
        {

            // If so, check if left node is free. If this is the case, insert
            if ( searchNode.leftNode == nil )
            {
                searchNode.leftNode = nodeToInsert
            } // End if
            else
            {
                // Otherwise, move to left subtree recursively
                insert ( nodeToInsert, searchNode.leftNode! )
            } // End else

        } // End if

        // The value to insert is larger than the one in the current node 
        else 
        {
            // Check if right node is free. If this is the case, insert
            if ( searchNode.rightNode == nil )
            {
                searchNode.rightNode = nodeToInsert
            } // End if
            else
            {
                // Otherwise, move to right subtree recursively
                insert ( nodeToInsert, searchNode.rightNode! )
            } // End else

        } // End else

    } // End insert


    // Auxiliary function (for the client) to carry out insertion 
    public func insert ( _ object : T ) 
    {

        let newNode = TreeNode<T>( object )

        // If tree is empty initialize root
        if ( root == nil )
        {
            root = newNode
        } // End if 

        // Otherwise search position to perform insertion and do so
        else
        {
            insert ( newNode, root! )
        } // End else

        length += 1

    } // End insert


    ///////////////////////////////////////////////////////////
    // Traversal methods
    
    // Recursive function to move across the tree and to add (orderly) its elements to a given array
    private func inorder ( _ searchNode : TreeNode<T>, _ array : inout Array<T> )
    {

        // Check if there's a left subtree. If so move recursively to it
        if ( searchNode.leftNode != nil )
        {
            inorder ( searchNode.leftNode!, &array )
        } // End if 

        // Add current node content
        array.append( searchNode.payload )

        // Check if there's a right subtree. If so move recursively to it
        if ( searchNode.rightNode != nil ) 
        {
            inorder ( searchNode.rightNode!, &array )
        } // End else

    } // End inorder


    // Auxiliary function (for the client) to carry out inorder traversal
    public func inorder() -> Array<T>
    {

        // Generate array where all elements will be stored
        var array = Array<T>()

        // If the root isn't nil, start navigating
        if ( root != nil ) 
        {
            inorder( root!, &array )
        } // End if

        return array

    } // End inorder


    // Recursive function to move across the tree searching for a value
    private func has( _ searchNode : TreeNode<T>, _ searchingValue : T ) -> Bool
    {

        // If the value has been found return true
        if ( searchNode.payload == searchingValue )
        {
            return true
        } // End if


        // Check if the searched value is lower or equal than the one in the current node 
        if ( searchingValue <= searchNode.payload )
        {

            // If so, check if left node nil. If so, value wasn't found
            if ( searchNode.leftNode == nil )
            {
                return false
            } // End if
            else
            {
                // Otherwise, move to left subtree recursively
                return false || has ( searchNode.leftNode!, searchingValue )
            } // End else

        } // End if

        // The searched value is larger than the one in the current node 
        else 
        {
            // Check if right node nil. If so, value wasn't found
            if ( searchNode.rightNode == nil )
            {
                return false
            } // End if
            else
            {
                // Otherwise, move to RIGHT subtree recursively
                return false || has ( searchNode.rightNode!, searchingValue )
            } // End else

        } // End else

    } // End has


    /* Auxiliary function (for the client) to move across the tree 
    searching for a value*/
    public func has( _ searchingValue : T ) -> Bool 
    {

        var wasFound = false
        
        // If the root isn't nil, start navigating
        if ( root != nil ) 
        {
            wasFound = has ( root!, searchingValue )
        } // End if

        return wasFound
        
    } // End has


    ///////////////////////////////////////////////////////////
    // Deletion methods

    /* The method allows to find the leftmost node from a subtree
    This allows to carry out deletion when node to delete has left and 
    right subtrees */
    private func getLeftMostNodeValue( _ searchNode : TreeNode<T> ) -> T
    {

        // The leftmost node has been found, return its value
        if ( searchNode.leftNode == nil )
        {
            return searchNode.payload
        } // End if 

        else
        {
            return getLeftMostNodeValue( searchNode.leftNode! )
        } // End else

    } // End getLeftMostNode


    // The method allows to recursively get a tree where a value has been deleted
    private func delete( _ currentNode : TreeNode<T>?, _ deletingValue : T ) -> TreeNode<T>?
    {

        let leftmostValue : T

        // First, check if the tree is empty
        if ( currentNode == nil )
        {
            return nil
        } // End 

        // Check if the searched value is lower than the one in currentNode
        if ( deletingValue < currentNode!.payload )
        {
            currentNode!.leftNode = delete ( currentNode!.leftNode, deletingValue )
        } // End if

        // Check if the searched value is larger than the one in currentNode
        else if ( deletingValue > currentNode!.payload )
        {
            currentNode!.rightNode = delete ( currentNode!.rightNode, deletingValue )
        } // End if

        else 
        {
            // Check deletion cases:

            // 1. Leaf node
            if ( currentNode!.isLeaf() )
            {
                return nil
            } // End if

            // 2. Deleting node has a right node only 
            else if ( currentNode!.leftNode == nil )
            {
                return currentNode!.rightNode
            } // End if

            // 3. Deleting node has a left node only 
            else if ( currentNode!.rightNode == nil )
            {
                return currentNode!.leftNode
            } // End if

            // 4. Deleting node has two children
            else
            {
                // Copy to the current node the leftmost value in right subtree
                leftmostValue = getLeftMostNodeValue( currentNode!.rightNode! )
                currentNode!.payload = leftmostValue

                // As the leftmost right subtree value has been copied 
                // it must be deleted. So proceed to it
                currentNode!.rightNode = delete ( currentNode!.rightNode, leftmostValue )

            } // End else

        } // End else

        return currentNode

    } // End delete


    // Auxiliary function (for the client) to carry out deletion
    public func delete ( _ deletingValue : T  )
    {
        root = delete( root, deletingValue )
    } // End delete

} // End class




