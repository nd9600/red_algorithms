Red [
    Title: "Binary tree"
    Author:  "Nathan Douglas"
    License: "MIT - https://opensource.org/licenses/MIT"
    Description: {
    }
]


node: context [
    value: none
    parent: none
    leftChild: none
    rightChild: none

    inOrder: function [] [
        returning: copy []
        if not none? self/leftChild [append/only returning self/leftChild/inOrder]
        append/only returning self/value
        if not none? self/rightChild [append/only returning self/rightChild/inOrder]
        returning
    ]
]