package com.loci.loci_backend.common.websocket.infrastructure.primary.handler;

import java.io.IOException;

import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.WebSocketSession;

import lombok.extern.log4j.Log4j2;

// TODO:
@Log4j2
@Component
public class WebSocketGlobalErrorHandler {

  // @Override
  // public void handleError(WebSocketSession session, Throwable exception) {
  // log.error("WebSocket Error: ", exception);
  //
  // if (session.isOpen()) {
  // try {
  // session.close(CloseStatus.SERVER_ERROR);
  // } catch (IOException e) {
  // log.error("Error closing WebSocket session", e);
  // }
  // }
  // }
}
