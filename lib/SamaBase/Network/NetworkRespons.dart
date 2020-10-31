class NetworkResponse<T> {
  Status status;
  T data;
  String message;

  NetworkResponse.loading(this.message) : status = Status.LOADING;
  NetworkResponse.completed(this.data) : status = Status.COMPLETED;
  NetworkResponse.error(this.message) : status = Status.ERROR;
  NetworkResponse.unauthorised(this.message) : status = Status.Unauthorised;

  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data : $data";
  }
}

enum Status { LOADING, COMPLETED, ERROR, Unauthorised }
