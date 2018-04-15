Red [
    Title: "Heap tests"
]

do %deflate/heap.red

tests: context [

; tests if a heap is created and popped from correctly, when only inserting 1 element
    testHeapsortWith1Element: function [] [
        hRandom: copy [4]

        heap1: make heap []
        foreach e hRandom [
            heap1/insertH e
        ]
        heap1Final: copy heap1/h

        heapsorted: copy []
        while [not heap1/empty] [
            append heapsorted heap1/pop
        ]

        assert [
            heapsorted == hRandom
        ]
    ]

    ; tests if a heap is created and popped from correctly, when only inserting 2 elements
    testHeapsortWith1Element: function [] [
        hRandom: copy [10 4]

        heap1: make heap []
        foreach e hRandom [
            heap1/insertH e
        ]
        heap1Final: copy heap1/h

        heapsorted: copy []
        while [not heap1/empty] [
            append heapsorted heap1/pop
        ]

        assert [
            heapsorted == [4 10]
        ]
    ]

    ; tests if a heap is created and popped from correctly, by doing a heapsort on a random array
    testNormalHeapsort: function [] [
        h: copy [1 2 3 4 5 6 7 8 9 10]
        hRandom: random copy h

        heap1: make heap []
        foreach e hRandom [
            heap1/insertH e
        ]
        heap1Final: copy heap1/h

        heapsorted: copy []
        while [not heap1/empty] [
            append heapsorted heap1/pop
        ]

        assert [
            heapsorted == h
        ]
    ]

    ; tests if a heap is created and popped from correctly, with a big heap
    -testBigHeapsort: function [] [
        hRandom: copy []
        loop to-integer 1e4 [append hRandom (1 + to-integer random 1e4)]

        heap1: make heap []
        foreach e hRandom [
            heap1/insertH e
        ]
        heap1Final: copy heap1/h

        heapsorted: copy []
        while [not heap1/empty] [
            append heapsorted heap1/pop
        ]

        assert [
            heapsorted == sort copy hRandom
        ]
    ]
]