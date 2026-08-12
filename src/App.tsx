import { useRoute } from './lib/router'
import { ErrorBoundary } from './components/ErrorBoundary'
import { HomeScreen } from './screens/HomeScreen'
import { RoomScreen } from './screens/RoomScreen'

interface AppProps {
  playerId: string
}

function App({ playerId }: AppProps) {
  const route = useRoute()

  return (
    <ErrorBoundary>
      <main className="min-h-screen px-6 py-10 sm:px-10">
        {route.name === 'home' ? (
          <HomeScreen />
        ) : (
          <RoomScreen code={route.code} playerId={playerId} />
        )}
      </main>
    </ErrorBoundary>
  )
}

export default App
