# script to parse student list from CSV file and return an array of student objects
# The CSV file should have the following format:
# First row is the header, and each subsequent row represents a student with their name, student ID, and Azure AD object ID.
# Name,StudentID,ObjectID
# Example:
# John Doe,12345,abcdefg-1234-5678-90ab-cdef1234567
#

function ConvertFrom-StudentList {
    param (
        [string]$csvFilePath
    )

    # Check if the file exists
    if (-Not (Test-Path -Path $csvFilePath)) {
        Write-Error "The file '$csvFilePath' does not exist."
        return $null
    }

    try {
        # Import the CSV file and convert it to an array of student objects
        $students = Import-Csv -Path $csvFilePath | ForEach-Object {
            [PSCustomObject]@{
                Name  = $_.Name
                StudentID = $_.StudentID
                ObjectID    = $_.ObjectID
            }
        }
        return $students
    } catch {
        Write-Error "An error occurred while parsing the CSV file: $_"
        return $null
    }
}