Red [
    Title: "Algorithms test driver"
    Author:  "Nathan Douglas"
    License: "MIT - https://opensource.org/licenses/MIT"
]

do %functional.red
do %helpers.red

assert: function [
    "Raises an error if every value in 'conditions doesn't evaluate to true. Inclose variables in brackets to compose them"
    conditions [block!]
] [
    any [
        all conditions
        do make error! print rejoin [
            "assertion failed for: " mold/only conditions "," newline 
            "conditions: [" compose/only conditions "]"
        ]
    ]
]

testFilenameSuffix: copy "Test.red"
testFunctionNamePrefix: copy "test"

; test files are those that end with "Test.red"
testFiles: findFiles/matching %tests/ lambda [endsWith ? testFilenameSuffix]

; runs all functions that start with test in testFiles
; runs setUp and tearDown functions before each test function, if they exist
foreach testFile testFiles [

    testFileContents: context load testFile        
    testFileObject: testFileContents/tests
    wordsInTestFile: copy words-of testFileObject
    testFunctions: f_filter lambda [startsWith to-string ? testFunctionNamePrefix] wordsInTestFile

    ; actually call each test function; we don't care about the results
    foreach testFunction testFunctions [
        if in testFileObject 'setUp [testFileObject/setUp]
        testFileObject/:testFunction
        if in testFileObject 'tearDown [testFileObject/tearDown]
    ]
]

print "all tests pass"