export type Json =
  | string
  | number
  | boolean
  | null
  | { [key: string]: Json | undefined }
  | Json[]

export type Database = {
  graphql_public: {
    Tables: {
      [_ in never]: never
    }
    Views: {
      [_ in never]: never
    }
    Functions: {
      graphql: {
        Args: {
          extensions?: Json
          operationName?: string
          query?: string
          variables?: Json
        }
        Returns: Json
      }
    }
    Enums: {
      [_ in never]: never
    }
    CompositeTypes: {
      [_ in never]: never
    }
  }
  public: {
    Tables: {
      answers: {
        Row: {
          player_id: string
          round_id: string
          submitted_at: string
          value: number
        }
        Insert: {
          player_id: string
          round_id: string
          submitted_at?: string
          value: number
        }
        Update: {
          player_id?: string
          round_id?: string
          submitted_at?: string
          value?: number
        }
        Relationships: [
          {
            foreignKeyName: "answers_round_id_fkey"
            columns: ["round_id"]
            isOneToOne: false
            referencedRelation: "rounds"
            referencedColumns: ["id"]
          },
        ]
      }
      players: {
        Row: {
          id: string
          joined_at: string
          last_seen_at: string
          nickname: string
          room_id: string
          score: number
        }
        Insert: {
          id: string
          joined_at?: string
          last_seen_at?: string
          nickname: string
          room_id: string
          score?: number
        }
        Update: {
          id?: string
          joined_at?: string
          last_seen_at?: string
          nickname?: string
          room_id?: string
          score?: number
        }
        Relationships: [
          {
            foreignKeyName: "players_room_id_fkey"
            columns: ["room_id"]
            isOneToOne: false
            referencedRelation: "rooms"
            referencedColumns: ["id"]
          },
        ]
      }
      question_seen: {
        Row: {
          player_id: string
          question_id: string
          seen_at: string
        }
        Insert: {
          player_id: string
          question_id: string
          seen_at?: string
        }
        Update: {
          player_id?: string
          question_id?: string
          seen_at?: string
        }
        Relationships: [
          {
            foreignKeyName: "question_seen_question_id_fkey"
            columns: ["question_id"]
            isOneToOne: false
            referencedRelation: "questions"
            referencedColumns: ["id"]
          },
        ]
      }
      questions: {
        Row: {
          answer: number
          as_of_year: number
          created_at: string
          difficulty: number
          id: string
          prompt: string
          source_name: string
          source_url: string
          status: string
          theme: string
          unit: string | null
        }
        Insert: {
          answer: number
          as_of_year: number
          created_at?: string
          difficulty?: number
          id?: string
          prompt: string
          source_name: string
          source_url: string
          status?: string
          theme: string
          unit?: string | null
        }
        Update: {
          answer?: number
          as_of_year?: number
          created_at?: string
          difficulty?: number
          id?: string
          prompt?: string
          source_name?: string
          source_url?: string
          status?: string
          theme?: string
          unit?: string | null
        }
        Relationships: []
      }
      rooms: {
        Row: {
          answer_seconds: number
          code: string
          created_at: string
          expires_at: string
          host_player_id: string
          id: string
          rounds_total: number
          status: string
          themes: string[]
        }
        Insert: {
          answer_seconds?: number
          code: string
          created_at?: string
          expires_at?: string
          host_player_id: string
          id?: string
          rounds_total?: number
          status?: string
          themes?: string[]
        }
        Update: {
          answer_seconds?: number
          code?: string
          created_at?: string
          expires_at?: string
          host_player_id?: string
          id?: string
          rounds_total?: number
          status?: string
          themes?: string[]
        }
        Relationships: [
          {
            foreignKeyName: "rooms_host_player_fk"
            columns: ["id", "host_player_id"]
            isOneToOne: false
            referencedRelation: "players"
            referencedColumns: ["room_id", "id"]
          },
        ]
      }
      rounds: {
        Row: {
          answers_count: number
          closed_at: string | null
          ends_at: string
          id: string
          index: number
          question_id: string
          question_prompt: string
          question_theme: string
          question_unit: string | null
          revealed_answer: number | null
          revealed_as_of_year: number | null
          revealed_source_name: string | null
          revealed_source_url: string | null
          room_id: string
          started_at: string
          status: string
        }
        Insert: {
          answers_count?: number
          closed_at?: string | null
          ends_at: string
          id?: string
          index: number
          question_id: string
          question_prompt: string
          question_theme: string
          question_unit?: string | null
          revealed_answer?: number | null
          revealed_as_of_year?: number | null
          revealed_source_name?: string | null
          revealed_source_url?: string | null
          room_id: string
          started_at?: string
          status?: string
        }
        Update: {
          answers_count?: number
          closed_at?: string | null
          ends_at?: string
          id?: string
          index?: number
          question_id?: string
          question_prompt?: string
          question_theme?: string
          question_unit?: string | null
          revealed_answer?: number | null
          revealed_as_of_year?: number | null
          revealed_source_name?: string | null
          revealed_source_url?: string | null
          room_id?: string
          started_at?: string
          status?: string
        }
        Relationships: [
          {
            foreignKeyName: "rounds_question_id_fkey"
            columns: ["question_id"]
            isOneToOne: false
            referencedRelation: "questions"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "rounds_room_id_fkey"
            columns: ["room_id"]
            isOneToOne: false
            referencedRelation: "rooms"
            referencedColumns: ["id"]
          },
        ]
      }
    }
    Views: {
      [_ in never]: never
    }
    Functions: {
      can_read_answer: { Args: { p_round_id: string }; Returns: boolean }
      close_round: {
        Args: { p_round_id: string }
        Returns: {
          answers_count: number
          closed_at: string | null
          ends_at: string
          id: string
          index: number
          question_id: string
          question_prompt: string
          question_theme: string
          question_unit: string | null
          revealed_answer: number | null
          revealed_as_of_year: number | null
          revealed_source_name: string | null
          revealed_source_url: string | null
          room_id: string
          started_at: string
          status: string
        }
        SetofOptions: {
          from: "*"
          to: "rounds"
          isOneToOne: true
          isSetofReturn: false
        }
      }
      create_room: {
        Args: {
          p_answer_seconds?: number
          p_nickname: string
          p_rounds_total?: number
          p_themes?: string[]
        }
        Returns: {
          answer_seconds: number
          code: string
          created_at: string
          expires_at: string
          host_player_id: string
          id: string
          rounds_total: number
          status: string
          themes: string[]
        }
        SetofOptions: {
          from: "*"
          to: "rooms"
          isOneToOne: true
          isSetofReturn: false
        }
      }
      is_room_member: { Args: { p_room_id: string }; Returns: boolean }
      join_room: {
        Args: { p_nickname: string; p_room_code: string }
        Returns: {
          answer_seconds: number
          code: string
          created_at: string
          expires_at: string
          host_player_id: string
          id: string
          rounds_total: number
          status: string
          themes: string[]
        }
        SetofOptions: {
          from: "*"
          to: "rooms"
          isOneToOne: true
          isSetofReturn: false
        }
      }
      server_now: { Args: never; Returns: string }
      start_round: {
        Args: { p_room_id: string }
        Returns: {
          answers_count: number
          closed_at: string | null
          ends_at: string
          id: string
          index: number
          question_id: string
          question_prompt: string
          question_theme: string
          question_unit: string | null
          revealed_answer: number | null
          revealed_as_of_year: number | null
          revealed_source_name: string | null
          revealed_source_url: string | null
          room_id: string
          started_at: string
          status: string
        }
        SetofOptions: {
          from: "*"
          to: "rounds"
          isOneToOne: true
          isSetofReturn: false
        }
      }
      submit_answer: {
        Args: { p_round_id: string; p_value: number }
        Returns: {
          player_id: string
          round_id: string
          submitted_at: string
          value: number
        }
        SetofOptions: {
          from: "*"
          to: "answers"
          isOneToOne: true
          isSetofReturn: false
        }
      }
    }
    Enums: {
      [_ in never]: never
    }
    CompositeTypes: {
      [_ in never]: never
    }
  }
}

