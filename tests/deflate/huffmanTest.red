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
            (checksum mold freqsHeap/h 'sha256) == #{8449B93B56E322F7B7191665E09E8B69531B685B74337CC8E1ED9707219B3018}
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
        assert [(checksum mold tree 'sha256) == #{0D147707DBCA154E4A36A12A846C0099BB2640F6D325E3AABEE6C8A69B656B93}]
    ]

    ; tests if the mapping from characters to prefix codes is made correctly
    testGettingPrefixCodes: function [] [
        ht1: make huffmanTree [
            string: copy "A_DEAD_DAD_CEDED_A_BAD_BABE_A_BEADED_ABACA_BED"
        ]
        ht1/getFrequencies

        freqsHeap: ht1/createFreqsHeap
        tree: ht1/createTree
        prefixCodes: ht1/createPrefixCodes

        probe prefixCodes
    ]
]