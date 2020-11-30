/*
Implementation of the stack data structure
Final project for the course: Selected topics I (TIS-4011)
Autumn 2020
Diego Farias Castro Id. 159918
Based on the course implementation from Gerardo Ayala San Martin
*/
import Foundation

public class Matrix {

    ///////////////////////////////////////////////////////////
    // Attributes of the objects
    private var totalRows: Int
    private var totalColumns: Int
    private var values: [Double]

    ///////////////////////////////////////////////////////////
    // Methods

    // Constructor
    init (_ totalRows: Int, _ totalColumns: Int)
    {
        self.totalRows = totalRows
        self.totalColumns = totalColumns
        values = Array<Double>(repeating: 0.0, count: totalRows * totalColumns)
    }// End constructor


    // Access method
    subscript ( row: Int, column: Int ) -> Double
    {
        get
        {
            return values[ (row * totalColumns) + column]
        }// End get

        set( newValue )
        {
            values[ (row * totalColumns) + column ] = newValue
        }// End set

    }// End subscript

    // The method provides a string representation of the matrix
    public func toString() -> String
    {
        var stringRepresentation = "["

        for i in 0 ..< totalRows {

            if ( i > 0 ) 
            {
                stringRepresentation += " "
            } // End if 

            stringRepresentation += "["
            
            for j in 0 ..< totalColumns
            {
                stringRepresentation += String(self[i,j])

                if (j < totalColumns - 1)
                {
                    stringRepresentation += ", "
                } // End if 

            } // End for

            stringRepresentation += "]"

            if ( i < totalRows - 1 ) {
                stringRepresentation += "\n"
            } // End if

        } // End for

        stringRepresentation += "]"
        return stringRepresentation

    } // End toString


    // The method allows to acquire the number of rows in the matrix
    public func getNumberOfRows() -> Int 
    {
        return totalRows
    } // End getNumberOfRows


    // The method allows to acquire the number of columns in the matrix
    public func getNumberOfColumns() -> Int 
    {
        return totalColumns
    } // End getNumberOfColumns


    private func hasSameDimensionsAs( _ matrixB : Matrix ) -> Bool {

        let rowsA = self.getNumberOfRows()
        let columnsA = self.getNumberOfColumns()
        let rowsB = matrixB.getNumberOfRows()
        let columnsB = matrixB.getNumberOfColumns()

        return ( rowsA == rowsB && columnsA == columnsB )

    } // End hasSameDimensionsAs


    // The method allows to sum two matrices of the same size
    public func addition( _ matrixB : Matrix ) -> Matrix? {

        var newMatrix : Matrix? = nil

        if ( !hasSameDimensionsAs( matrixB ) )
        {
            print("Matrix error: Matrix dimensions don't match")
        } // End if 
        else {

            newMatrix = Matrix( totalRows, totalColumns )

            for i in 0 ..< totalRows 
            {
                for j in 0 ..< totalColumns 
                {
                    newMatrix![i,j] = matrixA[i,j] + matrixB[i,j]
                } // End for

            } // End for
            
        } // End else

        return newMatrix

    } // End addition


    // The method allows to subtract two matrices of the same size
    public func substraction( _ matrixB : Matrix ) -> Matrix? {

        var newMatrix : Matrix? = nil

        if ( !hasSameDimensionsAs( matrixB ) )
        {
            print("Matrix error: Matrix dimensions don't match")
        } // End if 
        else {

            newMatrix = Matrix( totalRows, totalColumns )

            for i in 0 ..< totalRows 
            {
                for j in 0 ..< totalColumns 
                {
                    newMatrix![i,j] = matrixA[i,j] - matrixB[i,j]
                } // End for

            } // End for
            
        } // End else

        return newMatrix

    } // End substraction


    public func multiplication( _ matrixB : Matrix ) -> Matrix? 
    {

        var matrixProduct : Matrix?
        var dotProduct : Double

        // Check if dimensions are suitable. Ohterwise return nil and notify user
        if ( totalColumns != matrixB.getNumberOfRows() )
        {
            print("Matrix error: The number of columns in matrix A do not match with the number rows in column B")
            matrixProduct = nil

        } // End if 

        else
        {
            // Construct a result matrix
            matrixProduct = Matrix( totalRows, matrixB.getNumberOfColumns() )

            // Iterate over the resulting matrix
            for i in 0 ..< totalRows 
            {
                for j in 0 ..< matrixB.getNumberOfColumns() 
                {        

                    // Compute the dot product
                    dotProduct = 0.0

                    for k in 0 ..< totalColumns {
                        dotProduct += self[i,k] * matrixB[k,j]
                    } // End for

                    // Assign it to the resulting matrix at i,j
                    matrixProduct![i,j] = dotProduct
                
                } // End for
            
            } // End for

        } // End else

        return matrixProduct

    } // End multiplication


    // The method allows to subtract two matrices of the same size
    public func getTranspose() -> Matrix {

        let newMatrix = Matrix( totalColumns, totalRows )

        for i in 0 ..< totalRows 
        {
            for j in 0 ..< totalColumns 
            {
                newMatrix[j,i] = self[i,j]
            } // End for

        } // End for

        return newMatrix

    } // End substraction


    // The method indicates if the matrix has a square shape
    public func isSquare() -> Bool 
    {
        return totalRows == totalColumns
    } // End isSquare


    // The method indicates if the matrix is diagonal
    public func isDiagonal() -> Bool 
    {
        for i in 0 ..< totalRows 
        {
            for j in 0 ..< totalColumns 
            {
                if ( i != j && self[i,j] != 0 ){
                    return false
                } // End if 

            } // End for

        } // End for

        return true

    } // End isDiagonal


