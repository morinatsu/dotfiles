let s:save_cpo = &cpo
set cpo&vim

let s:template = { 'name': '', 'attr': {}, 'child': [] }

function! s:nr2byte(nr)
  if a:nr < 0x80
    return nr2char(a:nr)
  elseif a:nr < 0x800
    return nr2char(a:nr/64+192).nr2char(a:nr%64+128)
  else
    return nr2char(a:nr/4096%16+224).nr2char(a:nr/64%64+128).nr2char(a:nr%64+128)
  endif
endfunction

function! s:nr2enc_char(charcode)
  if &encoding == 'utf-8'
    return nr2char(a:charcode)
  endif
  let char = s:nr2byte(a:charcode)
  if strlen(char) > 1
    let char = strtrans(iconv(char, 'utf-8', &encoding))
  endif
  return char
endfunction

function! s:nr2hex(nr)
  let n = a:nr
  let r = ""
  while n
    let r = '0123456789ABCDEF'[n % 16] . r
    let n = n / 16
  endwhile
  return r
endfunction

function! s:decodeEntityReference(str)
  let str = a:str
  let str = substitute(str, '&gt;', '>', 'g')
  let str = substitute(str, '&lt;', '<', 'g')
  "let str = substitute(str, '&quot;', '"', 'g')
  "let str = substitute(str, '&apos;', "'", 'g')
  "let str = substitute(str, '&nbsp;', ' ', 'g')
  "let str = substitute(str, '&yen;', '\&#65509;', 'g')
  let str = substitute(str, '&#x\([0-9a-fA-F]\+\);', '\=s:nr2enc_char("0x".submatch(1))', 'g')
  let str = substitute(str, '&#\(\d\+\);', '\=s:nr2enc_char(submatch(1))', 'g')
  let str = substitute(str, '&amp;', '\&', 'g')
  return str
endfunction

function! s:encodeEntityReference(str)
  let str = a:str
  let str = substitute(str, '&', '\&amp;', 'g')
  let str = substitute(str, '>', '\&gt;', 'g')
  let str = substitute(str, '<', '\&lt;', 'g')
  let str = substitute(str, '"', '\&#34;', 'g')
  "let str = substitute(str, "\n", '\&#x0d;', 'g')
  "let str = substitute(str, '"', '&quot;', 'g')
  "let str = substitute(str, "'", '&apos;', 'g')
  "let str = substitute(str, ' ', '&nbsp;', 'g')
  return str
endfunction

function! s:matchNode(node, cond)
  if type(a:cond) == 1 && a:node.name == a:cond
    return 1
  endif
  if type(a:cond) == 2
    return a:cond(a:node)
  endif
  if type(a:cond) == 3
    let ret = 1
    for r in a:cond
      if !s:matchNode(a:node, r) | let ret = 0 | endif
      unlet r
    endfor
    return ret
  endif
  if type(a:cond) == 4
    for k in keys(a:cond)
      if has_key(a:node.attr, k) && a:node.attr[k] == a:cond[k] | return 1 | endif
    endfor
  endif
  return 0
endfunction

function! s:template.childNode(...) dict
  for c in self.child
    if type(c) == 4 && s:matchNode(c, a:000)
      return c
    endif
    unlet c
  endfor
  return {}
endfunction

function! s:template.childNodes(...) dict
  let ret = []
  for c in self.child
    if type(c) == 4 && s:matchNode(c, a:000)
      let ret += [c]
    endif
    unlet c
  endfor
  return ret
endfunction

function! s:template.value(...) dict
  if a:0
    let self.child = a:000
    return
  endif
  let ret = ''
  for c in self.child
    if type(c) <= 1 || type(c) == 5
      let ret .= c
    elseif type(c) == 4
      let ret .= c.value()
    endif
    unlet c
  endfor
  return ret
endfunction

function! s:template.find(...) dict
  for c in self.child
    if type(c) == 4
      if s:matchNode(c, a:000)
        return c
      endif
      unlet! ret
      let ret = c.find(a:000)
      if !empty(ret)
        return ret
      endif
    endif
    unlet c
  endfor
  return {}
endfunction

function! s:template.findAll(...) dict
  let ret = []
  for c in self.child
    if type(c) == 4
      if s:matchNode(c, a:000)
        call add(ret, c)
      endif
      let ret += c.findAll(a:000)
    endif
    unlet c
  endfor
  return ret
endfunction

function! s:template.toString() dict
  let xml = '<' . self.name
  for attr in keys(self.attr)
    let xml .= ' ' . attr . '="' . s:encodeEntityReference(self.attr[attr]) . '"'
  endfor
  if len(self.child)
    let xml .= '>'
    for c in self.child
      if type(c) == 4
        let xml .= c.toString()
      elseif type(c) > 1
        let xml .= s:encodeEntityReference(string(c))
      else
        let xml .= s:encodeEntityReference(c)
      endif
      unlet c
    endfor
    let xml .= '</' . self.name . '>'
  else
    let xml .= ' />'
  endif
  return xml
endfunction

function! xml#createElement(name)
  let node = deepcopy(s:template)
  let node.name = a:name
  return node
endfunction