type DatabaseWithoutInternals = Omit<Database, "__InternalSupabase">

type DefaultSchema = DatabaseWithoutInternals[Extract<keyof Database, "public">]

export type Tables<
  DefaultSchemaTableNameOrOptions extends
    | keyof (DefaultSchema["Tables"] & DefaultSchema["Views"])
    | { schema: keyof DatabaseWithoutInternals },
  TableName extends DefaultSchemaTableNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof (DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"] &
        DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Views"])
    : never = never,
> = DefaultSchemaTableNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? (DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"] &
      DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Views"])[TableName] extends {
      Row: infer R
    }
    ? R
    : never
  : DefaultSchemaTableNameOrOptions extends keyof (DefaultSchema["Tables"] &
        DefaultSchema["Views"])
    ? (DefaultSchema["Tables"] &
        DefaultSchema["Views"])[DefaultSchemaTableNameOrOptions] extends {
        Row: infer R
      }
      ? R
      : never
    : never

export type TablesInsert<
  DefaultSchemaTableNameOrOptions extends
    | keyof DefaultSchema["Tables"]
    | { schema: keyof DatabaseWithoutInternals },
  TableName extends DefaultSchemaTableNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"]
    : never = never,
> = DefaultSchemaTableNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"][TableName] extends {
      Insert: infer I
    }
    ? I
    : never
  : DefaultSchemaTableNameOrOptions extends keyof DefaultSchema["Tables"]
    ? DefaultSchema["Tables"][DefaultSchemaTableNameOrOptions] extends {
        Insert: infer I
      }
      ? I
      : never
    : never