    // The method indicates if the matrix is the identity 
    public func isIdentity() -> Bool 
    {
        for i in 0 ..< totalRows 
        {
            for j in 0 ..< totalColumns 
            {
                if ( (i != j && self[i,j] != 0) || (i == j && self[i,j] != 1) )
                {
                    return false
                } // End if 

            } // End for

        } // End for

        return true

    } // End isIdentity


    // The method indicates if the matrix is the identity 
    public func isInvertible() -> Bool 
    {
        return ( isSquare() && getDeterminant() != 0 )
    } // End isInvertible



    // Auxiliary function for getting the determinant with no parameter
    public func getDeterminant () -> Double? {

        if ( isSquare() ) 
        {
            return getDeterminant(self)
        } // End if
        else 
        {
            print("Matrix error: Determinants can only be calculated out of a square matrix")
            return nil
        } // End else
    
    } // End  getDeterminant



    // Recursive method for getting the matrix determinant 
    private func getDeterminant( _ matrix : Matrix ) -> Double {

        var determinantValue : Double
        var reducedMatrix : Matrix
        var coeficient : Int
        var columnNumber : Int

        // Base case: 2x2 determinant
        if ( matrix.getNumberOfRows() == 2 && matrix.getNumberOfColumns() == 2 ) 
        {
            determinantValue = matrix[0,0] * matrix[1,1] - matrix[0,1] * matrix[1,0]
        } // End if 

        else {
            
            // Initialize coeficiente as positive, determinant as 0 and the column n=0
            coeficient = 1
            determinantValue = 0
            columnNumber = 0

            while ( columnNumber < matrix.getNumberOfColumns() )
            {

                // Extract a sub-matrix without the row 0 and the n-th column
                reducedMatrix = matrix.getSubmatrixWithout(row: 0, column: columnNumber)

                // Recursive call
                determinantValue += Double(coeficient) * matrix[0,columnNumber] * getDeterminant( reducedMatrix )
                
                // Change sign 
                coeficient = -coeficient

                columnNumber += 1 

            } // End for
            
        } // End else

        return determinantValue

    } // End getDeterminant


    // The method returns a sub-matrix removing the given row and column
    private func getSubmatrixWithout( row : Int, column: Int ) -> Matrix {

        let reducedMatrix = Matrix( totalRows - 1, totalColumns - 1 )
        var reducionInRows = 0
        var reducionInColumns = 0

        for i in 0 ..< totalRows - 1
        {

            // Once the row to hide is reached jump to next
            // iteration and start assiging to i - 1 instead of i 
            if ( i == row ) 
            {
                reducionInRows = 1
            } // End if 

            for j in 0 ..< totalColumns - 1
            {

                // Once the row to hide is reached jump to next
                // iteration and start assiging to j - 1 instead of j
                if ( j == column ) 
                {
                    reducionInColumns = 1
                } // End if 

                reducedMatrix[i,j] = self[i + reducionInRows ,j + reducionInColumns]

            } // End for

            reducionInColumns = 0

        } // End for

        return reducedMatrix

    } // End getSubmatrixWithout


    // The method allows to get the cofactor matrix of the current matrix
    private func getCofactorMatrix() -> Matrix? {

        let cofactorMatrix : Matrix?
        var subMatrix : Matrix
        var power : Double
        var determinant : Double
        var cofactor : Double

        // Check if the matrix is square. Otherwise cofactor matrix cannot be get
        if ( !isSquare() ) 
        {

            print("Matrix error: Cannot obtain cofactor matrix out of a non-square matrix")
            cofactorMatrix = nil

        } // End if 

        else 
        {

            // Create the cofactor empty matrix
            cofactorMatrix = Matrix( totalRows, totalRows )

            for i in 0 ..< totalRows
            {
            
                for j in 0 ..< totalColumns 
                {

                    // Get a submatrix removing row i and column j
                    subMatrix = getSubmatrixWithout( row : i, column : j )

                    // Power 1 to the i + j
                    power = pow( -1.0 , Double(i + j) )

                    // Get the determinant of the submatrix
                    determinant = subMatrix.getDeterminant()!

                    // Calculate and assing the cofactor value
                    cofactor = power * determinant
                    cofactorMatrix![i,j] = cofactor

                } // End for

            } // End for

        } // End else

    return cofactorMatrix

    } // End getCofactorMatrix


    // The method uses the cofactor matrix of self to obtain the adjoint 
    public func getAdjoint() -> Matrix? 
    {

        let adjointMatrix : Matrix?

        // Check if the matrix is square. Otherwise adjoint matrix cannot be get
        if ( !isSquare() ) 
        {

            print("Matrix error: Cannot obtain adjoint of a non-square matrix")
            adjointMatrix = nil

        } // End if 

        else {
            adjointMatrix = getCofactorMatrix()!.getTranspose()
        } // End else

        return adjointMatrix

    } // End getAdjoint


    public func getInverse() -> Matrix? 
    {

        let inverseMatrix : Matrix?
        var scalar : Double

        // Check if the matrix is invertible. Otherwise inverse matrix cannot be get
        if ( !isInvertible() ) 
        {

            print("Matrix error: Matrix is not invertible")
            inverseMatrix = nil

        } // End if 

        else 
        {
            // Get the result of 1 / det(A)
            scalar = 1.0 / getDeterminant()!

            // Initialize inverse matrix with the adjoint
            inverseMatrix = getAdjoint()

            // Multiply the adjoint matrix by the scalar
            for i in 0 ..< totalRows
            {
            
                for j in 0 ..< totalColumns 
                {
                    inverseMatrix![i,j] *= scalar

                } // End for

            } // End for

        } // End else

        return inverseMatrix

    } // End getInverse

} // End class