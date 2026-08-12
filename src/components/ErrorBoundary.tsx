import { Component } from 'react'
import type { ReactNode } from 'react'
import { Note } from './Note'

interface ErrorBoundaryProps {
  children: ReactNode
}

interface ErrorBoundaryState {
  error: Error | null
}

export class ErrorBoundary extends Component<ErrorBoundaryProps, ErrorBoundaryState> {
  state: ErrorBoundaryState = { error: null }

  static getDerivedStateFromError(error: Error): ErrorBoundaryState {
    return { error }
  }

  componentDidCatch(error: Error): void {
    console.error(error)
  }

  render() {
    if (this.state.error) {
      return (
        <div className="flex min-h-screen items-center justify-center px-6 text-center">
          <Note tone="erro">Algo quebrou. Recarregue a página.</Note>
        </div>
      )
    }
    return this.props.children
  }
}
