Red [
    Title: "Heap tests"
]

do %heap.red

tests: context [

    testHeap: function [] [
        h: copy [1 2 3 4 5 6 7 8 9 10]
        hRandom: random copy h

        heap1: make heap []
        foreach e hRandom [
            heap1/insertH e
        ]
        heap1Final: copy heap1/h

        probe hRandom
        probe heap1/h

        hsorted: copy []
        while [not heap1/empty] [
            append hsorted heap1/pop
        ]
        probe hsorted
        probe h
        assert [
            hsorted == h
        ]
    ]
]