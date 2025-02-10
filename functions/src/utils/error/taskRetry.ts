export class TaskRetryError extends Error {
  constructor(message: string) {
    super(message);
    this.name = "TaskRetryError";
  }
}
