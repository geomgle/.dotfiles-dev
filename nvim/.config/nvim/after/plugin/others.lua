-- GnuPG
vim.g.GPGExecutable = "gpg2 --trust-model always"

-- Calendar
vim.g.calendar_first_day = "sunday"
vim.g.calendar_google_calendar = 1
vim.g.calendar_skip_event_delete_confirm = 1
vim.g.calendar_date_endian = "big"
vim.keymap.set("n", "<leader>wc", "<Plug>(calendar)")
vim.cmd [[
  source ~/.cache/calendar.vim/credentials.vim
  au FileType calendar nmap <buffer> <left> <Plug>(calendar_view_left)
  au FileType calendar nmap <buffer> <right> <Plug>(calendar_view_right)
  au FileType calendar nmap <buffer> e <Plug>(calendar_event)
  au FileType calendar nmap <buffer> i <Plug>(calendar_start_insert_quick)
  au FileType calendar nmap <buffer> <C-d> <Plug>(calendar_exit)
]]
