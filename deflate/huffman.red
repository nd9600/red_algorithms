Red [
    Title: "Huffman tree encoding"
    Author:  "Nathan Douglas"
    License: "MIT - https://opensource.org/licenses/MIT"
    Description: {
    }
]

do %../functional.red
do %../helpers.red
do %heap.red
do %binaryTree.red


; a huffman node is just a normal binary tree node with a prefix property, either "0" or "1"
huffmanNode: make node [
    prefix: copy ""
]

huffmanTree: context [
    string: copy {Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.}

    frequencies: copy []
    freqsHeap: copy []
    tree: copy []
    prefixCodes: copy []

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
        ;inBinary: enbase/base string 2
        ;inBytes: parse inBinary [collect [
        ;    any [keep 8 skip] [end | collect to end]  
        ;]]
        sortedBytes: sort copy string
        rleSortedBytes: rle sortedBytes
        self/frequencies: sort copy rleSortedBytes
    ]

    createFreqsHeap: function [] [
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
        foreach freqPair self/frequencies [
            freqNode: make huffmanNode [
                value: reduce freqPair
            ]
            self/freqsHeap/insertH freqNode
        ]
        self/freqsHeap
    ]

    createTree: function [] [
        ; while there's more than 1 node in the queue, pop the two lowest probability nodes, make a new internal node with them as children, and add it back into the queue
        ; the two children are given prefix codes here - left child "0", right "1"
        while [(length? self/freqsHeap/h) > 1] [
            nodeWithLowestProbability: self/freqsHeap/pop
            nodeWithSecondLowestProbability: self/freqsHeap/pop

            ; lowest probability node is the left child
            nodeWithLowestProbability/prefix: copy "0"
            nodeWithSecondLowestProbability/prefix: copy "1"

            ;print rejoin ["nodeWithLowestProbability: " mold nodeWithLowestProbability]
            ;print rejoin ["nodeWithLowestProbability: " mold nodeWithSecondLowestProbability]

            newInternalNode: make huffmanNode compose/deep/only [
                value: [(nodeWithLowestProbability/value/1 + nodeWithSecondLowestProbability/value/1)]
                leftChild: (nodeWithLowestProbability)
                rightChild: (nodeWithSecondLowestProbability)
            ]

            nodeWithLowestProbability/parent: newInternalNode
            nodeWithSecondLowestProbability/parent: newInternalNode

            ;print rejoin ["newInternalNode: " mold newInternalNode]

            self/freqsHeap/insertH newInternalNode
        ]

        ; at the end of the process, the last node in the priority queue is the Huffman tree's root node
        self/tree: self/freqsHeap/minH
    ]

    createPrefixCodes: function [] [
        ; the easiest way to create a prefix code is to go to a leaf node, then recurse until you reach the root, reading the prefix code along the branches
        inOrderFunction: function [n returning] [
            if (length? n/value) > 1 [
                append/only returning n
            ]
        ]
        leafNodes: flatten self/tree/inOrder :inOrderFunction

        prefixCodes: copy []
        foreach leafNode leafNodes [
            cursor: leafNode
            prefixCode: copy reduce [leafNode/value/2 copy ""]
            while [not none? cursor/parent] [
                insert head prefixCode/2 cursor/prefix
                cursor: cursor/parent
            ]
            append prefixCodes prefixCode
        ]

        prefixCodes
    ]
]