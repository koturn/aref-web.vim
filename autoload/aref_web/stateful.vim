"
" Helper static functions, functions has the state
"

" If you have open-browser.vim, return v:true.
" otherwise return v:false.
function! aref_web#stateful#have_openbrowser_vim() abort " {{{
	try
		call openbrowser#load()
		return v:true
	catch /E117/
		return v:false
	endtry
endfunction " }}}

" Do nmap for filetype=aref_web buffer
function! aref_web#stateful#map_default_keys() abort " {{{
	nmap <buffer> O     <Plug>(aref_web_open_browser_current_url)
	nmap <buffer> <C-a> <Plug>(aref_web_show_next_page)
	nmap <buffer> <C-x> <Plug>(aref_web_show_prev_page)
endfunction " }}}

" If keys(g:aref_web_source) contains a:source_name, return true.
" otherwise return false.
function! aref_web#stateful#is_supported_source(source_name) abort " {{{
	let l:List = aref_web#vital_load#data_list()
	let l:supported_sources = keys(g:aref_web_source)
	return l:List.has(l:supported_sources, a:source_name)
endfunction " }}}

" If you have cui web browser, return true.
" otherwise return false.
function! aref_web#stateful#can_use_dump_cmd() abort " {{{
	return !empty(g:aref_web_dump_cmd)
endfunction " }}}

"Example: echo aref_web#stateful#get_target_url('stackage', ['Int', '->', 'Int'])
"  ==> 'https://www.stackage.org/(lts-5.15 or other version)/hoogle?q=Int+->+Int
function! aref_web#stateful#get_target_url(source_name, param_list) abort " {{{
	"Example: Aref stackage Int -> Int  ==>  l:request_param == 'Int+->+Int'
	"Example: Aref stackage ($$+-)      ==>  l:request_param == '($$%2B-)'
	" Avoid invalid url generating
	let l:encoded_param_list = map(a:param_list, 'substitute(v:val, "+", "%2B", "g")')
	let l:request_params     = join(l:encoded_param_list, '+')
	return printf(g:aref_web_source[a:source_name].url, l:request_params)
endfunction " }}}