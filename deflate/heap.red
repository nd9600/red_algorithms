Red [
    Title:   "Binary min-heap implementation, as a block!"
    Author:  "Nathan Douglas"
    License: "MIT - https://opensource.org/licenses/MIT"
    Description: {Every node in a heap has the heap property. This is a min-heap, so:         
        If P is a parent of C, then P's key is less than or equal to C's.

                            1
                        4       11
                       5 20   13  15
                           25       21

        This is a binary heap, so the heap is a binary tree - a parent node can have a maximum of 2 children
        The root node always has the element with the lowest key
        The default implementation works with anything than can be compared with < - override the 'compare function to use something else

        First element contains the root
        Next two elements contains its children
        Next four elements contains the children of those two nodes, etc.
        -> children of node at position n are at 2n and 2n + 1

         1    2    3    4    5    6    7
        [a    b    c    d    e    f    g]
         |    |    |    |    |    |    |
          ---------     |    |    |    |
              |    |    |    |    |    |
               --------------     |    |
                   |              |    |
                    -------------------
        }
]

heap: context [

    ; the things stored in the heap - you can store whatever you want, as long as you override the 'compare function below
    h: copy []

    ; the comparison function used when inserting into the heap and finding the minimum child of a node
    ; -1 if a < b, 1 if b > a, 0 otherwise
    compare: function [
        a [any-type!]
        b [any-type!]
    ] [
        case [
            a < b [return -1]
            b < a [return 1]
            true [return 0]
        ]
    ]

    empty: function [] [0 == length? h]

    ; returns the root node's element without removing it
    minH: function [] [h/1]

    swapH: function [
        aIndex [integer!]
        bIndex [integer!]
    ] [
        swap (at h aIndex) (at h bIndex)
    ]

    ; finds the minimum child of a node
    ; returns the right child if the two children have the same keys
    findMinChild: function [
        leftChildIndex [integer!]
        rightChildIndex [integer!]
    ] [
        if (compare h/:leftChildIndex h/:rightChildIndex) < 0 [return leftChildIndex]
        rightChildIndex
    ]

    ; inserts an element into the heap
    ; may need to reimpose the heap property
    insertH: function [
        e [any-type!]
    ] [
        append h e

        ; 7 / 2 and 6 / 2 both == 3
        indexOfCurrentNode: length? h
        indexOfParent: indexOfCurrentNode / 2

        ; we don't need to reimpose the heap property if the heap only has 1 element in it
        if indexOfCurrentNode == 1 [exit]

        comment [
        print rejoin [newline "indexOfParent: " indexOfParent]
        print rejoin ["indexOfCurrentNode: " indexOfCurrentNode]
        print rejoin ["h/:indexOfParent: " h/:indexOfParent]
        print rejoin ["h/:indexOfCurrentNode: " h/:indexOfCurrentNode]
        ]

        ; while we're not at the root node, and the parent node is > the current node, swap them
        ; (the root node's parent has an index of 0)
        while [ 
            all [
                indexOfParent <> 0
                not none? h/:indexOfParent
                (compare h/:indexOfParent h/:indexOfCurrentNode) > 0
            ]
        ] [

            swapH indexOfCurrentNode indexOfParent
            indexOfCurrentNode: indexOfParent
            indexOfParent: indexOfCurrentNode / 2

            comment [
            print rejoin [newline "indexOfParent: " indexOfParent]
            print rejoin ["indexOfCurrentNode: " indexOfCurrentNode]
            print rejoin ["h/:indexOfParent: " h/:indexOfParent]
            print rejoin ["h/:indexOfCurrentNode: " h/:indexOfCurrentNode]
            ]
        ]
    ]

    ; pops the root node from the heap
    ; may need to reimpose the heap property
    pop: function [] [
        minElement: minH

        ; moves the biggest element to the root, then reimposes the heap property
        swapH 1 (length? h)
        remove back tail h

        heapSize: length? h

        indexOfCurrentNode: 1
        indexOfLeftChild: 2 * indexOfCurrentNode
        indexOfRightChild: (2 * indexOfCurrentNode) + 1

        print minElement
        print toString h
        print rejoin ["heapSize: " heapSize]
        print rejoin ["indexOfCurrentNode: " indexOfCurrentNode]
        print rejoin ["indexOfLeftChild: " indexOfLeftChild]
        print rejoin ["indexOfRightChild: " indexOfRightChild]
        print rejoin ["h/:indexOfCurrentNode: " h/:indexOfCurrentNode]
        print rejoin ["h/:indexOfLeftChild: " h/:indexOfLeftChild]
        print rejoin ["h/:indexOfRightChild: " h/:indexOfRightChild]

        ; while a minimum child node exists, and it's less than the current node, swap them
        while [ 
            all [
                indexOfLeftChild < heapSize
                not none? h/:indexOfLeftChild
                (compare h/(findMinChild indexOfLeftChild indexOfRightChild) h/:indexOfCurrentNode) < 0
            ] 
        ] [

            indexOfMinChild: findMinChild indexOfLeftChild indexOfRightChild
            swapH indexOfCurrentNode indexOfMinChild

            indexOfCurrentNode: indexOfMinChild
            indexOfLeftChild: 2 * indexOfCurrentNode
            indexOfRightChild: (2 * indexOfCurrentNode) + 1

            print toString [newline h]
            print rejoin ["indexOfCurrentNode: " indexOfCurrentNode]
            print rejoin ["indexOfLeftChild: " indexOfLeftChild]
            print rejoin ["indexOfRightChild: " indexOfRightChild]
            print rejoin ["h/:indexOfCurrentNode: " h/:indexOfCurrentNode]
            print rejoin ["h/:indexOfLeftChild: " h/:indexOfLeftChild]
            print rejoin ["h/:indexOfRightChild: " h/:indexOfRightChild]
        ]
        minElement
    ]

    toString: function [] [
        rejoin copy ["[" form reduce :h "]"]
    ]
]