import { StrictMode } from 'react'
import { createRoot } from 'react-dom/client'
import './index.css'
import App from './App.tsx'
import { ensureSession } from './lib/session.ts'
import { installGlobalErrorLogging } from './lib/clientErrorLog.ts'

installGlobalErrorLogging()

const rootElement = document.getElementById('root')!
const root = createRoot(rootElement)

// A sessão anônima resolve ANTES do primeiro render — ver o porquê em
// lib/session.ts. Nenhum componente assina um canal Realtime antes disto.
ensureSession()
  .then((playerId) => {
    root.render(
      <StrictMode>
        <App playerId={playerId} />
      </StrictMode>,
    )
  })
  .catch((error: unknown) => {
    console.error(error)
    root.render(
      <main className="flex min-h-screen flex-col items-center justify-center gap-2 px-6 text-center">
        <p className="font-body text-mostrador">Não consegui iniciar sua sessão.</p>
        <p className="font-body text-sm text-mostrador/70">Recarregue a página.</p>
      </main>,
    )
  })