export type TablesUpdate<
  DefaultSchemaTableNameOrOptions extends
    | keyof DefaultSchema["Tables"]
    | { schema: keyof DatabaseWithoutInternals },
  TableName extends DefaultSchemaTableNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"]
    : never = never,
> = DefaultSchemaTableNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"][TableName] extends {
      Update: infer U
    }
    ? U
    : never
  : DefaultSchemaTableNameOrOptions extends keyof DefaultSchema["Tables"]
    ? DefaultSchema["Tables"][DefaultSchemaTableNameOrOptions] extends {
        Update: infer U
      }
      ? U
      : never
    : never

export type Enums<
  DefaultSchemaEnumNameOrOptions extends
    | keyof DefaultSchema["Enums"]
    | { schema: keyof DatabaseWithoutInternals },
  EnumName extends DefaultSchemaEnumNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof DatabaseWithoutInternals[DefaultSchemaEnumNameOrOptions["schema"]]["Enums"]
    : never = never,
> = DefaultSchemaEnumNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? DatabaseWithoutInternals[DefaultSchemaEnumNameOrOptions["schema"]]["Enums"][EnumName]
  : DefaultSchemaEnumNameOrOptions extends keyof DefaultSchema["Enums"]
    ? DefaultSchema["Enums"][DefaultSchemaEnumNameOrOptions]
    : never

export type CompositeTypes<
  PublicCompositeTypeNameOrOptions extends
    | keyof DefaultSchema["CompositeTypes"]
    | { schema: keyof DatabaseWithoutInternals },
  CompositeTypeName extends PublicCompositeTypeNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof DatabaseWithoutInternals[PublicCompositeTypeNameOrOptions["schema"]]["CompositeTypes"]
    : never = never,
> = PublicCompositeTypeNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? DatabaseWithoutInternals[PublicCompositeTypeNameOrOptions["schema"]]["CompositeTypes"][CompositeTypeName]
  : PublicCompositeTypeNameOrOptions extends keyof DefaultSchema["CompositeTypes"]
    ? DefaultSchema["CompositeTypes"][PublicCompositeTypeNameOrOptions]
    : never

export const Constants = {
  graphql_public: {
    Enums: {},
  },
  public: {
    Enums: {},
  },
} as const

