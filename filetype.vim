	if exists("did_load_filetypes")
	  finish
	endif
	augroup filetypedetect
	  au! BufRead,BufNewFile *.ncfg		setfiletype groovy
	  au! BufRead,BufNewFile *.bjd		setfiletype groovy
	augroup END
