import { HttpErrorResponse, HttpEvent, HttpHandler, HttpInterceptor, HttpRequest } from "@angular/common/http";
import { ErrorHandler, inject, Injectable } from "@angular/core"
import { catchError, Observable, throwError } from "rxjs";
import { LoggerService } from "../services/logger.service";

@Injectable({
  providedIn: "root"
})
export class HttpErrorInterceptor implements HttpInterceptor {
  private errorHandler = inject(ErrorHandler)
  // private loggerService = inject(LoggerService)
  // private logger = this.loggerService.getLogger("HttpErrorInterceptor")
  intercept<T>(req: HttpRequest<T>, next: HttpHandler): Observable<HttpEvent<T>> {
    // this.logger.error("Error request ", req)
    return next.handle(req).pipe(
      catchError((error: HttpErrorResponse) => {
        this.errorHandler.handleError(error);
        return throwError(() => error);
      })
    )
  }
}
