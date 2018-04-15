Red [
    Title: "Huffman tree encoding"
    Author:  "Nathan Douglas"
    License: "MIT - https://opensource.org/licenses/MIT"
    Description: {
    }
]

do %functional.red

context [
    string: copy {Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.}

    frequencies: copy []

    pack: function [b] [
        packed: copy []
        previous: none
        foreach element b [
            either previous == element [
                append last packed element
            ] [
                append/only packed reduce [element]
            ]
            previous: element 
        ]
        packed
    ]

    rle: function [b] [
        f_map lambda [reduce [length? ? first ?]] pack b
    ]

    getFrequencies: func [] [
        inBinary: enbase/base string 2
        groupedBinary: parse inBinary [ collect [any [keep 8 skip] [end | collect to end]  ]
        sortedGroups: sort copy groupedBinary
        rleSortedGroups: rle sortedGroups
        frequencies: sort copy rleSortedGroups
    ]
]