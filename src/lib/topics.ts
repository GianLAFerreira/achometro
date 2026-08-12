// Taxonomia fixa de tópicos — fonte única, mesmo princípio de lib/motion.ts
// pros presets de animação. Qualquer pergunta nova (manual ou via agente
// curador-perguntas) usa um destes valores em `questions.theme`. Ver
// também o comentário no topo de supabase/seed.sql.
//
// "Conhecimentos Gerais" NÃO está nesta lista — não é um valor de tema
// real. `rooms.themes = '{}'` (array vazio) já significa "qualquer tema"
// no servidor (start_round); o seletor de tópicos usa isso direto, sem
// precisar marcar nenhuma pergunta como "geral".
export interface Topic {
  value: string
  label: string
}

export const TOPICS: Topic[] = [
  { value: 'futebol', label: 'Futebol' },
  { value: 'geografia', label: 'Geografia' },
  { value: 'historia', label: 'História' },
  { value: 'brasil', label: 'Brasil' },
  { value: 'corpo-humano', label: 'Corpo Humano' },
  { value: 'cultura', label: 'Cultura' },
  { value: 'animais', label: 'Animais' },
]

export const GENERAL_TOPIC_LABEL = 'Conhecimentos Gerais'
