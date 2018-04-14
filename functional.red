Red [
    Title: "Functional programming functions"
]

;apply: function [f x][f x] ;monadic argument only
;apply: function [f args][do head insert args 'f]
;apply: function [f args][do append copy [f] args]
;apply: function [f args][do compose [f (args)] ]

lambda: function [
    "makes lambda functions - https://gist.github.com/draegtun/11b0258377a3b49bfd9dc91c3a1c8c3d"
    block [block!] "the function to make"
] [
    flatten: function[b][
        flattened: copy []
        while [not tail? b] [
            element: first b
            either block? element [
                append flattened flatten element
            ] [
                append flattened element
            ]
            b: next b
        ]
        flattened
    ]

    spec: make block! 0
    flattenedBlock: flatten block

    parse flattenedBlock [
        any [
            set word word! (
                if (strict-equal? first to-string word #"?") [
                    append spec word
                    ]
                )
            | skip
        ]
    ]

    spec: unique sort spec
    
    if all [
        (length? spec) > 1
        found? find spec '?
    ] [ 
        do make error! {cannot match ? with ?name placeholders}
    ]

    function spec block
]

f_map: function [
    "The functional map"
    f  [any-function!] "the function to use" 
    block [block!] "the block to reduce"
] [
    result: copy []
    while [not tail? block] [
        replacement: f first block
        append/only result replacement
        block: next block
    ]   
    result
]

f_fold: function [
    "The functional left fold"
    f  [any-function!] "the function to use" 
    init [any-type!] "the initial value"
    block [block!] "the block to fold"
] [
    result: init
    while [not tail? block] [
        result: f result first block
        block: next block
    ]
    result
]

f_filter: function [
    "The functional filter"
    condition [function!] "the condition to check, as a lambda function" 
    block [block!] "the block to fold"
] [
    result: copy []
    while [not tail? block] [
        if (condition first block) [
            append result first block
        ]
        block: next block
    ]
    result
]
