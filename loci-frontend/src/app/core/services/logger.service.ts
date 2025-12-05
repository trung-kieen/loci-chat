/* eslint-disable @typescript-eslint/no-explicit-any */
import { Injectable, isDevMode } from '@angular/core';
import { environment } from '../../../environments/environments';

export enum LogLevel {
  Debug = 0,
  Info = 1,
  Warn = 2,
  Error = 3,
  Off = 4,
}

@Injectable()
export class LoggerService {
  private minLevel: LogLevel = environment.production ? LogLevel.Warn : LogLevel.Debug;

  private shouldLog(level: LogLevel): boolean {
    return level >= this.minLevel;
  }

  private formatMessage(level: string, context: string, message: string, color: string): string {
    const timestamp = new Date().toISOString().slice(11, 23); // HH:mm:ss.sss
    return `%c${timestamp} ${level.padEnd(5)} [${context}] ${message}`;
  }

  getLogger(context = 'App') {
    const logger = {
      debug: (message: string, ...optionalParams: any[]) => {
        if (this.shouldLog(LogLevel.Debug)) {
          console.debug(
            this.formatMessage('DEBUG', context, message, 'color: #8a8a8a; font-weight: bold'),
            ...optionalParams
          );
        }
      },

      info: (message: string, ...optionalParams: any[]) => {
        if (this.shouldLog(LogLevel.Info)) {
          console.info(
            this.formatMessage('INFO', context, message, 'color: #33ab33; font-weight: bold'),
            ...optionalParams
          );
        }
      },

      warn: (message: string, ...optionalParams: any[]) => {
        if (this.shouldLog(LogLevel.Warn)) {
          console.warn(
            this.formatMessage('WARN', context, message, 'color: #ff8c00; font-weight: bold'),
            ...optionalParams
          );
        }
      },

      error: (message: string, error?: any, ...optionalParams: any[]) => {
        if (this.shouldLog(LogLevel.Error)) {
          console.error(
            this.formatMessage('ERROR', context, message, 'color: #ff3333; font-weight: bold'),
            error || '',
            ...optionalParams
          );

        }
      }
    };

    return logger;
  }
}
