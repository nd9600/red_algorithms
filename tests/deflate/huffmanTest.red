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

        ; the output is too big to paste here, so we'll just compare the SHA256 hashes
        assert [
            (checksum mold freqsHeap/h 'sha256) == #{E7E8CC1C34B05768582DB29EFFAD7DFA1C9C2A65E93837CA3FEE7F6D59B9F072}
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

        ; the tree is too big to paste here, so we'll just compare the SHA256 hashes
        ; the root node has a value of 122
        assert [(checksum mold tree 'sha256) == #{64614906760C3A5B40CDA2211500B55AE43BAED2614148E2A3DF176A25834692}]
    ]

    ; tests if the mapping from characters to prefix codes is made correctly
    ; this uses the same string as https://en.wikipedia.org/wiki/File:Huffman_coding_visualisation.svg
    testGettingPrefixCodes: function [] [
        ht1: make huffmanTree [
            string: copy "A_DEAD_DAD_CEDED_A_BAD_BABE_A_BEADED_ABACA_BED"
        ]
        ht1/getFrequencies

        freqsHeap: ht1/createFreqsHeap
        tree: ht1/createTree
        prefixCodes: ht1/createPrefixCodes

        print rejoin ["prefixCodes: " mold prefixCodes]

        assert [
            prefixCodes == reduce [#"D" "00" #"_" "01" #"A" "10" #"E" "110" #"C" "1110" #"B" "1111"]
        ]
    ]
]