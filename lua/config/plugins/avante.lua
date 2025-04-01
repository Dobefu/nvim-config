local avante_lib = require('avante_lib')
local avante = require('avante')

avante_lib.load()

avante.setup({
  provider = 'groq',
  vendors = {
    groq = {
      __inherited_from = 'openai',
      api_key_name = 'GROQ_API_KEY',
      endpoint = 'https://api.groq.com/openai/v1/',
      model = 'llama-3.1-70b-versatile',
    },
  }
})