function! s:parse_tree(ctx, top)
  let node = a:top
  let stack = [a:top]
  let pos = 0
  " content accumulates the text only tags
  let content = ""
  let append_content_to_parent = 'if len(stack) && content != "" | call add(stack[-1].child, content) | let content ="" | endif'

  let mx = '^\s*\(<?xml[^>]\+>\)'
  if a:ctx['xml'] =~ mx
    let match = matchstr(a:ctx['xml'], mx)
    let a:ctx['xml'] = a:ctx['xml'][stridx(a:ctx['xml'], match) + len(match):]
    let mx = 'encoding\s*=\s*["'']\{0,1}\([^"'' \t]\+\|[^"'']\+\)["'']\{0,1}'
    let matches = matchlist(match, mx)
    if len(matches)
      let encoding = matches[1]
      if len(encoding) && len(a:ctx['encoding']) == 0
        let a:ctx['encoding'] = encoding
        let a:ctx['xml'] = iconv(a:ctx['xml'], encoding, &encoding)
      endif
    endif
  endif

  " this regex matches
  " 1) the remaining until the next tag begins
  "    2) maybe closing "/" of tag name
  "    3)  tagname
  "    4) the attributes of the text (optional)
  "    5) maybe closing "/" (end of tag name)
  " or
  "    6) CDATA or ''
  "    7) text content of CDATA
  " 8) the remaining text after the tag (rest)
  " (These numbers correspond to the indexes in matched list m)
  "let tag_mx = '^\(\_.\{-}\)\%(\%(<\(/\?\)\([^ !/\t\r\n>]\+\)\(\%([ \t\r\n]*[^ />\t\r\n=]\+[ \t\r\n]*\%(=[ \t\r\n]*\%([^"'' >\t]\+\|"[^"]*"\|''[^'']*''\)\)\)*\)[ \t\r\n]*\(/\?\)>\)\|\%(<!\[\(CDATA\)\[\(.\{-}\)\]\]>\)\|\(<!--.\{-}-->\)\)\(.*\)'
  let tag_mx = '^\(\_.\{-}\)\%(\%(<\(/\?\)\([^ !/\t\r\n>]\+\)\(\%([ \t\r\n]*[^ />\t\r\n=]\+[ \t\r\n]*=[ \t\r\n]*\%([^"'' >\t]\+\|"[^"]*"\|''[^'']*''\)\|[ \t\r\n]\+[^ />\t\r\n=]\+[ \t\r\n]*\)*\)[ \t\r\n]*\(/\?\)>\)\|\%(<!\[\(CDATA\)\[\(.\{-}\)\]\]>\)\|\(<!--.\{-}-->\)\)\(.*\)'

  while len(a:ctx['xml']) > 0
    let m = matchlist(a:ctx.xml, tag_mx)
    if empty(m) | break | endif
    let is_end_tag = m[2] == '/' && m[5] == ''
    let is_start_and_end_tag = m[2] == '' && m[5] == '/'
    let tag_name = m[3]
    let attrs = m[4]

    if len(m[1])
      let content .= s:decodeEntityReference(m[1])
    endif

    if is_end_tag
      " closing tag: pop from stack and continue at upper level
      exec append_content_to_parent

      if len(stack) " TODO: checking whether opened tag is exist. 
        call remove(stack, -1)
      endif
      let a:ctx['xml'] = m[9]
      continue
    endif

    " comment tag
    if m[8] != ''
        let a:ctx.xml = m[9]
        continue
    endif

    " if element is a CDATA
    if m[6] != ''
        let content .= m[7]
        let a:ctx.xml = m[9]
        continue
    endif

    let node = deepcopy(s:template)
    let node.name = tag_name
    let attr_mx = '\([^ \t\r\n=]\+\)\s*\%(=\s*''\([^'']*\)''\|=\s*"\([^"]*\)"\|=\s*\(\w\+\)\|\)'
    while len(attrs) > 0
      let attr_match = matchlist(attrs, attr_mx)
      if len(attr_match) == 0
        break
      endif
      let name = attr_match[1]
      let value = len(attr_match[2]) ? attr_match[2] : len(attr_match[3]) ? attr_match[3] : len(attr_match[4]) ? attr_match[4] : ""
      if value == ""
        let value = name
      endif
      let node.attr[name] = s:decodeEntityReference(value)
      let attrs = attrs[stridx(attrs, attr_match[0]) + len(attr_match[0]):]
    endwhile

    exec append_content_to_parent

    if len(stack)
      call add(stack[-1].child, node)
    endif
    if !is_start_and_end_tag
      " opening tag, continue parsing its contents
      call add(stack, node)
    endif
    let a:ctx['xml'] = m[9]
  endwhile
endfunction

function! xml#parse(xml)
  let top = deepcopy(s:template)
  let oldmaxmempattern=&maxmempattern
  let oldmaxfuncdepth=&maxfuncdepth
  let &maxmempattern=2000000
  let &maxfuncdepth=2000
  "try
    call s:parse_tree({'xml': a:xml, 'encoding': ''}, top)
    for node in top.child
      if type(node) == 4
        return node
      endif
      unlet node
    endfor
  "catch /.*/
  "endtry
  let &maxmempattern=oldmaxmempattern
  let &maxfuncdepth=oldmaxfuncdepth
  throw "Parse Error"
endfunction

function! xml#parseFile(fname)
  return xml#parse(join(readfile(a:fname), "\n"))
endfunction

function! xml#parseURL(url)
  return xml#parse(http#get(a:url).content)
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo

" vim:set et:
