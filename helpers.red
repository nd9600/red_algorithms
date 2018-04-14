Red [
    Title: "Helper functions"
    Author:  "Nathan Douglas"
    License: "MIT - https://opensource.org/licenses/MIT"
]

startsWith: function [
    "returns whether 'series starts with 'value"
    series [series!]
    value [any-type!]
] [
    match: find series value
    either all [not none? match head? match] [true] [false]
]

endsWith: function [
    "returns whether 'series ends with 'value"
    series [series!]
    value [any-type!]
] [
    match: find/tail series value
    either all [not none? match tail? match] [true] [false]
]

findFiles: function [
    "find files in a directory (including sub-directories), optionally matching against a condition"
    dir [file!]
    /matching "only find files that match a condition"
    condition [any-function!] "the condition files must match"
] [
    fileList: copy []
    files: read normalize-dir dir

    ; get files in this directory
    foreach file files [

        ; so we don't add directories by accident
        if not find file "/" [
            either matching [
                if condition file [append fileList dir/:file]
            ] [
                append fileList dir/:file
            ]
        ]
    ]

    ; get files in sub-directories
    foreach file files [
        if find file "/" [

            ; we have to pass the refinement into the recursive calls too
            either matching [
                append fileList findFiles/matching dir/:file :condition
            ] [
                append fileList findFiles dir/:file
            ]
        ]
    ]
    fileList
]
