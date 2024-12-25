let s:vim_ai_endpoint_url = "http://localhost:11434/v1/chat/completions"
let s:vim_ai_model = "qwen2.5-coder:7b"
let s:vim_ai_temperature = 0.3

let s:vim_ai_chat_config = #{
\  engine: "chat",
\  options: #{
\    model: s:vim_ai_model,
\    temperature: s:vim_ai_temperature,
\    endpoint_url: s:vim_ai_endpoint_url,
\    enable_auth: 0,
\    max_tokens: 0,
\    request_timeout: 60,
\  },
\  ui: #{
\    code_syntax_enabled: 1,
\  },
\}

let s:vim_ai_edit_config = #{
\  engine: "chat",
\  options: #{
\    model: s:vim_ai_model,
\    temperature: s:vim_ai_temperature,
\    endpoint_url: s:vim_ai_endpoint_url,
\    enable_auth: 0,
\    max_tokens: 0,
\    request_timeout: 60,
\  },
\  ui: #{
\    paste_mode: 1,
\  },
\}

let g:vim_ai_chat = s:vim_ai_chat_config
let g:vim_ai_complete = s:vim_ai_edit_config
let g:vim_ai_edit = s:vim_ai_edit_config
