"MIT License
"
"Copyright (c) 2021 kruemelmann
"
"Permission is hereby granted, free of charge, to any person obtaining a copy
"of this software and associated documentation files (the "Software"), to deal
"in the Software without restriction, including without limitation the rights
"to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
"copies of the Software, and to permit persons to whom the Software is
"furnished to do so, subject to the following conditions:
"
"The above copyright notice and this permission notice shall be included in all
"copies or substantial portions of the Software.
"
"THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
"IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
"FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
"AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
"LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
"OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
"SOFTWARE.

function! Queery(comand)
    call inputrestore()
    ""TODO filter out specific files
    let l:cmd = "grep -rn '.' -e '". a:comand ."'"

    let l:results = systemlist(l:cmd)
    let l:name = 'Output'
    if bufwinnr(l:name) == -1
        " Open a new split
        execute 'split ' . l:name
    else
        " Focus the existing window
        execute bufwinnr(l:name) . 'wincmd w'
    endif
    " Clear out existing content
    normal! gg"_dG
    " Don't prompt to save the buffer
    set buftype=nofile
    " Insert the results.
    call append(0, l:results)
endfunction

function Selection()
    let regInfo = getreginfo('/"')

    let l:comand = ""
    if v:hlsearch == 1
        let l:comand = regInfo.regcontents[0]
    else
        let l:comand = input('Enter search pattern: ')
    endif
    call Queery(l:comand)
endfunction

nnoremap <leader>F :call Selection()<cr>

