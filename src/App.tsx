import { AnimatePresence, motion } from 'motion/react'
import { useRoute } from './lib/router'
import { ErrorBoundary } from './components/ErrorBoundary'
import { HomeScreen } from './screens/HomeScreen'
import { RoomScreen } from './screens/RoomScreen'
import { FADE_TRANSITION, useReducedMotion } from './lib/motion'

interface AppProps {
  playerId: string
}

function App({ playerId }: AppProps) {
  const route = useRoute()
  const reduceMotion = useReducedMotion()
  const routeKey = route.name === 'home' ? 'home' : route.code

  return (
    <ErrorBoundary>
      <main className="mx-auto min-h-screen w-full max-w-2xl px-6 pt-10 pb-[max(2.5rem,env(safe-area-inset-bottom))] sm:px-10">
        <AnimatePresence mode="wait">
          <motion.div
            key={routeKey}
            initial={reduceMotion ? false : { opacity: 0 }}
            animate={{ opacity: 1 }}
            exit={reduceMotion ? undefined : { opacity: 0 }}
            transition={FADE_TRANSITION}
          >
            {route.name === 'home' ? (
              <HomeScreen />
            ) : (
              <RoomScreen code={route.code} playerId={playerId} />
            )}
          </motion.div>
        </AnimatePresence>
      </main>
    </ErrorBoundary>
  )
}

export default App
