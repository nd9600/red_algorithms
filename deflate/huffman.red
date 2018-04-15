Red [
    Title: "Huffman tree encoding"
    Author:  "Nathan Douglas"
    License: "MIT - https://opensource.org/licenses/MIT"
    Description: {
    }
]

do %../functional.red
do %heap.red

huffmanTree: context [
    string: copy {Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.}

    frequencies: copy []
    freqsHeap: copy []
    tree: copy []

    ; packs consecutive duplicates of list elements into sublists
    pack: function [series [series!]] [
        packed: copy []
        previous: none
        foreach element series [
            either previous == element [
                append last packed element
            ] [
                append/only packed reduce [element]
            ]
            previous: element 
        ]
        packed
    ]

    ; does run-length encoding of a series!
    rle: function [series [series!]] [
        f_map lambda [reduce [length? ? first ?]] pack series
    ]

    ; gets the (sorted) frequencies of all characters in a string
    getFrequencies: function [] [
        inBinary: enbase/base string 2
        groupedBinary: parse inBinary [collect [
            any [keep 8 skip] [end | collect to end]  
        ]]
        sortedGroups: sort copy groupedBinary
        rleSortedGroups: rle sortedGroups
        self/frequencies: sort copy rleSortedGroups
    ]

    createTree: function [] [
        freqs: copy self/frequencies
        self/freqsHeap: make heap [
            compare: function [
                a [any-type!]
                b [any-type!]
            ] [
                case [
                    a/1 < b/1 [return -1]
                    b/1 < a/1 [return 1]
                    true [return 0]
                ]
            ]
        ]
        foreach freq freqs [
            self/freqsHeap/insertH freq
        ]
    ]
]