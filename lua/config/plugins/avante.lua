local avante_lib = require('avante_lib')
local avante = require('avante')

avante_lib.load()

avante.setup({
  provider = 'local_server',
  auto_suggestions_provider = 'local_server',
  vendors = {
    groq = {
      __inherited_from = 'openai',
      api_key_name = 'GROQ_API_KEY',
      endpoint = 'https://api.groq.com/openai/v1/',
      model = 'deepseek-r1-distill-llama-70b',
    },
    local_server = {
      __inherited_from = 'openai',
      api_key_name = '',
      endpoint = 'http://127.0.0.1:1234/v1',
    },
  },
  behaviour = {
    auto_suggestions = true,
  },
  -- rag_service = {
  --   enabled = true,
  --   host_mount = os.getenv('HOME'),
  --   provider = 'local_server',
  --   llm_model = '',
  --   embed_model = '',
  --   endpoint = 'https://api.groq.com/openai/v1',
  -- },
})
