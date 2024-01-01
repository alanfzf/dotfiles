-- au BufRead,BufNewFile Jenkinsfile set filetype=groovy
vim.filetype.add({ pattern = { ['jenkinsfile'] = 'groovy'} })
