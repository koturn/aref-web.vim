# aref-web.vim

aref-web.vim can open web dictionaries on the vim async.

![aref-web-vim_preview](./aref-web-vim_preview.gif)

## Example

- 1. Add this config to your .vimrc

```vim
let g:aref_web_source = {
\  'stackage' : {
\    'url' : 'https://www.stackage.org/lts-5.15/hoogle?q=%s'
\  }
\}
```

- 2. Execute command

```vim
:Aref stackage Int -> Int
```

- 3. https://www.stackage.org/lts-5.15/hoogle?q=Int+->+Int will be open in buffer async

## Requirements

* Vim options
  - +job

* Commands
  - curl
  - cui browse
    - w3m or
    - elinks or
    - links


## TODO

- Use existing aref_web type buffer
- Redo search cursor word on enter key pressed


## I Wish !!

- Pull request for English document
- (and other PRs)


## Thanks

This plugin respected [ref.vim](https://github.com/thinca/vim-ref/)'s webdict.