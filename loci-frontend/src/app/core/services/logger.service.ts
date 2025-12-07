/* eslint-disable @typescript-eslint/no-explicit-any */
import { Injectable, isDevMode } from '@angular/core';
import { environment } from '../../../environments/environments';

// Define LogLevel if not already present
export enum LogLevel {
  Debug = 0,
  Info = 1,
  Warn = 2,
  Error = 3
}

@Injectable({ providedIn: 'root' })
export class LoggerService {
  private minLevel: LogLevel = environment.production ? LogLevel.Warn : LogLevel.Debug;

  private shouldLog(level: LogLevel): boolean {
    return level >= this.minLevel;
  }

  /**
   * Safely serializes any value to a string with circular reference handling
   */
  private serializeParam(param: any): string {
    if (param === null || param === undefined) return String(param);
    if (typeof param === 'string') return param;
    if (param instanceof Error) return param.stack || param.message;
    if (typeof param === 'function') return `[Function: ${param.name || 'anonymous'}]`;

    try {
      const seen = new WeakSet();
      return JSON.stringify(
        param,
        (key, value) => {
          if (typeof value === 'object' && value !== null) {
            if (seen.has(value)) return '[Circular]';
            seen.add(value);
          }
          return value;
        },
        2 // Pretty print
      );
    } catch {
      return `[Unserializable: ${String(param)}]`;
    }
  }

  private formatMessage(level: string, context: string, message: string): string {
    const timestamp = new Date().toISOString().slice(11, 23);
    return `${timestamp} ${level.padEnd(5)} [${context}] ${message}`;
  }

  getLogger(context = 'App') {
    const logger = {
      debug: (message: string, ...optionalParams: any[]) => {
        if (this.shouldLog(LogLevel.Debug)) {
          const cssStyle = 'color: #8a8a8a; font-weight: bold;';
          const formatted = this.formatMessage('DEBUG', context, message);

          // Serialize params in production, keep objects in dev for inspection
          const params = environment.production
            ? optionalParams.map(p => this.serializeParam(p))
            : optionalParams;

          console.debug(`%c${formatted}`, cssStyle, ...params);
        }
      },

      info: (message: string, ...optionalParams: any[]) => {
        if (this.shouldLog(LogLevel.Info)) {
          const cssStyle = 'color: #33ab33; font-weight: bold;';
          const formatted = this.formatMessage('INFO', context, message);
          const params = environment.production ? optionalParams.map(p => this.serializeParam(p)) : optionalParams;
          console.info(`%c${formatted}`, cssStyle, ...params);
        }
      },

      warn: (message: string, ...optionalParams: any[]) => {
        if (this.shouldLog(LogLevel.Warn)) {
          const cssStyle = 'color: #ff8c00; font-weight: bold;';
          const formatted = this.formatMessage('WARN', context, message);
          const params = environment.production ? optionalParams.map(p => this.serializeParam(p)) : optionalParams;
          console.warn(`%c${formatted}`, cssStyle, ...params);
        }
      },

      // Fixed signature to match other methods
      error: (message: string, ...optionalParams: any[]) => {
        if (this.shouldLog(LogLevel.Error)) {
          const cssStyle = 'color: #ff3333; font-weight: bold;';
          const formatted = this.formatMessage('ERROR', context, message);

          // Always serialize errors to capture stack traces
          const params = optionalParams.map(p =>
            p instanceof Error ? (p.stack || p.message) :
            environment.production ? this.serializeParam(p) : p
          );

          console.error(`%c${formatted}`, cssStyle, ...params);
        }
      }
    };

    return logger;
  }
}
