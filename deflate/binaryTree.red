Red [
    Title: "Binary tree"
    Author:  "Nathan Douglas"
    License: "MIT - https://opensource.org/licenses/MIT"
    Description: {
        A binary tree implementation, with inbuilt in-order traversals, and links to parent nodes, so it's easy to recurse from a leaf node to the root node
    }
]


node: context [
    value: none
    parent: none
    leftChild: none
    rightChild: none

    ; does an in-order traversal of the tree, returning the node applied to some function
    ; you'll probably need to flatten the result
    inOrder: function [
        inOrderFunction [any-function!]
    ] [
        ; we have to remember to pass the inOrderFunction along too
        returning: copy []
        if not none? self/leftChild [append/only returning (self/leftChild/inOrder :inOrderFunction)]
        inOrderFunction self returning
        if not none? self/rightChild [append/only returning (self/rightChild/inOrder :inOrderFunction)]
        returning
    ]
]