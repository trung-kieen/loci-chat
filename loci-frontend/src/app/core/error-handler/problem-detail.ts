
export interface ProblemDetail {
  type: string;
  title: string;
  status: number;
  detail: string;
  instance?: string;
  errorCode?: string;
  [key: string]: unknown; // For custom properties like 'errors', 'entityType'
}
