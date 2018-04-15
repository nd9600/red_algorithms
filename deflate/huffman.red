Red [
    Title: "Huffman tree encoding"
    Author:  "Nathan Douglas"
    License: "MIT - https://opensource.org/licenses/MIT"
    Description: {
    }
]

do %../functional.red
do %heap.red
do %binaryTree.red


; a huffman node is just a normal binary tree node, where the value is [frequency (symbol/prefix code)]

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
        ; gets the binary version of all the data passed in, groups that into bytes, sorts them, and does a run-length encoding on the sorted bytes to get the frequency of bytes
        inBinary: enbase/base string 2
        inBytes: parse inBinary [collect [
            any [keep 8 skip] [end | collect to end]  
        ]]
        sortedBytes: sort copy inBytes
        rleSortedBytes: rle sortedBytes
        self/frequencies: sort copy rleSortedBytes
    ]

    createFreqsHeap: function [] [
        freqs: copy self/frequencies
        self/freqsHeap: make heap [
            compare: function [
                a [any-type!]
                b [any-type!]
            ] [
                case [
                    a/value/1 < b/value/1 [return -1]
                    b/value/1 < a/value/1 [return 1]
                    true [return 0]
                ]
            ]
        ]

        ; we add a leaf node containing each frequency, to the heap
        foreach freqPair freqs [
            freqNode: make node compose/deep [
                value: [(freqPair/1) [(freqPair/2)]]
            ]
            self/freqsHeap/insertH freqNode
        ]
        self/freqsHeap
    ]

    createTree: function [] [
        while [(length? self/freqsHeap/h) > 1] [
            nodeWithLowestProbability: self/freqsHeap/pop
            nodeWithSecondLowestProbability: self/freqsHeap/pop

            ;print rejoin ["nodeWithLowestProbability: " mold nodeWithLowestProbability]
            ;print rejoin ["nodeWithLowestProbability: " mold nodeWithSecondLowestProbability]

            newInternalNode: make node compose/deep/only [
                value: [(nodeWithLowestProbability/value/1 + nodeWithSecondLowestProbability/value/1) (append copy nodeWithLowestProbability/value/2 nodeWithSecondLowestProbability/value/2 )]
                leftChild: (nodeWithLowestProbability)
                rightChild: (nodeWithSecondLowestProbability)
            ]

            ;print rejoin ["newInternalNode: " mold newInternalNode]

            self/freqsHeap/insertH newInternalNode
        ]

        ; at the end of the process, the last node in the priority queue is the Huffman tree's root node
        self/tree: self/freqsHeap/minH
    ]
]