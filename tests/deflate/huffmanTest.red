Red [
    Title: "Huffman tree tests"
]

do %deflate/huffman.red

tests: context [

    ; tests if a frequencies heap is created correctly
    testCreatingFreqsHeap: function [] [
        ht1: make huffmanTree [
            string: copy "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua"
        ]
        ht1/getFrequencies

        freqsHeap: ht1/createFreqsHeap

        assert [
            (freqsHeap/h) == reduce [
                make object! [
                    value: [1 ["01001100"]] parent: none leftChild: none rightChild: none
                ] make object! [
                    value: [1 ["01100010"]] parent: none leftChild: none rightChild: none
                ] make object! [
                    value: [1 ["01110001"]] parent: none leftChild: none rightChild: none
                ] make object! [
                    value: [2 ["00101100"]] parent: none leftChild: none rightChild: none
                ] make object! [
                    value: [2 ["01100111"]] parent: none leftChild: none rightChild: none
                ] make object! [
                    value: [3 ["01110000"]] parent: none leftChild: none rightChild: none
                ] make object! [
                    value: [4 ["01100011"]] parent: none leftChild: none rightChild: none
                ] make object! [
                    value: [5 ["01101100"]] parent: none leftChild: none rightChild: none
                ] make object! [
                    value: [5 ["01101110"]] parent: none leftChild: none rightChild: none
                ] make object! [
                    value: [6 ["01101101"]] parent: none leftChild: none rightChild: none
                ] make object! [
                    value: [6 ["01110010"]] parent: none leftChild: none rightChild: none
                ] make object! [
                    value: [6 ["01110011"]] parent: none leftChild: none rightChild: none
                ] make object! [
                    value: [6 ["01110101"]] parent: none leftChild: none rightChild: none
                ] make object! [
                    value: [7 ["01100001"]] parent: none leftChild: none rightChild: none
                ] make object! [
                    value: [8 ["01100100"]] parent: none leftChild: none rightChild: none
                ] make object! [
                    value: [9 ["01110100"]] parent: none leftChild: none rightChild: none
                ] make object! [
                    value: [10 ["01101111"]] parent: none leftChild: none rightChild: none
                ] make object! [
                    value: [11 ["01100101"]] parent: none leftChild: none rightChild: none
                ] make object! [
                    value: [11 ["01101001"]] parent: none leftChild: none rightChild: none
                ] make object! [
                    value: [18 ["00100000"]] parent: none leftChild: none rightChild: none
                ]
            ]
        ]
    ]

    ; tests if the huffman tree (juat the optimal binary tree of frequencies) is made correctly
    testCreatingTree: function [] [
        ht1: make huffmanTree [
            string: copy "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua"
        ]
        ht1/getFrequencies

        freqsHeap: ht1/createFreqsHeap
        tree: ht1/createTree

        probe tree

        ; the tree is too big to paste here, so we'll just compare the SHA256 hashes
        ; the root node has a value of 122
        assert [(checksum mold tree 'sha256) == #{CB0492F860A5B330F00FB5EBB25B6B5888B77B67EB01CA835062EB9425010273}]
    ]
]