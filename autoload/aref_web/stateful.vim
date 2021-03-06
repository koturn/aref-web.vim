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
	let l:List = aref_web#vital_load#get('Data.List')
	let l:supported_sources = keys(g:aref_web_source)
	return l:List.has(l:supported_sources, a:source_name)
endfunction " }}}

" If you have some CLI web browser, return true.
" otherwise return false.
function! aref_web#stateful#can_use_dump_cmd() abort " {{{
	return !empty(g:aref_web_dump_cmd)
endfunction " }}}

" Create special url for source_name with param_list
function! aref_web#stateful#get_target_url(source_name, param_list) abort " {{{
	let l:HTTP          = aref_web#vital_load#get('Web.HTTP')
	let l:params        = map(a:param_list, 'l:HTTP.encodeURI(v:val)')
	let l:request_query = join(l:params, '+')
	return printf(g:aref_web_source[a:source_name].url, l:request_query)
endfunction " }}}
