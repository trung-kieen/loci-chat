package com.loci.loci_backend.common.validation.domain;

public class NotEnoughElementsException extends AssertionException {

  private final String field;
  private final String currentSize;
  private final String minSize;

  public NotEnoughElementsException(NotEnoughElementsExceptionBuilder builder) {
    super(builder.field, builder.message());
    this.field = builder.field;
    this.minSize = String.valueOf(builder.minSize);
    this.currentSize = String.valueOf(builder.currentSize);
  }

  public static class NotEnoughElementsExceptionBuilder {
    private String field;
    private int currentSize;
    private int minSize;

    public NotEnoughElementsExceptionBuilder field(String field) {
      this.field = field;
      return this;
    }

    public NotEnoughElementsExceptionBuilder currentSize(int currentSize) {
      this.currentSize = currentSize;
      return this;
    }

    public NotEnoughElementsExceptionBuilder minSize(int minSize) {
      this.minSize = minSize;
      return this;
    }

    public NotEnoughElementsException build() {
      return new NotEnoughElementsException(this);
    }

    public String message() {
      return new StringBuilder().append("Size of collection \"")
          .append(field)
          .append("\" must at least ")
          .append(minSize)
          .append(" but was ")
          .append(currentSize)
          .toString();
    }

  }

  public static NotEnoughElementsExceptionBuilder builder() {
    return new NotEnoughElementsExceptionBuilder();
  }

  @Override
  public AssertionErrorType type() {
    return AssertionErrorType.NOT_ENOUGH_ELEMENTS;
  }
}
