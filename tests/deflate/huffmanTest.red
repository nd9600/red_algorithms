Red [
    Title: "Huffman tree tests"
]

do %deflate/huffman.red

tests: context [

; tests if a heap is created and popped from correctly, when only inserting 1 element
    testHeapsortWith1Element: function [] [
        hRandom: copy [4]

        ht1: make huffmanTree [
            string: copy "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua"
        ]
        ht1/getFrequencies

        ht1/createTree
        freqsHeap: ht1/freqsHeap

        assert [
            freqsHeap/h == [[1 "01001100"] [1 "01100010"] [1 "01110001"] [2 "00101100"] [2 "01100111"] [3 "01110000"] [4 "01100011"] [5 "01101100"] [5 "01101110"] [6 "01101101"] [6 "01110010"] [6 "01110011"] [6 "01110101"] [7 "01100001"] [8 "01100100"] [9 "01110100"] [10 "01101111"] [11 "01100101"] [11 "01101001"] [18 "00100000"]]
        ]
        probe freqsHeap/h
    ]
]